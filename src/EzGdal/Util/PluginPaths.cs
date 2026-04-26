namespace EzGdal.Util;

// ユーザーローカルに配置する GDAL 外部ドライバプラグイン (ogr_*.so /
// gdal_*.dylib / *.dll) のディレクトリを OS 別に決定する。
//
// .NET の Environment.SpecialFolder.LocalApplicationData は Linux /
// Windows では妥当な値 (XDG_DATA_HOME / %LOCALAPPDATA%) を返すが、
// macOS では ~/.local/share を返してしまい Apple 慣習からズレる。
// macOS のみ手動で ~/Library/Application Support を組み立てる。
internal static class PluginPaths
{
    public const string AppFolderName = "ezgdal";
    public const string PluginFolderName = "plugins";

    public static string GetUserPluginDir()
    {
        if (OperatingSystem.IsMacOS())
        {
            var home = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);
            return Path.Combine(home, "Library", "Application Support", AppFolderName, PluginFolderName);
        }

        if (OperatingSystem.IsLinux())
        {
            // XDG Base Directory Specification:
            // $XDG_DATA_HOME (未設定なら ~/.local/share)
            var xdg = Environment.GetEnvironmentVariable("XDG_DATA_HOME");
            if (string.IsNullOrEmpty(xdg))
            {
                var home = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);
                xdg = Path.Combine(home, ".local", "share");
            }
            return Path.Combine(xdg, AppFolderName, PluginFolderName);
        }

        // Windows: %APPDATA% (= Roaming) を使う。Roaming プロファイルでも
        // ユーザーごとの追加プラグインを引き回したいケースが想定されるため、
        // LocalApplicationData (= %LOCALAPPDATA%) ではなく ApplicationData。
        var appdata = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
        return Path.Combine(appdata, AppFolderName, PluginFolderName);
    }

    public static void EnsureExists(string dir) => Directory.CreateDirectory(dir);

    public static bool IsPluginFile(string path) =>
        Path.GetExtension(path).ToLowerInvariant() is ".so" or ".dylib" or ".dll";
}
