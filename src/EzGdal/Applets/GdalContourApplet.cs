using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

internal static class GdalContourApplet
{
    private static readonly Dictionary<string, int> Arity = new(StringComparer.Ordinal)
    {
        ["-b"] = 1, ["-a"] = 1, ["-amin"] = 1, ["-amax"] = 1,
        ["-3d"] = 0, ["-inodata"] = 0, ["-snodata"] = 1,
        ["-i"] = 1, ["-fl"] = 1, ["-exp_base"] = 1, ["-off"] = 1,
        ["-f"] = 1, ["-of"] = 1, ["-dsco"] = 1, ["-lco"] = 1,
        ["-nln"] = 1, ["-q"] = 0, ["-quiet"] = 0, ["-oo"] = 1, ["-if"] = 1,
        ["-p"] = 0, ["-elevation_field"] = 1, ["-min_field"] = 1, ["-max_field"] = 1,
        ["-overwrite"] = 0, ["-gt"] = 1,
    };

    public static int Run(string[] args)
    {
        var (options, positionals) = new ArgParser(Arity).Split(args);
        if (positionals.Count != 2)
        {
            Console.Error.WriteLine("Usage: gdal_contour [options] <src.tif> <dst.shp>");
            return ExitCode.UsageError;
        }
        using var srcDs = GdalHelper.OpenOrFail(positionals[0], GdalHelper.OpenRasterRead, "gdal_contour");
        if (srcDs == null) return ExitCode.Failure;

        using var opts = new GDALContourOptions(options.ToArray());
        using var outDs = Gdal.wrapper_GDALContourDestName(positionals[1], srcDs, opts, null, null);
        return outDs == null ? ExitCode.Failure : ExitCode.Success;
    }
}
