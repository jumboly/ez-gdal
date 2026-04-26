using EzGdal.Util;
using MaxRev.Gdal.Core;
using OSGeo.GDAL;
using OSGeo.OGR;

namespace EzGdal;

internal static class Bootstrap
{
    private static int _initialized;

    public static void Initialize()
    {
        if (Interlocked.Exchange(ref _initialized, 1) == 1)
            return;

        // GDAL/PROJ は数値フォーマットに C locale を期待する。
        // csproj の InvariantGlobalization=true は ICU 経由のフォーマットを抑える。
        // ここでの設定は将来 BCL の数値変換が GDAL に渡る場合の保険。
        Thread.CurrentThread.CurrentCulture = System.Globalization.CultureInfo.InvariantCulture;

        // GdalBase.ConfigureAll() 内の GDALAllRegister がこの値を読むので、ここで立てる。
        ApplyUserPluginPath();

        GdalBase.ConfigureAll();

        // 本物の GDAL EXE と挙動を揃えるため、例外を投げず stderr に "ERROR N: msg" を
        // 出して非 0 終了するモードにする。
        Gdal.DontUseExceptions();
        Ogr.DontUseExceptions();

        AppDomain.CurrentDomain.ProcessExit += static (_, _) => Cleanup();
        Console.CancelKeyPress += static (_, e) =>
        {
            Cleanup();
            // ランタイムにそのまま終了させて、呼び出し側に慣習的な exit code を返す。
            e.Cancel = false;
        };
    }

    private static void Cleanup()
    {
        try { Gdal.GDALDestroyDriverManager(); } catch { }
    }

    private static void ApplyUserPluginPath()
    {
        var userDir = PluginPaths.GetUserPluginDir();
        if (!Directory.Exists(userDir))
            return;

        // ユーザーが env で立てている GDAL_DRIVER_PATH を尊重して連結する。
        var existing = Environment.GetEnvironmentVariable("GDAL_DRIVER_PATH");
        var sep = OperatingSystem.IsWindows() ? ";" : ":";
        var combined = string.IsNullOrEmpty(existing) ? userDir : $"{existing}{sep}{userDir}";
        Gdal.SetConfigOption("GDAL_DRIVER_PATH", combined);
    }
}
