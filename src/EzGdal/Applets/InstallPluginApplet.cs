using System.Text;
using System.Text.RegularExpressions;
using EzGdal.Util;
using OSGeo.GDAL;

namespace EzGdal.Applets;

internal static partial class InstallPluginApplet
{
    public static int Run(string[] args)
    {
        string? prefix = null;
        bool force = false;
        bool noAbiCheck = false;
        bool quiet = false;
        var inputs = new List<string>();

        for (int i = 0; i < args.Length; i++)
        {
            switch (args[i])
            {
                case "--prefix":
                    if (++i >= args.Length) { Usage(); return ExitCode.UsageError; }
                    prefix = args[i];
                    break;
                case "--force":
                    force = true;
                    break;
                case "--no-abi-check":
                    noAbiCheck = true;
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
                        Console.Error.WriteLine($"install-plugin: 不明なオプション '{args[i]}'");
                        Usage();
                        return ExitCode.UsageError;
                    }
                    inputs.Add(args[i]);
                    break;
            }
        }

        if (inputs.Count == 0)
        {
            Console.Error.WriteLine("install-plugin: インストール対象のファイルを 1 つ以上指定してください");
            Usage();
            return ExitCode.UsageError;
        }

        var dst = prefix ?? PluginPaths.GetUserPluginDir();
        try
        {
            PluginPaths.EnsureExists(dst);
        }
        catch (Exception ex)
        {
            Console.Error.WriteLine($"install-plugin: ディレクトリ作成に失敗: {dst}: {ex.Message}");
            return ExitCode.Failure;
        }

        if (!quiet)
        {
            Console.WriteLine($"インストール先: {dst}");
            Console.WriteLine($"内蔵 GDAL: {Gdal.VersionInfo("RELEASE_NAME")}");
            Console.WriteLine();
        }

        int ok = 0, fail = 0;
        foreach (var src in inputs)
        {
            if (TryInstall(src, dst, force, noAbiCheck, quiet))
                ok++;
            else
                fail++;
        }

        if (!quiet)
        {
            Console.WriteLine();
            Console.WriteLine($"完了: 成功 {ok} 件 / 失敗 {fail} 件");
            if (ok > 0)
            {
                Console.WriteLine(prefix == null
                    ? "次回 ezgdal 起動時に自動でロードされます。"
                    : $"--prefix で配置したため自動ロードされません。GDAL_DRIVER_PATH={dst} を立てて利用してください。");
            }
        }

