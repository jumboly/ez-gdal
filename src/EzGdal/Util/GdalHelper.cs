using OSGeo.GDAL;

namespace EzGdal.Util;

internal static class GdalHelper
{
    public static readonly uint OpenRasterRead = (uint)(GdalConst.OF_RASTER | GdalConst.OF_VERBOSE_ERROR | GdalConst.OF_READONLY);
    public static readonly uint OpenRasterUpdate = (uint)(GdalConst.OF_RASTER | GdalConst.OF_VERBOSE_ERROR | GdalConst.OF_UPDATE);
    public static readonly uint OpenVectorRead = (uint)(GdalConst.OF_VECTOR | GdalConst.OF_VERBOSE_ERROR | GdalConst.OF_READONLY);
    public static readonly uint OpenMultiDimRead = (uint)(GdalConst.OF_MULTIDIM_RASTER | GdalConst.OF_VERBOSE_ERROR | GdalConst.OF_READONLY);

    public static Dataset? OpenOrFail(string path, uint flags, string appletName)
    {
        var ds = Gdal.OpenEx(path, flags, null, null, null);
        if (ds == null)
            Console.Error.WriteLine($"{appletName}: could not open '{path}'");
        return ds;
    }
}
