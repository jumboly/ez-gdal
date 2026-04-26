cmake_minimum_required(VERSION 3.20)
project(ogr_Dummy LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(ogr_Dummy MODULE ogrdummy.cpp)

if(WIN32)
    # ezgdal Windows プラグイン作者向け SDK 経由でビルドする。
    # Windows DLL は undefined symbol を許容しないため、ezgdal が同梱する
    # gdal.dll に対する import library (gdal.lib) にリンクする必要がある。
    # SDK は Jumboly.EzGdal.win-x64 nupkg の sdk/ に同梱されており、
    # tool install 後のディレクトリを EZGDAL_SDK_DIR で指す:
    #   $env:EZGDAL_SDK_DIR = "<tool-path>\.store\jumboly.ezgdal.win-x64\<ver>\jumboly.ezgdal.win-x64\<ver>\tools\net10.0\any\sdk"
    if(NOT DEFINED ENV{EZGDAL_SDK_DIR})
        message(FATAL_ERROR "EZGDAL_SDK_DIR を Jumboly.EzGdal.win-x64 同梱の sdk/ ディレクトリに設定してください")
    endif()
    list(APPEND CMAKE_PREFIX_PATH "$ENV{EZGDAL_SDK_DIR}/cmake")
    find_package(EzGdalSdk REQUIRED)
    target_link_libraries(ogr_Dummy PRIVATE EzGdalSdk::gdal)
else()
    # macOS / Linux は host にインストールされた GDAL のヘッダだけ使ってビルドする。
    # ライブラリへの explicit link は行わず、libgdal の symbol は host
    # プロセスに既にロードされているもの (ezgdal 内蔵の MaxRev libgdal)
    # から解決させる。これによりプラグイン .so には絶対パス
    # /opt/homebrew/.../libgdal.38.dylib のような依存が残らず、
    # 「ホストプロセスにロード済みの libgdal の driver manager に登録
    # される」が保証される。
    find_package(GDAL REQUIRED)
    target_include_directories(ogr_Dummy PRIVATE
        $<TARGET_PROPERTY:GDAL::GDAL,INTERFACE_INCLUDE_DIRECTORIES>
    )
    if(APPLE)
        target_link_options(ogr_Dummy PRIVATE -Wl,-undefined,dynamic_lookup)
    elseif(UNIX)
        target_link_options(ogr_Dummy PRIVATE -Wl,--allow-shlib-undefined)
    endif()
endif()

# GDAL の AutoLoadDrivers はファイル名 prefix (ogr_) と suffix
# (.so / .dylib / .dll) からドライバを発見する。Windows は .dll、
# それ以外は .so に固定 (macOS の plugin loader は .so / .dylib 両方を
# スキャンするので .so で良い)。lib プレフィックスは外す。
if(WIN32)
    set_target_properties(ogr_Dummy PROPERTIES PREFIX "" SUFFIX ".dll")
else()
    set_target_properties(ogr_Dummy PROPERTIES PREFIX "" SUFFIX ".so")
endif()
