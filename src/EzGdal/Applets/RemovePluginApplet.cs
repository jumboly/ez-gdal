using EzGdal.Util;

namespace EzGdal.Applets;

// ユーザーローカルプラグインディレクトリ内のファイルを削除する。
// 引数はファイル名 (basename) のみ受け付け、ディレクトリトラバーサル
// (../ や絶対パス) は弾く。--all で全削除 (ディレクトリ自体は残す)。
internal static class RemovePluginApplet
{
    public static int Run(string[] args)
    {
        string? prefix = null;
        bool all = false;
        bool quiet = false;
        var names = new List<string>();

        for (int i = 0; i < args.Length; i++)
        {
            switch (args[i])
            {
                case "--prefix":
                    if (++i >= args.Length) { Usage(); return ExitCode.UsageError; }
                    prefix = args[i];
                    break;
                case "--all":
                    all = true;
                    break;
                case "-q":
                case "--quiet":
                    quiet = true;
                    break;
                case "-h":
                case "--help":
                    Usage();
                    return ExitCode.Success;
                default:
                    if (args[i].StartsWith('-'))
                    {
                        Console.Error.WriteLine($"remove-plugin: 不明なオプション '{args[i]}'");
                        Usage();
                        return ExitCode.UsageError;
                    }
                    names.Add(args[i]);
                    break;
            }
        }

        if (!all && names.Count == 0)
        {
            Console.Error.WriteLine("remove-plugin: 削除対象のファイル名を指定するか --all を使用してください");
            Usage();
            return ExitCode.UsageError;
        }

        var dir = prefix ?? PluginPaths.GetUserPluginDir();
        if (!Directory.Exists(dir))
        {
            Console.Error.WriteLine($"remove-plugin: ディレクトリが存在しません: {dir}");
            return ExitCode.Failure;
        }

        if (all)
        {
            return RemoveAll(dir, quiet);
        }

        int ok = 0, fail = 0;
        foreach (var name in names)
        {
            // ディレクトリトラバーサル防止: パス区切りや相対参照を含む名前を弾く。
            if (name.Contains('/') || name.Contains('\\') || name.Contains("..") || Path.IsPathRooted(name))
            {
                Console.Error.WriteLine($"remove-plugin: ファイル名のみ指定してください (パス不可): {name}");
                fail++;
                continue;
            }

            var target = Path.Combine(dir, name);
            if (!File.Exists(target))
            {
                Console.Error.WriteLine($"remove-plugin: 存在しません: {target}");
                fail++;
                continue;
            }

            try
            {
                File.Delete(target);
                if (!quiet) Console.WriteLine($"removed: {target}");
                ok++;
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine($"remove-plugin: 削除失敗 {target}: {ex.Message}");
                fail++;
            }
        }

        if (!quiet)
        {
            Console.WriteLine();
            Console.WriteLine($"完了: 成功 {ok} 件 / 失敗 {fail} 件");
        }
        return fail == 0 ? ExitCode.Success : ExitCode.Failure;
    }

    static int RemoveAll(string dir, bool quiet)
    {
        var files = Directory.EnumerateFiles(dir)
            .Where(PluginPaths.IsPluginFile)
            .ToList();

        int ok = 0, fail = 0;
        foreach (var f in files)
        {
            try
            {
                File.Delete(f);
                if (!quiet) Console.WriteLine($"removed: {f}");
                ok++;
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine($"remove-plugin: 削除失敗 {f}: {ex.Message}");
                fail++;
            }
        }

        if (!quiet)
        {
            Console.WriteLine();
            Console.WriteLine($"完了: 成功 {ok} 件 / 失敗 {fail} 件");
        }
        return fail == 0 ? ExitCode.Success : ExitCode.Failure;
    }

    static void Usage()
    {
        Console.Error.WriteLine("使い方: ezgdal remove-plugin <ファイル名...>");
        Console.Error.WriteLine("       ezgdal remove-plugin --all");
        Console.Error.WriteLine();
        Console.Error.WriteLine("ユーザーローカルプラグインディレクトリ内のドライバファイルを削除します。");
        Console.Error.WriteLine();
        Console.Error.WriteLine("オプション:");
        Console.Error.WriteLine("  --prefix <dir>   操作対象のディレクトリを上書き");
        Console.Error.WriteLine("  --all            ディレクトリ内の全プラグインを削除");
        Console.Error.WriteLine("  -q, --quiet      進捗出力を抑制");
        Console.Error.WriteLine("  -h, --help       このヘルプを表示");
    }
}
