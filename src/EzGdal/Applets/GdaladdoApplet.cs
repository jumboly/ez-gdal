using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

// gdaladdo doesn't have a Util API equivalent; we drive Dataset.BuildOverviews
// directly, mirroring the apps/gdaladdo_bin.cpp argv handling.
internal static class GdaladdoApplet
{
    public static int Run(string[] args)
    {
        string resampling = "nearest";
        bool readOnly = false;
        bool clean = false;
        string? src = null;
        var levels = new List<int>();
        var bands = new List<int>();

        for (int i = 0; i < args.Length; i++)
        {
            var a = args[i];
            switch (a)
            {
                case "-r": resampling = args[++i]; break;
                case "-ro": readOnly = true; break;
                case "-clean": clean = true; break;
                case "-q": case "-quiet": break;
                case "-b":
                    if (++i < args.Length && int.TryParse(args[i], out var b)) bands.Add(b);
                    break;
                case "-minsize": case "-oo": case "-co":
                case "--config":
                    i++; // single-arg pass-through that we ignore
                    break;
                default:
                    if (a.StartsWith('-'))
                    {
                        Console.Error.WriteLine($"gdaladdo: unknown option '{a}'");
                        return ExitCode.UsageError;
                    }
                    else if (src == null) src = a;
                    else if (int.TryParse(a, out var lvl)) levels.Add(lvl);
                    else
                    {
                        Console.Error.WriteLine($"gdaladdo: unrecognized positional '{a}'");
                        return ExitCode.UsageError;
                    }
                    break;
            }
        }

        if (src == null)
        {
            Console.Error.WriteLine("Usage: gdaladdo [-r resampling] [-b band]... [-ro] [-clean] <dataset> [<level> ...]");
            return ExitCode.UsageError;
        }

        var openFlags = readOnly ? GdalHelper.OpenRasterRead : GdalHelper.OpenRasterUpdate;
        using var ds = GdalHelper.OpenOrFail(src, openFlags, "gdaladdo");
        if (ds == null) return ExitCode.Failure;

        if (clean)
        {
            return ds.BuildOverviews("NONE", Array.Empty<int>(), null, null) == 0
                ? ExitCode.Success : ExitCode.Failure;
        }

        if (levels.Count == 0)
        {
            // GDAL default behavior: pick natural pyramid based on size.
            var w = ds.RasterXSize;
            var h = ds.RasterYSize;
            int factor = 2;
            while (w / factor >= 256 || h / factor >= 256)
            {
                levels.Add(factor);
                factor *= 2;
                if (factor > 16384) break;
            }
            if (levels.Count == 0) levels.Add(2);
        }

        var rc = ds.BuildOverviews(resampling, levels.ToArray(), null, null);
        return rc == 0 ? ExitCode.Success : ExitCode.Failure;
    }
}
