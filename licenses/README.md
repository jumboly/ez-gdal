# ezgdal 同梱ライブラリのライセンス情報

ezgdal の配布物 (.NET global tool nupkg / portable single-file) には、
GDAL とその依存ライブラリのネイティブバイナリが MaxRev.Gdal NuGet
package 経由で同梱されています。本ディレクトリはそれらの third-party
ライブラリのライセンス情報をまとめたものです。

ezgdal 自体のライセンスはリポジトリルートの [`LICENSE`](../LICENSE)
（MIT）を参照してください。

## 目次

- [1. ezgdal 自体](#1-ezgdal-自体)
- [2. C# バインディング (MaxRev.Gdal.Core)](#2-c-バインディング-maxrevgdalcore)
- [3. GDAL/OGR 本体](#3-gdalogr-本体)
- [4. 同梱ネイティブライブラリ](#4-同梱ネイティブライブラリ)
- [5. .NET ランタイム (portable single-file 版のみ)](#5-net-ランタイム-portable-single-file-版のみ)
- [6. 再配布時の注意](#6-再配布時の注意)

## 1. ezgdal 自体

| 項目 | 値 |
|---|---|
| License | MIT |
| ファイル | [`../LICENSE`](../LICENSE) |
| Source | https://github.com/jumboly/ez-gdal |

## 2. C# バインディング (MaxRev.Gdal.Core)

GDAL の SWIG 生成 C# bindings をまとめた NuGet パッケージ。
ezgdal はこれを `using OSGeo.GDAL` 経由で使う。

| 項目 | 値 |
|---|---|
| License | MIT |
| Project | MaxRev.Gdal.Core |
| NuGet | https://www.nuget.org/packages/MaxRev.Gdal.Core |
| Source | https://github.com/MaxRev-Dev/gdal.netcore |

## 3. GDAL/OGR 本体

GDAL 自体の LICENSE.TXT は配布物の `runtimes/any/native/gdal-data/LICENSE.TXT`
（global tool / portable いずれも展開後のパス内、`any` は RID 非依存の data dir）
に同梱されており、
GDAL の各 sub-component（degrib、g2clib、qhull、FlatGeobuf、Flatbush、
ESRI、CMake 等の組み込み箇所）のライセンス節も網羅している。

実行時には次のコマンドで表示できる:

```bash
ezgdal --license
ezgdal gdalinfo --license
```

| 項目 | 値 |
|---|---|
| License | MIT/X11 style (詳細は同梱 LICENSE.TXT を参照) |
| Project | GDAL |
| Homepage | https://gdal.org/ |
| Source | https://github.com/OSGeo/gdal |

## 4. 同梱ネイティブライブラリ

MaxRev.Gdal の "Minimal" runtime nupkg が `runtimes/<rid>/native/` に
配置するライブラリ群。リスト内容は macOS arm64 runtime
(MaxRev.Gdal.MacosRuntime.Minimal.arm64 3.12.2.472) を実機で展開した
結果に基づき、Linux / Windows 版でもほぼ同等の構成。各 license 列は
upstream の標準的な配布形態に基づく best-effort identification（精度
の限界については §6.5 を参照）。

### 4.1 Geospatial core

| ライブラリ | License (SPDX) | Upstream |
|---|---|---|
| libproj | MIT | https://proj.org/ |
| libgeos / libgeos_c | LGPL-2.1-or-later | https://libgeos.org/ |
| libgeotiff | MIT (X-style) | https://github.com/OSGeo/libgeotiff |
| libtiff | libtiff (BSD-like) | http://www.libtiff.org/ |
| libsqlite3 | Public Domain (blessing) | https://sqlite.org/ |
| libpq (PostgreSQL client) | PostgreSQL | https://www.postgresql.org/ |
| libmysqlclient | GPL-2.0 with FOSS Exception (or commercial) | https://dev.mysql.com/doc/c-api/ |
| libodbc / libodbcinst (unixODBC) | LGPL-2.1 | https://www.unixodbc.org/ |
| libfreexl | MPL-1.1 / LGPL-2.1 / GPL-2.0 (tri-license) | https://www.gaia-gis.it/fossil/freexl/ |
| libkmlbase / libkmldom / libkmlengine | BSD-3-Clause | https://github.com/libkml/libkml |
| libnetcdf | BSD-3-Clause-like (NetCDF) | https://www.unidata.ucar.edu/software/netcdf/ |
| libhdf5 / libhdf5_hl | BSD-3-Clause-like (HDF5) | https://www.hdfgroup.org/solutions/hdf5/ |
| libhdf / libmfhdf (HDF4) | NCSA (BSD-style) | https://www.hdfgroup.org/solutions/hdf4/ |
| libcfitsio | ISC-like permissive | https://heasarc.gsfc.nasa.gov/fitsio/ |
| libpoppler | GPL-2.0-or-later | https://poppler.freedesktop.org/ |
| libxerces-c | Apache-2.0 | https://xerces.apache.org/xerces-c/ |
| libtinyxml2 | Zlib | https://github.com/leethomason/tinyxml2 |

### 4.2 Compression / Encoding

| ライブラリ | License (SPDX) | Upstream |
|---|---|---|
| libz (zlib) | Zlib | https://zlib.net/ |
| libbz2 (bzip2) | bzip2-1.0.6 (BSD-like) | https://sourceware.org/bzip2/ |
| liblzma (XZ Utils) | 0BSD (Public Domain equivalent) | https://tukaani.org/xz/ |
| libdeflate | MIT | https://github.com/ebiggers/libdeflate |
| liblz4 | BSD-2-Clause | https://lz4.github.io/lz4/ |
| libzstd | BSD-3-Clause + GPL-2.0 (dual) | https://github.com/facebook/zstd |
| libsnappy | BSD-3-Clause | https://github.com/google/snappy |
| libbrotlicommon / libbrotlidec / libbrotlienc | MIT | https://github.com/google/brotli |
| libblosc | BSD-3-Clause | https://www.blosc.org/ |
| libminizip | Zlib | https://github.com/madler/zlib/tree/master/contrib/minizip |
| libaec / libsz | BSD-2-Clause | https://gitlab.dkrz.de/k202009/libaec |

### 4.3 Image / Codec

| ライブラリ | License (SPDX) | Upstream |
|---|---|---|
| libjpeg (libjpeg-turbo) | IJG + BSD-3-Clause + Zlib | https://libjpeg-turbo.org/ |
| libpng16 | libpng-2.0 | http://www.libpng.org/pub/png/libpng.html |
| libwebp / libsharpyuv | BSD-3-Clause | https://chromium.googlesource.com/webm/libwebp |
| libgif (giflib) | MIT (giflib) | https://giflib.sourceforge.net/ |
| libopenjp2 (OpenJPEG) | BSD-2-Clause | https://www.openjpeg.org/ |
| libjxl / libjxl_cms / libjxl_threads | BSD-3-Clause | https://github.com/libjxl/libjxl |
| libOpenEXR / libIex / libIlmThread / libImath / libOpenEXRCore / libOpenEXRUtil | BSD-3-Clause | https://www.openexr.com/ |
| libhwy (Highway) | Apache-2.0 | https://github.com/google/highway |
| liblcms2 (Little CMS) | MIT | https://www.littlecms.com/ |
| libfreetype | FTL or GPL-2.0 (dual) | https://freetype.org/ |
| libfontconfig | MIT-like (Fontconfig) | https://www.freedesktop.org/wiki/Software/fontconfig/ |

### 4.4 Networking / Crypto

| ライブラリ | License (SPDX) | Upstream |
|---|---|---|
| libcurl | curl (MIT-like) | https://curl.se/ |
| libssl / libcrypto (OpenSSL 3.x) | Apache-2.0 | https://www.openssl.org/ |

### 4.5 Parsing / Utilities

| ライブラリ | License (SPDX) | Upstream |
|---|---|---|
| libexpat | MIT | https://libexpat.github.io/ |
| libxml2 | MIT | https://gitlab.gnome.org/GNOME/libxml2 |
| libpcre2-8 | BSD-3-Clause | https://www.pcre.org/ |
| liburiparser | BSD-3-Clause | https://uriparser.github.io/ |
| libltdl (GNU libtool ltdl) | LGPL-2.1 | https://www.gnu.org/software/libtool/ |

### 4.6 Columnar / RPC

| ライブラリ | License (SPDX) | Upstream |
|---|---|---|
| libarrow / libparquet (Apache Arrow) | Apache-2.0 | https://arrow.apache.org/ |
| libthrift (Apache Thrift) | Apache-2.0 | https://thrift.apache.org/ |

## 5. .NET ランタイム (portable single-file 版のみ)

`dotnet publish -r <rid>` で生成される portable single-file には .NET
ランタイム本体が同梱される。global tool (.NET nupkg) 版にはランタイム
は含まれず、ユーザー側にインストール済みの .NET 10 を利用する。

| 項目 | 値 |
|---|---|
| License | MIT |
| Project | .NET Runtime |
| Homepage | https://dotnet.microsoft.com/ |
| Source | https://github.com/dotnet/runtime |

## 6. 再配布時の注意

ezgdal を**再配布**する場合（バイナリの転載・組み込み等）、上記
ライブラリのうち以下については特に追加の遵守事項がある。

### 6.1 LGPL ライブラリ (libgeos / libodbc / libltdl)

LGPL-2.1 系のライブラリは動的リンクで使用しているが、再配布物の利用者が
自分でビルドしたライブラリへ差し替えられる手段（同梱バイナリの場所が
ドキュメントされていること、replace 可能な dlopen 可能形式であること）
が必要。ezgdal は MaxRev.Gdal の `runtimes/<rid>/native/` 配下に
ライブラリをそのまま展開するため、ユーザーは該当ディレクトリ内の
ライブラリファイルを差し替えることで要件を満たせる。

### 6.2 GPL ライブラリ (libpoppler)

libpoppler は GPL-2.0-or-later。これを動的にロードしている GDAL 経由で
PDF ドライバを使う場合、組み合わせて配布するアプリケーション全体に
GPL の伝播が起きうる。GPL を避けたい再配布形態では、
MaxRev.Gdal.<...>Runtime.Minimal の代わりに poppler を含まないカスタム
runtime を使うか、配布物から `libpoppler.*` を削除する選択が必要。

### 6.3 GPL with FOSS Exception (libmysqlclient)

`libmysqlclient` は GPL-2.0 + FOSS Exception もしくは商用ライセンス。
ezgdal 自体は MIT で FOSS Exception の対象に含まれる想定だが、
独自プラグイン等を組み合わせて MySQL ドライバ経由で MySQL に接続する
ソフトウェアを再配布する場合は、自プロジェクトのライセンスが FOSS
Exception の対象であるか確認すること。商用配布時は Oracle の商用
ライセンスを取得するか、MySQL ドライバを使わない構成にする。

### 6.4 Apache-2.0 ライブラリの NOTICE

Apache-2.0 §4(d) は upstream が独立した `NOTICE` ファイルを公開している
場合にその全文を再配布物に含めるよう要求する。ezgdal は対象 NOTICE 群を
[`licenses/notices/`](notices/) にバンドル済み:

- `arrow-NOTICE.txt` (Apache Arrow: libarrow / libparquet)
- `thrift-NOTICE.txt` (Apache Thrift: libthrift)
- `xerces-c-NOTICE.txt` (Apache Xerces-C++: libxerces-c)

OpenSSL 3.x (libssl / libcrypto) と Google Highway (libhwy) は upstream に
独立 NOTICE が無く、LICENSE 全文のみで配布されているため §4(d) の対象外。
詳細とバージョン更新時の再取得手順は [`licenses/notices/README.md`](notices/README.md) を参照。

### 6.5 ライセンス整合性の最終確認

本書の license 列は upstream の標準的な配布形態に基づく best-effort
identification である。MaxRev.Gdal の各 runtime nupkg がどのバージョンの
どのソースからビルドされたかについては、`gdal-data/LICENSE.TXT`、
MaxRev.Gdal の[リリースノート](https://github.com/MaxRev-Dev/gdal.netcore/releases)、
および各 nupkg 内の README/license メタデータを参照すること。
