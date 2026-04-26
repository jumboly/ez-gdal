# リリース・ビルド手順（メンテナ向け）

ezgdal の利用者向けインストール手順は [`README.md`](../README.md) を参照。本ドキュメントはリポジトリで開発・配布する側の手順をまとめたもの。

## リリースは GitHub Actions で自動化されている

NuGet.org への publish は **`v*` tag を push すると `.github/workflows/release.yml` が自動的に走る**。ローカルの laptop から `dotnet nuget push` する経路は採らない。理由:

- 4 RID 分 (osx-arm64 / linux-x64 / linux-arm64 / win-x64) のクロスプラットフォーム検証は実機 CI runner でしか担保できない (ローカルはクロスビルドのみ)
- glibc 互換問題は Linux runner の OS バージョン固定で担保 (`ubuntu-22.04` で Debian 12 / Ubuntu 22.04 LTS 互換)
- API key を laptop に置かず GitHub Secret に閉じ込める
- tag → 公開を 1:1 に紐付けて再現性を担保

## 2 回目以降のリリース手順

```bash
# 1. csproj の <Version> をバンプ
sed -i.bak 's|<Version>1.0.0</Version>|<Version>1.0.1</Version>|' src/EzGdal/EzGdal.csproj
rm src/EzGdal/EzGdal.csproj.bak

# 2. commit (release.yml が tag と csproj <Version> の一致を検査するので両者を必ずバンプ)
git add src/EzGdal/EzGdal.csproj
git commit -m "release: v1.0.1"
git push origin main

# 3. tag を push → release.yml が pack → 4 RID verify → publish 待機
git tag v1.0.1 -a -m "v1.0.1"
git push origin v1.0.1

# 4. GitHub Actions タブで release run を確認
gh run watch                # 進行中の run を tail
gh run list --workflow=release.yml --limit 3

# 5. publish ジョブが Environment "nuget" の reviewer 待ちで pending になる
#    GitHub web の Actions → 該当 run → publish job で "Approve and run" を押す
#    すると 4 nupkg が NuGet.org に push される

# 6. インデックスは 5〜30 分のラグあり
for rid in osx-arm64 linux-x64 linux-arm64 win-x64; do
  url="https://api.nuget.org/v3-flatcontainer/jumboly.ezgdal.$rid/index.json"
  curl -s "$url" | grep -q '"1.0.1"' && echo "$rid: OK" || echo "$rid: pending"
done
```

`release.yml` は 3 段構成:

1. **pack** (2 並列ジョブ): `pack-linux` (ubuntu-22.04) で 3 RID (osx-arm64 / linux-x64 / linux-arm64)、`pack-windows` (windows-2022) で win-x64 + sdk/ 同梱 (`scripts/win-sdk/generate-sdk.ps1` 経由) を pack → artifact 化
2. **verify** (5 OS マトリクス): artifact を download → `dotnet tool install` → smoke (`ezgdal --version` / `raster --formats`) → DriverProbe
3. **publish** (ubuntu-22.04, environment=`nuget`): reviewer 承認後に `dotnet nuget push --skip-duplicate` を 4 nupkg ループ

### 修正版を出したい場合

NuGet.org は **同名 version の再 push 不可 (409 Conflict)・削除も不可・unlist のみ**。中身を直したい場合は必ず patch をバンプする。例: 1.0.0 にバグがあった場合:

1. NuGet.org gallery の各 ID の Manage Listing で 1.0.0 を unlist
2. csproj `<Version>` を 1.0.1 にバンプ → 上記の通常手順
3. README / GitHub Release Notes で「1.0.0 は欠陥のため unlist。1.0.1 を使ってください」と告知

## 初回公開チェックリスト (v1.0.0)

新規に NuGet.org に出す前に 1 度だけ実施する設定。