        return fail == 0 ? ExitCode.Success : ExitCode.Failure;
    }

    static bool TryInstall(string src, string dst, bool force, bool noAbiCheck, bool quiet)
    {
        if (!File.Exists(src))
        {
            Console.Error.WriteLine($"install-plugin: ファイルが存在しません: {src}");
            return false;
        }

        var name = Path.GetFileName(src);
        if (!PluginPaths.IsPluginFile(name))
        {
            Console.Error.WriteLine($"install-plugin: 拡張子が .so/.dylib/.dll ではありません: {name}");
            return false;
        }

        // GDAL の AutoLoadDrivers はファイル名 prefix から登録関数を導出するため、
        // ogr_<Name> / gdal_<Name> 以外はそもそもロードされない。
        if (!name.StartsWith("ogr_", StringComparison.Ordinal)
            && !name.StartsWith("gdal_", StringComparison.Ordinal))
        {
            Console.Error.WriteLine($"install-plugin: ファイル名は 'ogr_' または 'gdal_' で始まる必要があります: {name}");
            return false;
        }

        var ext = Path.GetExtension(name).ToLowerInvariant();
        var validExts = OperatingSystem.IsWindows() ? new[] { ".dll" }
                      : OperatingSystem.IsMacOS()   ? new[] { ".so", ".dylib" }
                      : new[] { ".so" };
        if (!validExts.Contains(ext))
        {
            Console.Error.WriteLine($"install-plugin: 警告: 現プラットフォーム ({RuntimeId()}) で {ext} は通常ロードされません");
            if (!force)
            {
                Console.Error.WriteLine("  --force で続行できます");
                return false;
            }
        }

        if (!noAbiCheck)
        {
            CheckAbi(src, quiet);
        }

        var target = Path.Combine(dst, name);
        if (File.Exists(target) && !force)
        {
            Console.Error.WriteLine($"install-plugin: 既に存在します (--force で上書き): {target}");
            return false;
        }

        try
        {
            File.Copy(src, target, overwrite: true);
        }
        catch (Exception ex)
        {
            Console.Error.WriteLine($"install-plugin: コピー失敗 {src} -> {target}: {ex.Message}");
            return false;
        }

        if (!quiet) Console.WriteLine($"installed: {target}");
        return true;
    }

    [GeneratedRegex(@"GDAL ([0-9]+)\.([0-9]+)\.([0-9]+)", RegexOptions.CultureInvariant)]
    private static partial Regex GdalVersionRegex();

    // 共有ライブラリのバージョン文字列は通常 .rodata に埋め込まれ、ファイル先頭から
    // 数 MB 以内に位置する。全体を読まずに上限付きで stream 読みする。
    private const int AbiScanLimitBytes = 8 * 1024 * 1024;

    static void CheckAbi(string path, bool quiet)
    {
        var pluginVersions = ScanGdalVersionStrings(path);
        var current = Gdal.VersionInfo("RELEASE_NAME") ?? "";

        if (pluginVersions.Count == 0)
        {
            if (!quiet)
                Console.WriteLine($"  abi-check: プラグイン内に GDAL バージョン文字列なし (内蔵: {current})");
            return;
        }

        var currentMatch = GdalVersionRegex().Match("GDAL " + current);
        if (!currentMatch.Success)
            return;

        var curMajor = currentMatch.Groups[1].Value;
        var curMinor = currentMatch.Groups[2].Value;
        var compatible = pluginVersions.Any(v =>
        {
            var parts = v.Split('.');
            return parts.Length >= 2 && parts[0] == curMajor && parts[1] == curMinor;
        });

        if (compatible)
        {
            if (!quiet) Console.WriteLine($"  abi-check: OK (検出: {string.Join(", ", pluginVersions)} / 内蔵: {current})");
        }
        else
        {
            Console.Error.WriteLine($"  abi-check: 警告: minor バージョン不一致 (検出: {string.Join(", ", pluginVersions)} / 内蔵: {current})");
            Console.Error.WriteLine("    異なる minor では silent crash / dlopen 失敗が起きうる。--no-abi-check で抑制可。");
        }
    }

    static HashSet<string> ScanGdalVersionStrings(string path)
    {
        var found = new HashSet<string>();
        try
        {
            using var fs = File.OpenRead(path);
            var len = (int)Math.Min(fs.Length, AbiScanLimitBytes);
            var buf = new byte[len];
            int read = 0;
            while (read < len)
            {
                var n = fs.Read(buf, read, len - read);
                if (n <= 0) break;
                read += n;
            }
            var text = Encoding.ASCII.GetString(buf, 0, read);
            foreach (Match m in GdalVersionRegex().Matches(text))
                found.Add($"{m.Groups[1].Value}.{m.Groups[2].Value}.{m.Groups[3].Value}");
        }
        catch
        {
            // best-effort: 読めなければ空集合を返す
        }
        return found;
    }

    static string RuntimeId() =>
          OperatingSystem.IsMacOS()   ? "macOS"
        : OperatingSystem.IsLinux()   ? "Linux"
        : OperatingSystem.IsWindows() ? "Windows"
        : "unknown";

    static void Usage()
    {
        Console.Error.WriteLine("使い方: ezgdal install-plugin <ファイル...> [オプション]");
        Console.Error.WriteLine();
        Console.Error.WriteLine("外部 GDAL ドライバプラグイン (ogr_<Name>.{so,dylib,dll} など) をユーザー");
        Console.Error.WriteLine("ローカルディレクトリにコピーします。次回起動時に自動ロードされます。");
        Console.Error.WriteLine();
        Console.Error.WriteLine("オプション:");
        Console.Error.WriteLine("  --prefix <dir>   配置先ディレクトリ (省略時はユーザーディレクトリ)");
        Console.Error.WriteLine("  --force          既存ファイルを上書き / 警告を無視して続行");
        Console.Error.WriteLine("  --no-abi-check   ABI 互換性警告を抑制");
        Console.Error.WriteLine("  -q, --quiet      進捗出力を抑制");
        Console.Error.WriteLine("  -h, --help       このヘルプを表示");
    }
}
