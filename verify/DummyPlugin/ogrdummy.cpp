// ezgdal の install-plugin / list-plugins / remove-plugin および
// 起動時の自動ロードを動作確認するための最小 OGR ドライバ。
//
// 役割は ogrinfo --formats の一覧に "Dummy" が出ること、それ自体が
// 外部プラグインの dlopen + RegisterOGRDummy のフローを通過した
// 証拠となるという点だけ。Identify/Open のコールバックは設定しない
// (host (ezgdal) が同梱する MaxRev libgdal と本ファイルが build された
// host GDAL の minor バージョン差異で GDALDriver クラスのメモリ
// レイアウトが異なる可能性があり、関数ポインタフィールドへの直接
// 代入は破壊的書き込みを起こしうるため。メタデータ API のみ使う)。
//
// ファイル名は ogr_Dummy.{so,dylib,dll} とし、エクスポートシンボル
// RegisterOGRDummy を提供する。GDAL の AutoLoadDrivers がファイル名
// から関数名を導出する規約に従う。

#include "ogrsf_frmts.h"

// GDAL の CPL_DLL は plugin 文脈 (GDAL_COMPILATION 未定義) の MSVC で空マクロに
// 展開されるため、Register 関数が DLL から export されない。Windows MSVC では
// 明示的に __declspec(dllexport) を付ける必要がある。
#ifdef _MSC_VER
#  define EZGDAL_PLUGIN_EXPORT __declspec(dllexport)
#else
#  define EZGDAL_PLUGIN_EXPORT
#endif

extern "C" EZGDAL_PLUGIN_EXPORT void RegisterOGRDummy();

void RegisterOGRDummy()
{
    if (GDALGetDriverByName("Dummy") != nullptr)
        return;

    auto *driver = new GDALDriver();
    driver->SetDescription("Dummy");
    driver->SetMetadataItem(GDAL_DMD_LONGNAME, "ezgdal verify dummy driver");
    driver->SetMetadataItem(GDAL_DCAP_VECTOR, "YES");
    driver->SetMetadataItem(GDAL_DCAP_OPEN, "YES");
    driver->SetMetadataItem(GDAL_DCAP_CREATE, "YES");
    driver->SetMetadataItem(GDAL_DCAP_CREATECOPY, "YES");
    driver->SetMetadataItem(GDAL_DCAP_VIRTUALIO, "YES");

    GetGDALDriverManager()->RegisterDriver(driver);
}
