using EzGdal.Applets;

namespace EzGdal;

internal static class Program
{
    static int Main(string[] args)
    {
        try
        {
            Bootstrap.Initialize();
            return Dispatch(ResolveAppName(), args);
        }
        catch (ApplicationException)
        {
            // GDAL は CPLError ハンドラ経由で stderr に "ERROR N: ..." を既に出している。
            // ex.Message を再出力すると重複するため握りつぶす。
            return Util.ExitCode.Failure;
        }
    }

    static string ResolveAppName()
    {
        // .NET の AppHost は managed Main() が argv[0] を見る前に解決後のパスへ書き換える。
        // そのため OS レベルの呼び出しパス（symlink / hardlink 名を保持する側）を読む。
        var raw = NativeExecutablePath.Get()
                  ?? Environment.GetCommandLineArgs().FirstOrDefault()
                  ?? Environment.ProcessPath
                  ?? "ezgdal";
        var name = Path.GetFileName(raw);
        if (name.EndsWith(".exe", StringComparison.OrdinalIgnoreCase))
            name = name[..^4];
        return name;
    }

    static int Dispatch(string appName, string[] args)
    {
        if (AppletRegistry.Dispatchers.TryGetValue(appName, out var handler))
            return handler(args);

        if (appName is "ezgdal" or "gdal")
            return RunMainEntry(args);

        return UnknownApplet(appName);
    }

    static int RunMainEntry(string[] args)
    {
        if (args.Length > 0)
        {
            if (args[0] == "install-applets")
                return InstallAppletsApplet.Run(args[1..]);
            if (args[0] == "uninstall-applets")
                return InstallAppletsApplet.Run(["--uninstall", .. args[1..]]);
        }
        return UnifiedCliApplet.Run(args);
    }

    static int UnknownApplet(string name)
    {
        Console.Error.WriteLine($"ezgdal: unknown applet '{name}'.");
        Console.Error.WriteLine("Rename or symlink the binary to one of:");
        foreach (var n in AppletRegistry.AllNames)
            Console.Error.WriteLine($"  {n}");
        Console.Error.WriteLine("Or invoke as 'ezgdal <subcommand> ...' / 'gdal <subcommand> ...'.");
        return Util.ExitCode.UsageError;
    }
}
