namespace EzGdal.Applets;

internal static class AppletRegistry
{
    // 旧 GDAL EXE 名互換の単一ソース。Program.Dispatch の振り分けと、
    // `ezgdal install-applets` の symlink 生成の両方からこれを参照する。
    public static readonly Dictionary<string, Func<string[], int>> Dispatchers = new(StringComparer.Ordinal)
    {
        ["gdalinfo"]          = GdalInfoApplet.Run,
        ["gdal_translate"]    = GdalTranslateApplet.Run,
        ["gdalwarp"]          = GdalWarpApplet.Run,
        ["ogr2ogr"]           = Ogr2OgrApplet.Run,
        ["ogrinfo"]           = OgrInfoApplet.Run,
        ["gdaladdo"]          = GdaladdoApplet.Run,
        ["gdalbuildvrt"]      = GdalBuildVrtApplet.Run,
        ["gdal_rasterize"]    = GdalRasterizeApplet.Run,
        ["gdal_grid"]         = GdalGridApplet.Run,
        ["gdaldem"]           = GdalDemApplet.Run,
        ["nearblack"]         = NearblackApplet.Run,
        ["gdalmdimtranslate"] = GdalMdimTranslateApplet.Run,
        ["gdal_contour"]      = GdalContourApplet.Run,
        ["gdal_footprint"]    = GdalFootprintApplet.Run,

        // MaxRev の SWIG バインディングに安定した Util API ラッパーが無いものは、
        // GDAL 3.12+ の統一 CLI 上の同等パスへ転送する。
        ["gdaltindex"]    = args => UnifiedCliApplet.Run(["vector", "tile-index", .. args]),
        ["gdal_create"]   = args => UnifiedCliApplet.Run(["raster", "create",     .. args]),
        ["sozip"]         = args => UnifiedCliApplet.Run(["vsi",    "sozip",      .. args]),
        ["gdal_viewshed"] = args => UnifiedCliApplet.Run(["raster", "viewshed",   .. args]),
    };

    public static IEnumerable<string> AllNames => Dispatchers.Keys;
}
