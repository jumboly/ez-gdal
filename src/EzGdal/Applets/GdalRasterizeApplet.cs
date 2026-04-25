using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

internal static class GdalRasterizeApplet
{
    private static readonly Dictionary<string, int> Arity = new(StringComparer.Ordinal)
    {
        ["-b"] = 1, ["-i"] = 0, ["-at"] = 0, ["-add"] = 0, ["-burn"] = 1,
        ["-l"] = 1, ["-where"] = 1, ["-sql"] = 1, ["-dialect"] = 1,
        ["-of"] = 1, ["-a"] = 1, ["-3d"] = 0, ["-a_nodata"] = 1,
        ["-init"] = 1, ["-a_srs"] = 1, ["-to"] = 1, ["-co"] = 1,
        ["-te"] = 4, ["-tr"] = 2, ["-tap"] = 0, ["-ts"] = 2,
        ["-ot"] = 1, ["-optim"] = 1, ["-q"] = 0, ["-quiet"] = 0,
        ["-oo"] = 1, ["-if"] = 1, ["-overwrite"] = 0,
    };

    public static int Run(string[] args)
    {
        var (options, positionals) = new ArgParser(Arity).Split(args);
        if (positionals.Count != 2)
        {
            Console.Error.WriteLine("Usage: gdal_rasterize [options] <src> <dst>");
            return ExitCode.UsageError;
        }
        var src = positionals[0];
        var dst = positionals[1];

        using var srcDs = GdalHelper.OpenOrFail(src, GdalHelper.OpenVectorRead, "gdal_rasterize");
        if (srcDs == null) return ExitCode.Failure;

        using var opts = new GDALRasterizeOptions(options.ToArray());
        using var outDs = Gdal.wrapper_GDALRasterizeDestName(dst, srcDs, opts, null, null);
        return outDs == null ? ExitCode.Failure : ExitCode.Success;
    }
}
