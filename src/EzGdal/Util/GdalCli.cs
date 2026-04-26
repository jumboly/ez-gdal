using OSGeo.GDAL;

namespace EzGdal.Util;

// GDAL 標準の一般 CLI フラグ (--version / --license / --build / --formats /
// --format <name> / --config K V / --debug ON|OFF|<level> / --locale / --optfile /
// --help-general) を args から処理する。実装は SWIG bindings の
// Gdal.GeneralCmdLineProcessor を経由する (Probe 5 で expose 確認済み)。
//
// 戻り値:
//   null  → GDAL 側が --version 等を表示完了し、呼び出し側は exit 0 で抜ける想定
//   array → 認識フラグを除去した新 argv (program name は含まない)
internal static class GdalCli
{
    // GDAL_OF_* の値 (gdal.h の定数)。--formats の出力対象ドライバを絞る。
    // GDALPrintDriverList は nOptions==0 を OF_RASTER に変換するため、
    // OGR 系 applet で --formats を呼ぶ場合は明示的に OF_VECTOR を渡す。
    private const int OF_RASTER = 2;
    private const int OF_VECTOR = 4;
    private const int OF_GNM = 8;
    private const int OF_MULTIDIM_RASTER = 16;
    private const int OF_ALL = OF_RASTER | OF_VECTOR | OF_GNM | OF_MULTIDIM_RASTER;

    public static string[]? Process(string programName, string[] args)
    {
        // GDAL の processor は argv[0] に program name を含める前提なので prepend。
        var argv = new string[args.Length + 1];
        argv[0] = programName;
        Array.Copy(args, 0, argv, 1, args.Length);

        // applet 名から --formats 出力フィルタを決める。OGR 系 (ogr*) は VECTOR、
        // ezgdal / gdal の汎用入口は ALL、それ以外 (gdalinfo / gdalwarp など) は RASTER。
        var nOptions = NOptionsFor(programName);

        string[]? result;
        try
        {
            result = Gdal.GeneralCmdLineProcessor(argv, nOptions);
        }
        catch (Exception ex)
        {
            Console.Error.WriteLine($"GDAL CLI フラグ処理でエラー: {ex.Message}");
            return args;
        }

        // 表示完了 + exit 想定のフラグは null / 空配列で示される
        if (result == null || result.Length == 0)
            return null;

        // 戻りから先頭の program name を取り除く
        if (result[0] == programName)
            return result[1..];
        return result;
    }

    private static int NOptionsFor(string programName)
    {
        if (programName.StartsWith("ogr", StringComparison.Ordinal))
            return OF_VECTOR;
        if (programName is "ezgdal" or "gdal")
            return OF_ALL;
        return OF_RASTER;
    }
}
