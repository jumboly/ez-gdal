cmake_minimum_required(VERSION 3.20)
project(ogr_Dummy LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# host にインストールされた GDAL のヘッダだけ使ってビルドする。
# ライブラリへの explicit link は行わず、libgdal の symbol は host
# プロセスに既にロードされているもの (ezgdal 内蔵の MaxRev libgdal)
# から解決させる。これによりプラグイン .so には絶対パス
# /opt/homebrew/.../libgdal.38.dylib のような依存が残らず、
# 「ホストプロセスにロード済みの libgdal の driver manager に登録
# される」が保証される。
find_package(GDAL REQUIRED)

add_library(ogr_Dummy MODULE ogrdummy.cpp)
target_include_directories(ogr_Dummy PRIVATE
    $<TARGET_PROPERTY:GDAL::GDAL,INTERFACE_INCLUDE_DIRECTORIES>
)

# プラットフォーム別の「リンク時に未解決シンボルを許す」フラグ。
if(APPLE)
    target_link_options(ogr_Dummy PRIVATE -Wl,-undefined,dynamic_lookup)
elseif(UNIX)
    target_link_options(ogr_Dummy PRIVATE -Wl,--allow-shlib-undefined)
endif()
# Windows は別途 import library が必要 (本ダミーは macOS/Linux のみ想定)。

# GDAL の AutoLoadDrivers はファイル名 prefix (ogr_) と suffix
# (.so / .dylib / .dll) からドライバを発見する。CMake MODULE の
# デフォルト suffix は Unix で .so / Windows で .dll なので、macOS
# でも .so のままでよい (GDAL plugin loader は macOS で .so / .dylib
# 両方をスキャンする)。lib プレフィックスは外す。
set_target_properties(ogr_Dummy PROPERTIES
    PREFIX ""
    SUFFIX ".so"
)
