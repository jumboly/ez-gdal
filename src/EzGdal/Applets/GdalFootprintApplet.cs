using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

internal static class GdalFootprintApplet
{
    private static readonly Dictionary<string, int> Arity = new(StringComparer.Ordinal)
    {
        ["-of"] = 1, ["-co"] = 1, ["-lco"] = 1, ["-dsco"] = 1,
        ["-b"] = 1, ["-srcnodata"] = 1, ["-overview"] = 1,
        ["-t_srs"] = 1, ["-t_coord_epoch"] = 1, ["-min_ring_area"] = 1,
        ["-simplify"] = 1, ["-max_points"] = 1, ["-split_polys"] = 0,
        ["-convex_hull"] = 0, ["-q"] = 0, ["-quiet"] = 0, ["-oo"] = 1,
        ["-if"] = 1, ["-overwrite"] = 0, ["-lyr_name"] = 1,
        ["-location_field_name"] = 1, ["-no_location"] = 0,
        ["-write_absolute_path"] = 0, ["-where"] = 1,
        ["-mfn"] = 1, ["-of_internal_use"] = 1,
    };

    public static int Run(string[] args)
    {
        var (options, positionals) = new ArgParser(Arity).Split(args);
        if (positionals.Count != 2)
        {
            Console.Error.WriteLine("Usage: gdal_footprint [options] <src> <dst>");
            return ExitCode.UsageError;
        }
        using var srcDs = GdalHelper.OpenOrFail(positionals[0], GdalHelper.OpenRasterRead, "gdal_footprint");
        if (srcDs == null) return ExitCode.Failure;

        using var opts = new GDALFootprintOptions(options.ToArray());
        using var outDs = Gdal.wrapper_GDALFootprintDestName(positionals[1], srcDs, opts, null, null);
        return outDs == null ? ExitCode.Failure : ExitCode.Success;
    }
}
