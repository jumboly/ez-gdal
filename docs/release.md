# リリース・ビルド手順（メンテナ向け）

ezgdal の利用者向けインストール手順は [`README.md`](../README.md) を参照。本ドキュメントはリポジトリで開発・配布する側の手順をまとめたもの。

## ビルド

`.NET 10 SDK` が必要。

```bash
# Global tool 用 nupkg（5 RID 別、framework-dependent）
./scripts/pack-tool.sh             # 5 RID すべて
./scripts/pack-tool.sh osx-arm64   # 1 つの RID のみ

# ポータブル単一バイナリ（self-contained、~84MB）
./scripts/publish-all.sh           # 全 RID
./scripts/publish-all.sh osx-arm64 # 特定 RID のみ
```

両者は同じ csproj から条件分岐で生成される：

- `dotnet pack` → `PackAsTool=true` ベースで tool nupkg
- `dotnet publish -r <rid>` → RID 指定時のみ `PublishSingleFile=true` + `SelfContained=true` が有効化

## ローカル nupkg からインストール（動作確認用）

NuGet.org に push する前に手元で `dotnet tool install` 経路を確かめたいとき：

```bash
./scripts/pack-tool.sh osx-arm64
dotnet tool install -g --add-source ./nupkg Jumboly.EzGdal.osx-arm64
```

グローバル環境を汚さない検証手順：

```bash
rm -rf tool-test
dotnet tool install --tool-path ./tool-test --add-source ./nupkg Jumboly.EzGdal.osx-arm64
./tool-test/ezgdal install-applets
./tool-test/gdalinfo /path/to/sample.tif
```

## NuGet.org への公開

1. [NuGet.org](https://www.nuget.org/) でアカウント作成
2. [API Keys](https://www.nuget.org/account/apikeys) で Push スコープの key を作成（Glob: `Jumboly.*`）
3. 5 つの nupkg をまとめて pack & push:

   ```bash
   ./scripts/pack-tool.sh
   for f in ./nupkg/Jumboly.EzGdal.*.0.1.0.nupkg; do
     dotnet nuget push "$f" \
       --source https://api.nuget.org/v3/index.json \
       --api-key <YOUR_KEY>
   done
   ```

4. インデックスされるまで数分待つと、誰でも `dotnet tool install -g Jumboly.EzGdal.<rid>` で入る。

注意:

- **5 つの PackageId** が NuGet.org に予約される：

  | プラットフォーム | PackageId | nupkg サイズ |
  |---|---|---|
  | Apple Silicon Mac | `Jumboly.EzGdal.osx-arm64` | ~51MB |
  | Intel Mac | `Jumboly.EzGdal.osx-x64` | ~58MB |
  | Linux x64 | `Jumboly.EzGdal.linux-x64` | ~50MB |
  | Linux arm64 | `Jumboly.EzGdal.linux-arm64` | ~47MB |
  | Windows x64 | `Jumboly.EzGdal.win-x64` | ~39MB |

- すべて NuGet.org 上限 250MB に収まる。合計 push 量 ~245MB。
- 展開サイズは各 RID で ~150MB（`~/.dotnet/tools/.store/jumboly.ezgdal.<rid>/` 配下）。
- **初回は v0.1.0 ではなく v1.0.0 から始めることを推奨**（pre-release 用には v0.1.0-alpha 等を使う）。csproj の `<Version>` を変更するか、pack 時に `-p:Version=1.0.0` で上書き。
- 5 つの ID すべてが NuGet.org で空いていることを事前確認すること。

## バージョン上書き

```bash
dotnet pack src/EzGdal/EzGdal.csproj -c Release -p:PackTargetRid=osx-arm64 -p:Version=1.0.0
```