- [ ] **NuGet.org の 4 ID 空き確認**
      ```bash
      for rid in osx-arm64 linux-x64 linux-arm64 win-x64; do
        url="https://api.nuget.org/v3-flatcontainer/jumboly.ezgdal.$rid/index.json"
        echo "$rid: $(curl -s -o /dev/null -w "%{http_code}" "$url")"
      done
      ```
      全部 404 でなければ ID 設計を再考。

- [ ] **GitHub repo を public で作成 + push**
      ```bash
      gh repo create jumboly/ez-gdal --public --source=. \
        --description "Portable .NET global tool for GDAL CLI (gdalinfo, ogr2ogr, unified gdal CLI)."
      git push -u origin main
      ```

- [ ] **NuGet.org API key を発行 → GitHub Secret に登録**
      [API Keys](https://www.nuget.org/account/apikeys) で Push スコープ・Glob `Jumboly.*`・期限 365 日の key を作成し:
      ```bash
       gh secret set NUGET_API_KEY --repo jumboly/ez-gdal   # stdin で貼り付け
      ```
      (空白 prefix で `.bash_history` 排除)

- [ ] **Environment "nuget" を作成 + required reviewer 設定**
      ```bash
      gh api -X PUT "repos/jumboly/ez-gdal/environments/nuget" \
        --input - <<EOF
      {"reviewers": [{"type": "User", "id": $(gh api user -q .id)}]}
      EOF
      ```
      または web UI: Settings → Environments → New environment "nuget" → Required reviewers に自分を追加。

- [ ] **`ci.yml` の初回 run が green であることを確認**
      ```bash
      gh run list --workflow=ci.yml --limit 1
      ```

- [ ] 上記すべて green になってから `git tag v1.0.0 && git push origin v1.0.0`

## ローカルビルド (dev-loop / 動作確認用)

CI を待たずに手元で確認したいときに使う。NuGet.org への push 経路はもう持っていない (CI 専用)。

```bash
# 全 RID
./scripts/pack-tool.sh

# 1 RID のみ
./scripts/pack-tool.sh osx-arm64

# ポータブル単一バイナリ (self-contained, ~84MB)
./scripts/publish-all.sh           # 全 RID
./scripts/publish-all.sh osx-arm64 # 特定 RID

# 通常ビルド (host RID のみ MaxRev runtime を restore する)
dotnet build src/EzGdal/EzGdal.csproj
```

両者は同じ csproj から条件分岐で生成される:

- `dotnet pack` → `PackAsTool=true` ベースで tool nupkg
- `dotnet publish -r <rid>` → RID 指定時のみ `PublishSingleFile=true` + `SelfContained=true` が有効化

### ローカル nupkg からの動作確認

NuGet.org に出す前にローカルで `dotnet tool install` 経路を確かめたいとき (グローバル環境を汚さない):

```bash
./scripts/pack-tool.sh osx-arm64
rm -rf tool-test
dotnet tool install --tool-path ./tool-test --add-source ./nupkg Jumboly.EzGdal.osx-arm64
./tool-test/ezgdal install-applets
./tool-test/gdalinfo /path/to/sample.tif
```

## RID 別 PackageId

4 つの PackageId が NuGet.org 上に予約される:

| プラットフォーム | PackageId | nupkg サイズ |
|---|---|---|
| Apple Silicon Mac | `Jumboly.EzGdal.osx-arm64` | ~51MB |
| Linux x64 | `Jumboly.EzGdal.linux-x64` | ~50MB |
| Linux arm64 | `Jumboly.EzGdal.linux-arm64` | ~47MB |
| Windows x64 | `Jumboly.EzGdal.win-x64` | ~39MB |

すべて NuGet.org 上限 250MB に収まる。合計 push 量 ~187MB。展開サイズは各 RID で ~150MB (`~/.dotnet/tools/.store/jumboly.ezgdal.<rid>/` 配下)。

## バージョン上書き (CI 経由でないアドホック pack 用)

```bash
dotnet pack src/EzGdal/EzGdal.csproj -c Release -p:PackTargetRid=osx-arm64 -p:Version=1.0.0
```
