using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

internal static class GdalMdimTranslateApplet
{
    private static readonly Dictionary<string, int> Arity = new(StringComparer.Ordinal)
    {
        ["-of"] = 1, ["-co"] = 1, ["-array"] = 1, ["-group"] = 1,
        ["-subset"] = 1, ["-scaleaxes"] = 1, ["-strict"] = 0,
        ["-q"] = 0, ["-quiet"] = 0, ["-oo"] = 1, ["-if"] = 1,
    };

    public static int Run(string[] args)
    {
        var (options, positionals) = new ArgParser(Arity).Split(args);
        if (positionals.Count < 2)
        {
            Console.Error.WriteLine("Usage: gdalmdimtranslate [options] <src> [<src>...] <dst>");
            return ExitCode.UsageError;
        }
        var dst = positionals[^1];
        var srcs = positionals.Take(positionals.Count - 1).ToList();
        var srcDs = new Dataset[srcs.Count];
        try
        {
            for (int i = 0; i < srcs.Count; i++)
            {
                srcDs[i] = GdalHelper.OpenOrFail(srcs[i], GdalHelper.OpenMultiDimRead, "gdalmdimtranslate")!;
                if (srcDs[i] == null) return ExitCode.Failure;
            }
            using var opts = new GDALMultiDimTranslateOptions(options.ToArray());
            using var outDs = Gdal.MultiDimTranslate(dst, srcDs, opts, null, null);
            return outDs == null ? ExitCode.Failure : ExitCode.Success;
        }
        finally
        {
            foreach (var d in srcDs) d?.Dispose();
        }
    }
}
