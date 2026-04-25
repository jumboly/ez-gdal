using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

internal static class GdalBuildVrtApplet
{
    private static readonly Dictionary<string, int> Arity = new(StringComparer.Ordinal)
    {
        ["-tileindex"] = 1, ["-resolution"] = 1, ["-tr"] = 2, ["-tap"] = 0,
        ["-te"] = 4, ["-addalpha"] = 0, ["-hidenodata"] = 0, ["-srcnodata"] = 1,
        ["-vrtnodata"] = 1, ["-a_srs"] = 1, ["-r"] = 1, ["-b"] = 1,
        ["-sd"] = 1, ["-allow_projection_difference"] = 0, ["-q"] = 0, ["-quiet"] = 0,
        ["-input_file_list"] = 1, ["-separate"] = 0, ["-overwrite"] = 0,
        ["-oo"] = 1, ["-ignore_srcmaskband"] = 0, ["-nodata_max_mask_threshold"] = 1,
        ["-strict"] = 0, ["-non_strict"] = 0, ["-program_name"] = 1,
        ["-write_absolute_path"] = 0,
    };

    public static int Run(string[] args)
    {
        var (options, positionals) = new ArgParser(Arity).Split(args);
        if (positionals.Count < 2)
        {
            Console.Error.WriteLine("Usage: gdalbuildvrt [options] <dst.vrt> <src> [<src> ...]");
            return ExitCode.UsageError;
        }
        var dst = positionals[0];
        var srcs = positionals.Skip(1).ToArray();
        using var opts = new GDALBuildVRTOptions(options.ToArray());
        using var outDs = Gdal.wrapper_GDALBuildVRT_names(dst, srcs, opts, null, null);
        return outDs == null ? ExitCode.Failure : ExitCode.Success;
    }
}
