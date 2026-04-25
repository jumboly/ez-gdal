using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

internal static class GdalTranslateApplet
{
    private static readonly Dictionary<string, int> Arity = new(StringComparer.Ordinal)
    {
        ["-of"] = 1,
        ["-b"] = 1,
        ["-mask"] = 1,
        ["-expand"] = 1,
        ["-ot"] = 1,
        ["-strict"] = 0,
        ["-not_strict"] = 0,
        ["-outsize"] = 2,
        ["-tr"] = 2,
        ["-r"] = 1,
        ["-scale"] = 0,   // can also take 2 or 4 numeric args; handled by Options API
        ["-scale_1"] = 0,
        ["-scale_2"] = 0,
        ["-scale_3"] = 0,
        ["-scale_4"] = 0,
        ["-exponent"] = 1,
        ["-unscale"] = 0,
        ["-srcwin"] = 4,
        ["-projwin"] = 4,
        ["-projwin_srs"] = 1,
        ["-srs"] = 1,
        ["-a_srs"] = 1,
        ["-a_coord_epoch"] = 1,
        ["-a_ullr"] = 4,
        ["-a_offset"] = 1,
        ["-a_scale"] = 1,
        ["-a_nodata"] = 1,
        ["-mo"] = 1,
        ["-co"] = 1,
        ["-gcp"] = 4,    // x y z pixel line — variable; Options API tolerates extras
        ["-q"] = 0,
        ["-quiet"] = 0,
        ["-sds"] = 0,
        ["-stats"] = 0,
        ["-norat"] = 0,
        ["-noxmp"] = 0,
        ["-oo"] = 1,
        ["-if"] = 1,
        ["-ovr"] = 1,
        ["-eco"] = 0,
        ["-epo"] = 0,
        ["-colorinterp"] = 1,
    };

    public static int Run(string[] args)
    {
        var (options, positionals) = new ArgParser(Arity).Split(args);
        if (positionals.Count != 2)
        {
            Console.Error.WriteLine("Usage: gdal_translate [options] <src> <dst>");
            return ExitCode.UsageError;
        }

        using var ds = GdalHelper.OpenOrFail(positionals[0], GdalHelper.OpenRasterRead, "gdal_translate");
        if (ds == null) return ExitCode.Failure;

        using var opts = new GDALTranslateOptions(options.ToArray());
        using var outDs = Gdal.wrapper_GDALTranslate(positionals[1], ds, opts, null, null);
        return outDs == null ? ExitCode.Failure : ExitCode.Success;
    }
}
