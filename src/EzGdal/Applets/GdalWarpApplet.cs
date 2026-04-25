using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

internal static class GdalWarpApplet
{
    private static readonly Dictionary<string, int> Arity = new(StringComparer.Ordinal)
    {
        ["-of"] = 1, ["-ot"] = 1, ["-s_srs"] = 1, ["-t_srs"] = 1,
        ["-srcnodata"] = 1, ["-dstnodata"] = 1, ["-srcalpha"] = 0,
        ["-dstalpha"] = 0, ["-r"] = 1, ["-tr"] = 2, ["-ts"] = 2,
        ["-te"] = 4, ["-te_srs"] = 1, ["-co"] = 1, ["-multi"] = 0,
        ["-q"] = 0, ["-quiet"] = 0, ["-overwrite"] = 0, ["-to"] = 1,
        ["-tap"] = 0, ["-wo"] = 1, ["-srcband"] = 1, ["-dstband"] = 1,
        ["-cutline"] = 1, ["-cwhere"] = 1, ["-csql"] = 1, ["-cl"] = 1,
        ["-crop_to_cutline"] = 0, ["-cblend"] = 1, ["-refine_gcps"] = 1,
        ["-order"] = 1, ["-tps"] = 0, ["-rpc"] = 0, ["-geoloc"] = 0,
        ["-et"] = 1, ["-wm"] = 1, ["-ovr"] = 1, ["-vshift"] = 0,
        ["-novshift"] = 0, ["-novshiftgrid"] = 0, ["-oo"] = 1, ["-doo"] = 1,
        ["-if"] = 1, ["-mo"] = 1, ["-s_coord_epoch"] = 1,
        ["-t_coord_epoch"] = 1, ["-ct"] = 1,
    };

    public static int Run(string[] args)
    {
        var (options, positionals) = new ArgParser(Arity).Split(args);
        if (positionals.Count < 2)
        {
            Console.Error.WriteLine("Usage: gdalwarp [options] <src> [<src> ...] <dst>");
            return ExitCode.UsageError;
        }
        var dst = positionals[^1];
        var srcs = positionals.Take(positionals.Count - 1).ToList();
        var srcDs = new Dataset[srcs.Count];
        try
        {
            for (int i = 0; i < srcs.Count; i++)
            {
                srcDs[i] = GdalHelper.OpenOrFail(srcs[i], GdalHelper.OpenRasterRead, "gdalwarp")!;
                if (srcDs[i] == null) return ExitCode.Failure;
            }
            using var opts = new GDALWarpAppOptions(options.ToArray());
            using var outDs = Gdal.Warp(dst, srcDs, opts, null, null);
            return outDs == null ? ExitCode.Failure : ExitCode.Success;
        }
        finally
        {
            foreach (var d in srcDs) d?.Dispose();
        }
    }
}
