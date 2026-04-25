using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

internal static class Ogr2OgrApplet
{
    private static readonly Dictionary<string, int> Arity = new(StringComparer.Ordinal)
    {
        ["-f"] = 1,
        ["-of"] = 1,
        ["-append"] = 0,
        ["-overwrite"] = 0,
        ["-update"] = 0,
        ["-select"] = 1,
        ["-where"] = 1,
        ["-sql"] = 1,
        ["-dialect"] = 1,
        ["-progress"] = 0,
        ["-skipfailures"] = 0,
        ["-spat"] = 4,
        ["-spat_srs"] = 1,
        ["-geomfield"] = 1,
        ["-clipsrc"] = 1,        // can take more args, GDAL Options API parses them
        ["-clipsrcsql"] = 1,
        ["-clipsrclayer"] = 1,
        ["-clipsrcwhere"] = 1,
        ["-clipdst"] = 1,
        ["-clipdstsql"] = 1,
        ["-clipdstlayer"] = 1,
        ["-clipdstwhere"] = 1,
        ["-s_srs"] = 1,
        ["-t_srs"] = 1,
        ["-a_srs"] = 1,
        ["-s_coord_epoch"] = 1,
        ["-t_coord_epoch"] = 1,
        ["-a_coord_epoch"] = 1,
        ["-ct"] = 1,
        ["-segmentize"] = 1,
        ["-simplify"] = 1,
        ["-fieldTypeToString"] = 1,
        ["-mapFieldType"] = 1,
        ["-fieldmap"] = 1,
        ["-splitlistfields"] = 0,
        ["-explodecollections"] = 0,
        ["-zfield"] = 1,
        ["-gcp"] = 4,
        ["-tps"] = 0,
        ["-order"] = 1,
        ["-nln"] = 1,
        ["-nlt"] = 1,
        ["-dim"] = 1,
        ["-lco"] = 1,
        ["-dsco"] = 1,
        ["-oo"] = 1,
        ["-doo"] = 1,
        ["-if"] = 1,
        ["-makevalid"] = 0,
        ["-skipinvalid"] = 0,
        ["-emptyStrAsNull"] = 0,
        ["-q"] = 0,
        ["-quiet"] = 0,
        ["-limit"] = 1,
        ["-preserve_fid"] = 0,
        ["-unsetFid"] = 0,
        ["-fieldTypeWidthMatch"] = 0,
        ["-forceNullable"] = 0,
        ["-unsetDefault"] = 0,
        ["-unsetFieldWidth"] = 0,
        ["-relaxedFieldNameMatch"] = 0,
    };

    public static int Run(string[] args)
    {
        var (options, positionals) = new ArgParser(Arity).Split(args);
        if (positionals.Count < 2)
        {
            Console.Error.WriteLine("Usage: ogr2ogr [options] <dst> <src> [<layer> ...]");
            return ExitCode.UsageError;
        }

        var dst = positionals[0];
        var src = positionals[1];
        // Trailing positionals are layer names; ogr2ogr passes them via options.
        for (int i = 2; i < positionals.Count; i++)
            options.Add(positionals[i]);

        using var srcDs = GdalHelper.OpenOrFail(src, GdalHelper.OpenVectorRead, "ogr2ogr");
        if (srcDs == null) return ExitCode.Failure;

        using var opts = new GDALVectorTranslateOptions(options.ToArray());
        using var outDs = Gdal.wrapper_GDALVectorTranslateDestName(dst, srcDs, opts, null, null);
        return outDs == null ? ExitCode.Failure : ExitCode.Success;
    }
}
