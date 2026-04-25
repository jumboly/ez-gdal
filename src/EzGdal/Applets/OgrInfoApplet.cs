using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

internal static class OgrInfoApplet
{
    private static readonly Dictionary<string, int> Arity = new(StringComparer.Ordinal)
    {
        ["-of"] = 1,
        ["-where"] = 1,
        ["-dialect"] = 1,
        ["-sql"] = 1,
        ["-spat"] = 4,
        ["-spat_srs"] = 1,
        ["-geomfield"] = 1,
        ["-fid"] = 1,
        ["-oo"] = 1,
        ["-if"] = 1,
        ["-fields"] = 1,
        ["-features"] = 1,
        ["-format"] = 1,
        ["-extent"] = 0,
        ["-extent3D"] = 0,
        ["-stats"] = 0,
    };

    public static int Run(string[] args)
    {
        var (options, positionals) = new ArgParser(Arity).Split(args);
        if (positionals.Count < 1)
        {
            Console.Error.WriteLine("Usage: ogrinfo [options] <dataset> [<layer> ...]");
            return ExitCode.UsageError;
        }

        // Layer names are positional after the dataset; pass them via options
        // by appending them. GDAL's Options API treats trailing tokens as
        // layer filters when the binary is invoked normally.
        var src = positionals[0];
        for (int i = 1; i < positionals.Count; i++)
            options.Add(positionals[i]);

        using var ds = GdalHelper.OpenOrFail(src, GdalHelper.OpenVectorRead, "ogrinfo");
        if (ds == null) return ExitCode.Failure;

        using var opts = new GDALVectorInfoOptions(options.ToArray());
        Console.Out.Write(Gdal.GDALVectorInfo(ds, opts));
        return ExitCode.Success;
    }
}
