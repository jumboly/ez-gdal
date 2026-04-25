using System.Reflection;
using MaxRev.Gdal.Core;
using OSGeo.GDAL;
using OSGeo.OGR;

namespace EzGdal.DriverProbe;

internal static class Program
{
    static int Main(string[] args)
    {
        Console.WriteLine("=== ez-gdal DriverProbe ===");
        Console.WriteLine($"Process arch: {System.Runtime.InteropServices.RuntimeInformation.ProcessArchitecture}");
        Console.WriteLine($"OS: {System.Runtime.InteropServices.RuntimeInformation.OSDescription}");
        Console.WriteLine();

        Console.WriteLine("[Probe] Calling GdalBase.ConfigureAll()...");
        GdalBase.ConfigureAll();

        Console.WriteLine($"GDAL version: {Gdal.VersionInfo("RELEASE_NAME")}");
        Console.WriteLine($"GDAL build:   {Gdal.VersionInfo("BUILD_INFO")}");
        Console.WriteLine();

        // --- Probe 1: PMTiles 含有 + Create capability ---
        Console.WriteLine("[Probe 1] Driver enumeration");
        Console.WriteLine("  GDAL (raster) drivers: " + Gdal.GetDriverCount());
        Console.WriteLine("  OGR (vector) drivers : " + Ogr.GetDriverCount());

        var pmtilesGdal = Gdal.GetDriverByName("PMTiles");
        var pmtilesOgr = Ogr.GetDriverByName("PMTiles");
        Console.WriteLine();
        Console.WriteLine($"  PMTiles in GDAL (raster): {(pmtilesGdal != null ? "FOUND" : "missing")}");
        if (pmtilesGdal != null)
        {
            DumpDriverCaps(pmtilesGdal);
        }
        Console.WriteLine($"  PMTiles in OGR  (vector): {(pmtilesOgr != null ? "FOUND" : "missing")}");
        if (pmtilesOgr != null)
        {
            Console.WriteLine($"    Name: {pmtilesOgr.GetName()}");
        }

        Console.WriteLine();
        Console.WriteLine("[All raster drivers]");
        for (var i = 0; i < Gdal.GetDriverCount(); i++)
        {
            var d = Gdal.GetDriver(i);
            Console.Write($"{d.ShortName} ");
        }
        Console.WriteLine();
        Console.WriteLine();
        Console.WriteLine("[All vector drivers]");
        for (var i = 0; i < Ogr.GetDriverCount(); i++)
        {
            var d = Ogr.GetDriver(i);
            Console.Write($"{d.GetName()} ");
        }
        Console.WriteLine();
        Console.WriteLine();

        // --- Probe 2: GDALAlgorithm API の C# expose 確認 ---
        Console.WriteLine("[Probe 2] GDALAlgorithm exposure in OSGeo.GDAL bindings");
        var gdalAssembly = typeof(Gdal).Assembly;
        var algoTypes = gdalAssembly.GetTypes()
            .Where(t => t.Namespace?.StartsWith("OSGeo") == true)
            .Where(t => t.Name.Contains("Algorithm", StringComparison.OrdinalIgnoreCase))
            .ToList();
        Console.WriteLine($"  Types with 'Algorithm' in name: {algoTypes.Count}");
        foreach (var t in algoTypes)
        {
            Console.WriteLine($"    {t.FullName}");
        }
        var gdalAlgoMethods = typeof(Gdal).GetMethods(BindingFlags.Public | BindingFlags.Static)
            .Where(m => m.Name.Contains("Algorithm", StringComparison.OrdinalIgnoreCase))
            .ToList();
        Console.WriteLine($"  Static methods on Gdal with 'Algorithm' in name: {gdalAlgoMethods.Count}");
        foreach (var m in gdalAlgoMethods)
        {
            Console.WriteLine($"    {m}");
        }

        Console.WriteLine();
        Console.WriteLine("[Probe 2b] Public methods on Algorithm / AlgorithmArg / AlgorithmRegistry");
        foreach (var t in algoTypes)
        {
            Console.WriteLine($"  -- {t.FullName}");
            foreach (var m in t.GetMethods(BindingFlags.Public | BindingFlags.Instance | BindingFlags.Static | BindingFlags.DeclaredOnly).OrderBy(x => x.Name))
            {
                Console.WriteLine($"    {m}");
            }
        }
        Console.WriteLine();
        Console.WriteLine("[Probe 2c] GdalConst constants relevant to OpenEx flags");
        var gdalConstType = gdalAssembly.GetTypes().FirstOrDefault(t => t.Name == "GdalConst");
        if (gdalConstType != null)
        {
            foreach (var f in gdalConstType.GetFields(BindingFlags.Public | BindingFlags.Static)
                .Where(f => f.Name.Contains("OF_") || f.Name.Contains("READ") || f.Name.Contains("UPDATE")))
            {
                Console.WriteLine($"    {f.Name} = {f.GetValue(null)}");
            }
        }
        else
        {
            Console.WriteLine("  GdalConst type not found");
        }

        Console.WriteLine();
        Console.WriteLine("[Probe 4] Gdal Util API wrapper methods");
        var wrappers = typeof(Gdal).GetMethods(BindingFlags.Public | BindingFlags.Static)
            .Where(m => m.Name.StartsWith("wrapper_GDAL") || (m.Name.Contains("DEMProcessing") || m.Name.Contains("BuildOverview") || m.Name.Contains("Footprint") || m.Name.Contains("Tindex") || m.Name.Contains("Nearblack") || m.Name.Contains("Viewshed") || m.Name.Contains("Grid") || m.Name.Contains("Rasterize") || m.Name.Contains("BuildVRT") || m.Name.Contains("Warp") || m.Name.Contains("Contour") || m.Name.Contains("MultiDim") || m.Name.Contains("Translate") || m.Name.Contains("Create") || m.Name.Contains("VectorTranslate") || m.Name.Contains("Sozip")))
            .Select(m => m.ToString())
            .Distinct()
            .OrderBy(s => s);
        foreach (var w in wrappers)
            Console.WriteLine($"  {w}");

        Console.WriteLine();
        Console.WriteLine("[Probe 4b] Options classes available");
        var opts = gdalAssembly.GetTypes()
            .Where(t => t.Namespace == "OSGeo.GDAL" && t.Name.EndsWith("Options"))
            .OrderBy(t => t.Name);
        foreach (var t in opts)
            Console.WriteLine($"  {t.Name}");

        // --- Probe 3: 環境変数の漏れチェックの下準備 ---
        Console.WriteLine();
        Console.WriteLine("[Probe 3] Process env after ConfigureAll()");
        foreach (var key in new[] { "GDAL_DATA", "PROJ_LIB", "PROJ_DATA", "GDAL_DRIVER_PATH" })
        {
            var v = Environment.GetEnvironmentVariable(key);
            Console.WriteLine($"  {key} = {v ?? "<unset>"}");
        }

        return 0;
    }

    static void DumpDriverCaps(OSGeo.GDAL.Driver d)
    {
        Console.WriteLine($"    ShortName: {d.ShortName}");
        Console.WriteLine($"    LongName : {d.LongName}");
        var meta = d.GetMetadata("");
        if (meta != null)
        {
            foreach (var line in meta)
            {
                if (line.StartsWith("DCAP_") || line.StartsWith("DMD_EXTENSIONS") || line.StartsWith("DMD_LONGNAME"))
                {
                    Console.WriteLine($"    {line}");
                }
            }
        }
    }
}
