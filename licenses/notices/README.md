# Apache-2.0 §4(d) NOTICE files

ezgdal が同梱するネイティブライブラリのうち、Apache-2.0 ライセンスで
配布され、かつ upstream が独立した `NOTICE` ファイルを公開している
プロジェクトの NOTICE 全文を保管するディレクトリ。

Apache License 2.0 §4(d) は「If the Work includes a 'NOTICE' text file」
という条件付きの帰属表示要件であり、`NOTICE` ファイルそのものが
upstream に存在しない Apache-2.0 プロジェクトはこの要件の対象外。

## 同梱しているファイル

| ファイル | 由来プロジェクト | upstream URL | 取得時期 |
|---|---|---|---|
| `arrow-NOTICE.txt` | Apache Arrow (libarrow / libparquet) | https://github.com/apache/arrow/blob/main/NOTICE.txt | 2026-04-26 |
| `thrift-NOTICE.txt` | Apache Thrift (libthrift) | https://github.com/apache/thrift/blob/master/NOTICE | 2026-04-26 |
| `xerces-c-NOTICE.txt` | Apache Xerces-C++ (libxerces-c) | https://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.2.4.tar.gz の `NOTICE` | 2026-04-26 |

## 同梱していない (upstream に独立 NOTICE が存在しない) もの

ezgdal 同梱で Apache-2.0 だが、upstream に独立 `NOTICE` ファイルが無く、
`LICENSE` テキストのみで配布されているプロジェクト:

- **OpenSSL 3.x** (libssl / libcrypto) — `LICENSE.txt` が Apache-2.0 全文。独立 NOTICE なし
- **Google Highway** (libhwy) — `LICENSE` のみ（Apache-2.0）。独立 NOTICE なし

これらは Apache-2.0 §4(d) の対象外。

## 更新手順

MaxRev.Gdal の runtime バージョンを上げて Apache-2.0 同梱物の構成が
変わったとき、または既存の Apache-2.0 プロジェクトの NOTICE が改訂
されたときは、対応する upstream URL から再取得して上書きすること。

```bash
curl -sL https://raw.githubusercontent.com/apache/arrow/main/NOTICE.txt \
  -o licenses/notices/arrow-NOTICE.txt
curl -sL https://raw.githubusercontent.com/apache/thrift/master/NOTICE \
  -o licenses/notices/thrift-NOTICE.txt
# Xerces は git の master ではなく Apache 公式配布アーカイブから取る
# (MaxRev runtime が同梱しているのは tagged release 由来)
```

新しい Apache-2.0 同梱物が増えた場合は、本表に行を追加し、
`licenses/README.md §6.4` の対応箇所も更新する。
