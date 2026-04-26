using EzGdal.Applets;
using EzGdal.Util;

namespace EzGdal;

internal static class Program
{
    static int Main(string[] args)
    {
        var appName = ResolveAppName();

        // completion は GDAL native を一切触らないため Bootstrap.Initialize() を
        // skip して即座に出力する。eval "$(ezgdal completion bash)" 等を rc に
        // 書く運用ではこれがインタラクティブシェル起動の hot path に乗り、
        // ConfigureAll() の ~100-500ms オーバーヘッドが体感に効くため。
        if (AppletRegistry.IsMainEntry(appName) && args.Length >= 1 && args[0] == "completion")
            return CompletionApplet.Run(args[1..]);

        try
        {
            Bootstrap.Initialize();
            return Dispatch(appName, args);
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
        {
            var processed = GdalCli.Process(appName, args);
            if (processed == null) return Util.ExitCode.Success;
            return handler(processed);
        }

        if (AppletRegistry.IsMainEntry(appName))
            return RunMainEntry(args);

        return UnknownApplet(appName);
    }

    static int RunMainEntry(string[] args)
    {
        if (args.Length > 0)
        {
            // ezgdal 固有のサブコマンド: --prefix 等が GDAL 一般フラグと衝突するため前処理を経由させない。
            if (args[0] == "install-applets")
                return InstallAppletsApplet.Run(args[1..]);
            if (args[0] == "uninstall-applets")
                return InstallAppletsApplet.Run(["--uninstall", .. args[1..]]);
            if (args[0] == "install-plugin")
                return InstallPluginApplet.Run(args[1..]);
            if (args[0] == "list-plugins")
                return ListPluginsApplet.Run(args[1..]);
            if (args[0] == "remove-plugin")
                return RemovePluginApplet.Run(args[1..]);
            // completion は Main() で Bootstrap 前に早期 return 済み

            // `ezgdal gdalinfo ...` 経由でも Dispatch と同じ前処理を適用 (--formats フィルタの applet 別 nOptions が効くように)。
            if (AppletRegistry.Dispatchers.TryGetValue(args[0], out var legacyHandler))
            {
                var legacyProcessed = GdalCli.Process(args[0], args[1..]);
                if (legacyProcessed == null) return Util.ExitCode.Success;
                return legacyHandler(legacyProcessed);
            }
        }

        var processed = GdalCli.Process("ezgdal", args);
        if (processed == null) return Util.ExitCode.Success;
        return UnifiedCliApplet.Run(processed);
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
