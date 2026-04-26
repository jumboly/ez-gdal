using System.Runtime.InteropServices;
using System.Text;

namespace EzGdal;

// ユーザーがバイナリを呼び出した際のパス（symlink / hardlink 名を保持）を返す。
// .NET の AppHost は managed Main() に渡す前に argv[0] を解決後のパスへ書き換え
// るため、argv[0] ディスパッチには OS レベルの呼び出しパスが必要。
internal static class NativeExecutablePath
{
    [DllImport("/usr/lib/libSystem.dylib", EntryPoint = "_NSGetExecutablePath")]
    private static extern int MacGetExecutablePath(byte[] buf, ref uint bufsize);

    public static string? Get()
    {
        try
        {
            if (OperatingSystem.IsMacOS())
                return GetMac();
            if (OperatingSystem.IsLinux())
                return GetLinux();
            if (OperatingSystem.IsWindows())
                return GetWindows();
        }
        catch
        {
            // ベストエフォート。失敗時は呼び出し側で GetCommandLineArgs() / ProcessPath にフォールバック。
        }
        return null;
    }

    static string? GetMac()
    {
        uint size = 1024;
        var buf = new byte[size];
        if (MacGetExecutablePath(buf, ref size) != 0)
        {
            // 1 回目が失敗するのはバッファ不足のときで、このとき size に必要バイト数が入る。
            buf = new byte[size];
            if (MacGetExecutablePath(buf, ref size) != 0) return null;
        }
        var nul = Array.IndexOf(buf, (byte)0);
        return Encoding.UTF8.GetString(buf, 0, nul < 0 ? (int)size : nul);
    }

    static string? GetLinux()
    {
        // /proc/self/cmdline は kernel が exec 時に保存した argv を NUL 区切りで保持している。
        var raw = File.ReadAllBytes("/proc/self/cmdline");
        var nul = Array.IndexOf(raw, (byte)0);
        return nul > 0 ? Encoding.UTF8.GetString(raw, 0, nul) : null;
    }

    static string? GetWindows()
    {
        // Windows .NET tool では Environment.GetCommandLineArgs()[0] が managed
        // entry assembly (`ezgdal.dll`) を返してしまうため applet 解決に使えない。
        // ProcessPath は内部的に GetModuleFileName(NULL) で apphost の .exe パスを
        // 取り、symlink (Dev Mode 有効時) も copy 経路 (gdalinfo.exe 等) も
        // ユーザーが叩いたファイル名そのままを返す。
        return Environment.ProcessPath;
    }
}
