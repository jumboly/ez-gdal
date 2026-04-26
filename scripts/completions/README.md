# ezgdal シェル補完

ezgdal / gdal の **GDAL 3.12+ 統一 CLI ツリー** (`ezgdal raster info` / `ezgdal vector convert` 等) を TAB キーで補完するためのスクリプト。

対応シェル: **bash 4+** / **zsh** / **fish** / **PowerShell 5.1+**

> Legacy applet (`gdalinfo` / `ogr2ogr` 等) は補完対象外。`ezgdal` / `gdal` の 2 名で呼ばれた場合のみ補完が動作する。

## ユーザー向け: 導入

補完スクリプトは ezgdal バイナリに内蔵されており、`ezgdal completion <shell>` で stdout に出力できる。各シェルの初期化スクリプトに 1 行追記するだけで有効化できる (rc ファイルには `eval` 行が入るだけで補完スクリプト本体は展開されないため肥大化しない)。

### bash (Linux / WSL / homebrew bash, bash 4+ 必須)

```bash
# macOS デフォルトの bash 3.2 では何もしない。homebrew の bash を入れて使う
echo 'eval "$(ezgdal completion bash)"' >> ~/.bashrc
source ~/.bashrc
```

### zsh

```zsh
echo 'eval "$(ezgdal completion zsh)"' >> ~/.zshrc
source ~/.zshrc
```

### fish

```fish
echo 'ezgdal completion fish | source' >> ~/.config/fish/config.fish
```

### PowerShell

```powershell
Add-Content $PROFILE 'ezgdal completion powershell | Out-String | Invoke-Expression'
. $PROFILE
```

### 動作確認

```bash
ezgdal <TAB>                  # トップレベル: dataset, driver, mdim, pipeline, raster, vector, vsi
ezgdal raster <TAB>           # raster サブコマンド (44 種)
ezgdal raster overview <TAB>  # 第 3 階層: add, delete, refresh
ezgdal raster convert -<TAB>  # オプション (--source / --destination / --format / ...)
gdal raster <TAB>             # ezgdal を gdal にリネーム/symlink した場合も同じ
```

### ロケール切替

`LANG` / `LC_ALL` / `LC_MESSAGES` のいずれかが `ja*` で始まる場合、説明文 (zsh / fish / PowerShell) は日本語表示。それ以外は英語。

```zsh
LANG=ja_JP.UTF-8 zsh -c 'eval "$(ezgdal completion zsh)"; ...'  # 日本語
LANG=en_US.UTF-8 zsh -c 'eval "$(ezgdal completion zsh)"; ...'  # 英語
```

bash は `complete -F` の制約で説明文を表示できないので候補名のみ補完。

## メンテナ向け: 再生成手順

`scripts/completions/` 内のファイル構成:

```
scripts/completions/
├── README.md                # この文書
├── data/
│   ├── usage-en.json        # gdal --json-usage の生 JSON (英語、抽出データ)
│   ├── usage-en.snapshot.json  # 前回翻訳時点の usage-en.json (差分翻訳の起点)
│   └── usage-ja.json        # path/path@arg → 日本語訳 (フラット dict)
├── tools/
│   ├── extract.sh           # gdal --json-usage を data/usage-en.json に保存
│   ├── translate-diff.py    # diff 翻訳 (Claude API)
│   ├── compile.py           # data/ から 4 シェル分を再生成
│   └── pyproject.toml       # uv プロジェクト (依存: anthropic SDK のみ)
├── ezgdal.bash              # 生成成果物
├── ezgdal.zsh               # 生成成果物
├── ezgdal.fish              # 生成成果物
└── ezgdal.ps1               # 生成成果物
```

### GDAL バンプ時のフロー (4 ステップ)

1. **抽出**: GDAL ネイティブのツリーを再取得

   ```bash
   ./scripts/completions/tools/extract.sh
   # gdal バイナリは PATH の `gdal` を優先、明示するなら EZGDAL_BIN=/path/to/gdal を export
   # 出力: scripts/completions/data/usage-en.json
   ```

2. **翻訳**: 新規・変更ノードのみ Claude に投げる

   ```bash
   export ANTHROPIC_API_KEY=sk-ant-...
   uv run --project scripts/completions/tools scripts/completions/tools/translate-diff.py
   # 出力: scripts/completions/data/usage-ja.json (差分マージ)
   #       scripts/completions/data/usage-en.snapshot.json (次回 diff の起点に更新)
   ```

3. **コンパイル**: 4 シェル分を再生成

   ```bash
   uv run --project scripts/completions/tools scripts/completions/tools/compile.py
   # 出力: ezgdal.bash / ezgdal.zsh / ezgdal.fish / ezgdal.ps1
   ```

4. **コミット**: 全部一括

   ```bash
   git add scripts/completions/data/ scripts/completions/ezgdal.*
   git commit -m "completion: GDAL <new-version> 追従"
   ```

### 初回翻訳

`data/usage-ja.json` が空 (`{}`) の状態でも `compile.py` は走り、英語フォールバックで補完スクリプトが生成される。日本語化したい場合は `ANTHROPIC_API_KEY` を設定して `translate-diff.py` を 1 回実行する (1738 entry の初回翻訳で API コスト数十 cent 程度)。

### 翻訳結果を手で直したい

`data/usage-ja.json` を直接編集してから `compile.py` を再実行すれば反映される。`translate-diff.py` は **diff のあるエントリのみ上書き** するので、英文が変わっていない箇所への手修正は次回バンプでも保たれる。

### usage-en.snapshot.json を消したら？

完全再翻訳。1738 entry 全部が API へ送られる。GDAL のメジャーバージョン更新でツリーが大きく変わったときの非常用。

## 仕組み

```
gdal --json-usage  ──extract.sh──>  data/usage-en.json
                                          │
                                          │ (前回スナップショットと diff)
                                          ▼
                              translate-diff.py (Claude API)
                                          │
                                          ▼
                                  data/usage-ja.json
                                          │
                       compile.py  ◄──────┘
                            │
              ┌─────────────┼─────────────┬─────────────┐
              ▼             ▼             ▼             ▼
        ezgdal.bash    ezgdal.zsh    ezgdal.fish    ezgdal.ps1
            (英語のみ)   (en/ja LANG切替) (en/ja LANG切替) (en/ja LANG切替)
```

en と ja を別ファイルで管理する理由: GDAL バンプで構造ごと変わる en は丸ごと再抽出、ja は変わらない部分を温存して新規・変更分だけ LLM へ送る。これで翻訳コストと品質ブレを抑える。

## 制限事項

- bash は `complete -F` の制約で説明文を出さない (候補名のみ)
- 値補完 (`--format <TAB>` で `GTiff`, `COG` 等) は未対応。GDAL 統一 CLI の `choices` フィールドはあるが、現状の実装では使っていない
- legacy applet (`gdalinfo` / `ogr2ogr` 等) は補完対象外。新規スクリプトは統一 CLI (`ezgdal raster info` 等) を使う想定
- macOS の system bash (3.2) では何もしない。homebrew の bash 4+ をインストールするか zsh / fish を使う
