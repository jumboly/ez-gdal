using EzGdal.Util;

namespace EzGdal.Applets;

// ユーザーローカルプラグインディレクトリに配置されているファイルを一覧する。
// register された driver 名との突合は行わない (ファイル名 stem からの推測は
// 不完全なため、Bootstrap が実際にロードできているかは ogrinfo --formats で
// 確認する運用)。
internal static class ListPluginsApplet
{
    public static int Run(string[] args)
    {
        string? prefix = null;

        for (int i = 0; i < args.Length; i++)
        {
            switch (args[i])
            {
                case "--prefix":
                    if (++i >= args.Length) { Usage(); return ExitCode.UsageError; }
                    prefix = args[i];
                    break;
                case "-h":
                case "--help":
                    Usage();
                    return ExitCode.Success;
                default:
                    Console.Error.WriteLine($"list-plugins: 不明なオプション '{args[i]}'");
                    Usage();
                    return ExitCode.UsageError;
            }
        }

        var dir = prefix ?? PluginPaths.GetUserPluginDir();
        Console.WriteLine($"プラグインディレクトリ: {dir}");

        if (!Directory.Exists(dir))
        {
            Console.WriteLine("(ディレクトリが存在しません)");
            return ExitCode.Success;
        }

        var files = Directory.EnumerateFiles(dir)
            .Where(PluginPaths.IsPluginFile)
            .OrderBy(f => f, StringComparer.Ordinal)
            .ToList();

        if (files.Count == 0)
        {
            Console.WriteLine("(プラグインなし)");
            return ExitCode.Success;
        }

        Console.WriteLine();
        Console.WriteLine($"{"ファイル",-40} {"サイズ",10}  更新日時");
        Console.WriteLine(new string('-', 78));
        foreach (var f in files)
        {
            var fi = new FileInfo(f);
            Console.WriteLine($"{Path.GetFileName(f),-40} {fi.Length,10}  {fi.LastWriteTime:yyyy-MM-dd HH:mm:ss}");
        }
        Console.WriteLine();
        Console.WriteLine($"合計 {files.Count} 個");
        return ExitCode.Success;
    }

    static void Usage()
    {
        Console.Error.WriteLine("使い方: ezgdal list-plugins [--prefix <dir>]");
        Console.Error.WriteLine();
        Console.Error.WriteLine("ユーザーローカルプラグインディレクトリ内のドライバファイルを一覧します。");
        Console.Error.WriteLine();
        Console.Error.WriteLine("オプション:");
        Console.Error.WriteLine("  --prefix <dir>   一覧対象のディレクトリを上書き");
        Console.Error.WriteLine("  -h, --help       このヘルプを表示");
    }
}
