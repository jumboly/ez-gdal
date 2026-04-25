using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

// GDAL 3.12+ の統一 CLI を OSGeo.GDAL.AlgorithmRegistry 経由で起動する。
// バイナリ名が `ezgdal` / `gdal` のときに利用される。サブコマンドのパスを
// 先に解決し、残りの argv を Algorithm.ParseRunAndFinalize に丸投げする
// （DriverProbe で reflection 検証済み: 2026-04-26）。
internal static class UnifiedCliApplet
{
    public static int Run(string[] args)
    {
        using var registry = Gdal.GetGlobalAlgorithmRegistry();
        if (registry == null)
        {
            Console.Error.WriteLine("ezgdal: AlgorithmRegistry is unavailable.");
            return ExitCode.Failure;
        }

        if (args.Length == 0)
        {
            PrintTopLevelHelp(registry);
            return ExitCode.UsageError;
        }

        Algorithm? alg = registry.InstantiateAlg(args[0]);
        if (alg == null)
        {
            Console.Error.WriteLine($"ezgdal: unknown subcommand '{args[0]}'.");
            PrintTopLevelHelp(registry);
            return ExitCode.UsageError;
        }

        int consumed = 1;
        while (alg.HasSubAlgorithms() && consumed < args.Length && !args[consumed].StartsWith('-'))
        {
            var sub = alg.InstantiateSubAlgorithm(args[consumed]);
            if (sub == null) break;
            alg.Dispose();
            alg = sub;
            consumed++;
        }

        var remaining = args.Skip(consumed).ToArray();
        try
        {
            return alg.ParseRunAndFinalize(remaining, null, null) ? ExitCode.Success : ExitCode.Failure;
        }
        finally
        {
            alg.Dispose();
        }
    }

    static void PrintTopLevelHelp(AlgorithmRegistry? registry)
    {
        Console.Error.WriteLine("Usage: ezgdal <subcommand> [...]");
        Console.Error.WriteLine();
        Console.Error.WriteLine("Top-level subcommands (delegated to GDAL 3.12+ unified CLI):");
        if (registry != null)
        {
            foreach (var n in registry.GetAlgNames())
                Console.Error.WriteLine($"  {n}");
        }
        else
        {
            Console.Error.WriteLine("  raster, vector, pipeline, ...");
        }
        Console.Error.WriteLine();
        Console.Error.WriteLine("For legacy EXE compatibility, copy/symlink this binary to one of:");
        Console.Error.WriteLine("  gdalinfo, gdal_translate, gdalwarp, ogr2ogr, ogrinfo, ...");
    }
}
