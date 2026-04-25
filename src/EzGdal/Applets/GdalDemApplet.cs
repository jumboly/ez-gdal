using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

internal static class GdalDemApplet
{
    private static readonly HashSet<string> Modes = new(StringComparer.Ordinal)
    {
        "hillshade", "slope", "aspect", "color-relief", "TRI", "TPI", "Roughness"
    };

    private static readonly Dictionary<string, int> Arity = new(StringComparer.Ordinal)
    {
        ["-of"] = 1, ["-co"] = 1, ["-q"] = 0, ["-quiet"] = 0,
        ["-z"] = 1, ["-s"] = 1, ["-az"] = 1, ["-alt"] = 1,
        ["-alg"] = 1, ["-combined"] = 0, ["-multidirectional"] = 0,
        ["-igor"] = 0, ["-compute_edges"] = 0, ["-b"] = 1,
        ["-trigonometric"] = 0, ["-zero_for_flat"] = 0,
        ["-alpha"] = 0, ["-exact_color_entry"] = 0, ["-nearest_color_entry"] = 0,
        ["-oo"] = 1, ["-if"] = 1, ["-p"] = 0,
    };

    public static int Run(string[] args)
    {
        if (args.Length < 1 || !Modes.Contains(args[0]))
        {
            Console.Error.WriteLine("Usage: gdaldem <mode> <src> <dst> [options]");
            Console.Error.WriteLine("  mode: hillshade | slope | aspect | color-relief | TRI | TPI | Roughness");
            return ExitCode.UsageError;
        }
        var mode = args[0];
        var rest = args.Skip(1).ToArray();

        var (options, positionals) = new ArgParser(Arity).Split(rest);

        // color-relief takes 3 positionals: src, color_filename, dst
        string colorFile = string.Empty;
        string src, dst;
        if (mode == "color-relief")
        {
            if (positionals.Count != 3) { Console.Error.WriteLine("color-relief needs <src> <color_text_file> <dst>"); return ExitCode.UsageError; }
            src = positionals[0]; colorFile = positionals[1]; dst = positionals[2];
        }
        else
        {
            if (positionals.Count != 2) { Console.Error.WriteLine($"{mode} needs <src> <dst>"); return ExitCode.UsageError; }
            src = positionals[0]; dst = positionals[1];
        }

        using var srcDs = GdalHelper.OpenOrFail(src, GdalHelper.OpenRasterRead, "gdaldem");
        if (srcDs == null) return ExitCode.Failure;

        using var opts = new GDALDEMProcessingOptions(options.ToArray());
        using var outDs = Gdal.wrapper_GDALDEMProcessing(dst, srcDs, mode, colorFile, opts, null, null);
        return outDs == null ? ExitCode.Failure : ExitCode.Success;
    }
}
