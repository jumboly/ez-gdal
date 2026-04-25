using EzGdal.Util;

namespace EzGdal.Applets;

// ezgdal バイナリへの symlink / コピーを GDAL EXE 名（gdalinfo, gdal_translate,
// ogr2ogr, ...）でインストール先ディレクトリに作成する。これにより既存の
// GDAL スクリプトをそのまま実行できる。
//
// デフォルトのインストール先は ezgdal バイナリ自身が置かれているディレクトリで、
// `dotnet tool install -g` 後は `~/.dotnet/tools` (Unix) / `%USERPROFILE%\.dotnet\tools`
// (Windows) になる。これらは既に PATH に含まれているのが通常なので、追加設定なしで
// 各 applet が利用可能になる。
internal static class InstallAppletsApplet
{
    public static int Run(string[] args)
    {
        string? prefix = null;
        bool uninstall = false;
        bool quiet = false;
        bool forceCopy = false;

        for (int i = 0; i < args.Length; i++)
        {
            switch (args[i])
            {
                case "--prefix":
                    if (++i >= args.Length) { Usage(); return ExitCode.UsageError; }
                    prefix = args[i];
                    break;
                case "--uninstall":
                    uninstall = true;
                    break;
                case "--copy":
                    forceCopy = true;
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
                    Console.Error.WriteLine($"install-applets: 不明なオプション '{args[i]}'");
                    Usage();
                    return ExitCode.UsageError;
            }
        }

        var srcExe = Environment.ProcessPath;
        if (string.IsNullOrEmpty(srcExe))
        {
            Console.Error.WriteLine("install-applets: ezgdal バイナリのパスを特定できません");
            return ExitCode.Failure;
        }

        prefix ??= Path.GetDirectoryName(srcExe)!;
        if (!Directory.Exists(prefix))
        {
            Console.Error.WriteLine($"install-applets: ディレクトリが存在しません: {prefix}");
            return ExitCode.Failure;
        }

        int created = 0, removed = 0;
        var ext = OperatingSystem.IsWindows() ? ".exe" : "";

        foreach (var n in AppletRegistry.AllNames)
        {
            var target = Path.Combine(prefix, n + ext);

            if (uninstall)
            {
                if (TryRemove(target))
                {
                    removed++;
                    if (!quiet) Console.WriteLine($"removed:  {target}");
                }
                continue;
            }

            TryRemove(target);
            try
            {
                if (forceCopy)
                {
                    File.Copy(srcExe, target, overwrite: true);
                    if (!quiet) Console.WriteLine($"copied:   {target}");
                }
                else
                {
                    File.CreateSymbolicLink(target, srcExe);
                    if (!quiet) Console.WriteLine($"symlink:  {target} -> {srcExe}");
                }
                created++;
            }
            catch (Exception ex) when (!forceCopy)
            {
                // Windows で Developer Mode が無効だと symlink 作成が失敗するためコピーへフォールバック。
                try
                {
                    File.Copy(srcExe, target, overwrite: true);
                    if (!quiet) Console.WriteLine($"copied:   {target}  ({ex.GetType().Name})");
                    created++;
                }
                catch (Exception ex2)
                {
                    Console.Error.WriteLine($"install-applets: 失敗 {target}: {ex2.Message}");
                }
            }
        }

        if (!quiet)
        {
            Console.WriteLine();
            Console.WriteLine(uninstall
                ? $"{prefix} から {removed} 個の applet を削除しました"
                : $"{prefix} に {created} 個の applet をインストールしました");
        }
        return ExitCode.Success;
    }

    static bool TryRemove(string path)
    {
        try
        {
            File.Delete(path);
            return true;
        }
        catch (FileNotFoundException) { return false; }
        catch (DirectoryNotFoundException) { return false; }
    }

    static void Usage()
    {
        Console.Error.WriteLine("使い方: ezgdal install-applets [オプション]");
        Console.Error.WriteLine();
        Console.Error.WriteLine("ezgdal バイナリへの symlink / コピーを legacy GDAL EXE 名で作成し、");
        Console.Error.WriteLine("'gdalinfo', 'gdal_translate', 'ogr2ogr' 等のスクリプトを ezgdal 経由で動かします。");
        Console.Error.WriteLine();
        Console.Error.WriteLine("オプション:");
        Console.Error.WriteLine("  --prefix <dir>   インストール先ディレクトリ");
        Console.Error.WriteLine("                   (省略時: ezgdal バイナリのあるディレクトリ。");
        Console.Error.WriteLine("                   `dotnet tool install -g` 後は ~/.dotnet/tools)");
        Console.Error.WriteLine("  --uninstall      作成済みの applet を削除");
        Console.Error.WriteLine("  --copy           symlink ではなくコピーを作成");
        Console.Error.WriteLine("                   (Windows で Developer Mode が無効な場合等)");
        Console.Error.WriteLine("  -q, --quiet      ファイル単位の出力を抑制");
        Console.Error.WriteLine("  -h, --help       このヘルプを表示");
    }
}
