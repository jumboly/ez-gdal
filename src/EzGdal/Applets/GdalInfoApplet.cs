using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

internal static class GdalInfoApplet
{
    // Mirrors the option arity table in apps/gdalinfo_bin.cpp from GDAL upstream.
    // Flags listed here consume one extra argument; everything else is a positional
    // (the dataset path) or a no-arg flag.
    private static readonly Dictionary<string, int> Arity = new(StringComparer.Ordinal)
    {
        ["-of"] = 1,
        ["-mdd"] = 1,
        ["-sd"] = 1,
        ["-oo"] = 1,
        ["-if"] = 1,
        ["-ct"] = 1,
        ["-band"] = 1,
    };

    public static int Run(string[] args)
    {
        var (options, positionals) = new ArgParser(Arity).Split(args);
        if (positionals.Count != 1)
        {
            Console.Error.WriteLine("Usage: gdalinfo [options] <dataset>");
            return ExitCode.UsageError;
        }

        using var ds = GdalHelper.OpenOrFail(positionals[0], GdalHelper.OpenRasterRead, "gdalinfo");
        if (ds == null) return ExitCode.Failure;

        using var opts = new GDALInfoOptions(options.ToArray());
        Console.Out.Write(Gdal.GDALInfo(ds, opts));
        return ExitCode.Success;
    }
}
