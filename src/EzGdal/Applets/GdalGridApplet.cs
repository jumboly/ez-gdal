using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

internal static class GdalGridApplet
{
    private static readonly Dictionary<string, int> Arity = new(StringComparer.Ordinal)
    {
        ["-of"] = 1, ["-ot"] = 1, ["-txe"] = 2, ["-tye"] = 2,
        ["-outsize"] = 2, ["-tr"] = 2, ["-co"] = 1, ["-zfield"] = 1,
        ["-z_increase"] = 1, ["-z_multiply"] = 1, ["-a_srs"] = 1,
        ["-spat"] = 4, ["-clipsrc"] = 1, ["-clipsrcsql"] = 1,
        ["-clipsrclayer"] = 1, ["-clipsrcwhere"] = 1, ["-l"] = 1,
        ["-where"] = 1, ["-sql"] = 1, ["-a"] = 1, ["-q"] = 0, ["-quiet"] = 0,
        ["-oo"] = 1, ["-if"] = 1,
    };

    public static int Run(string[] args)
    {
        var (options, positionals) = new ArgParser(Arity).Split(args);
        if (positionals.Count != 2)
        {
            Console.Error.WriteLine("Usage: gdal_grid [options] <src> <dst>");
            return ExitCode.UsageError;
        }
        using var srcDs = GdalHelper.OpenOrFail(positionals[0], GdalHelper.OpenVectorRead, "gdal_grid");
        if (srcDs == null) return ExitCode.Failure;

        using var opts = new GDALGridOptions(options.ToArray());
        using var outDs = Gdal.wrapper_GDALGrid(positionals[1], srcDs, opts, null, null);
        return outDs == null ? ExitCode.Failure : ExitCode.Success;
    }
}
