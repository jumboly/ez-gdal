using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

internal static class NearblackApplet
{
    private static readonly Dictionary<string, int> Arity = new(StringComparer.Ordinal)
    {
        ["-of"] = 1, ["-co"] = 1, ["-o"] = 1, ["-near"] = 1, ["-nb"] = 1,
        ["-setalpha"] = 0, ["-setmask"] = 0, ["-white"] = 0,
        ["-color"] = 1, ["-q"] = 0, ["-quiet"] = 0, ["-oo"] = 1, ["-if"] = 1,
        ["-alg"] = 1,
    };

    public static int Run(string[] args)
    {
        var (options, positionals) = new ArgParser(Arity).Split(args);
        if (positionals.Count != 1)
        {
            Console.Error.WriteLine("Usage: nearblack [-o <dst>] [options] <src>");
            return ExitCode.UsageError;
        }
        var src = positionals[0];

        // -o <dst> hoists out of options into the destination path.
        // If absent, nearblack runs in-place and writes back to src.
        string dst = src;
        var passOptions = new List<string>();
        for (int i = 0; i < options.Count; i++)
        {
            if (options[i] == "-o" && i + 1 < options.Count)
            {
                dst = options[i + 1];
                i++;
                continue;
            }
            passOptions.Add(options[i]);
        }

        var openFlags = dst == src ? GdalHelper.OpenRasterUpdate : GdalHelper.OpenRasterRead;
        using var srcDs = GdalHelper.OpenOrFail(src, openFlags, "nearblack");
        if (srcDs == null) return ExitCode.Failure;

        using var opts = new GDALNearblackOptions(passOptions.ToArray());
        if (dst == src)
        {
            var rc = Gdal.wrapper_GDALNearblackDestDS(srcDs, srcDs, opts, null, null);
            return rc != 0 ? ExitCode.Success : ExitCode.Failure;
        }
        else
        {
            using var outDs = Gdal.wrapper_GDALNearblackDestName(dst, srcDs, opts, null, null);
            return outDs == null ? ExitCode.Failure : ExitCode.Success;
        }
    }
}
