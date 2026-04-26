using EzGdal.Util;

namespace EzGdal.Applets;

internal static class CompletionApplet
{
    public static int Run(string[] args)
    {
        if (args.Length == 0)
        {
            Console.Error.WriteLine("completion: シェル名を指定してください");
            Usage();
            return ExitCode.UsageError;
        }

        if (args[0] is "-h" or "--help")
        {
            Usage();
            return ExitCode.Success;
        }

        var resourceName = args[0] switch
        {
            "bash"       => "EzGdal.completions.ezgdal.bash",
            "zsh"        => "EzGdal.completions.ezgdal.zsh",
            "fish"       => "EzGdal.completions.ezgdal.fish",
            "powershell" => "EzGdal.completions.ezgdal.ps1",
            _ => null,
        };

        if (resourceName == null)
        {
            Console.Error.WriteLine($"completion: 未知のシェル '{args[0]}'");
            Usage();
            return ExitCode.UsageError;
        }

        // テキスト読みすると CRLF/LF 変換が入り bash の heredoc 等を壊し得る。
        using var stream = typeof(CompletionApplet).Assembly.GetManifestResourceStream(resourceName);
        if (stream == null)
        {
            Console.Error.WriteLine($"completion: 内蔵リソースが見つかりません: {resourceName}");
            return ExitCode.Failure;
        }

        using var stdout = Console.OpenStandardOutput();
        try
        {
            stream.CopyTo(stdout);
        }
        catch (IOException)
        {
            // `ezgdal completion fish | head` のような診断ユースで受け手が早期に
            // pipe を閉じた際の broken pipe を握り潰す。.NET 既定の unhandled
            // 経路だと stack trace が表示されてユーザーを混乱させるため。
        }
        return ExitCode.Success;
    }

    static void Usage()
    {
        Console.Error.WriteLine("使い方: ezgdal completion <bash|zsh|fish|powershell>");
        Console.Error.WriteLine();
        Console.Error.WriteLine("対応シェルの補完スクリプトを stdout に出力します。");
        Console.Error.WriteLine();
        Console.Error.WriteLine("例 (各シェルの rc に追記、続けて source で現在のセッションにも反映):");
        Console.Error.WriteLine("  bash       : echo 'eval \"$(ezgdal completion bash)\"' >> ~/.bashrc && source ~/.bashrc");
        Console.Error.WriteLine("  zsh        : echo 'eval \"$(ezgdal completion zsh)\"' >> ~/.zshrc && source ~/.zshrc");
        Console.Error.WriteLine("  fish       : echo 'ezgdal completion fish | source' >> ~/.config/fish/config.fish && source ~/.config/fish/config.fish");
        Console.Error.WriteLine("  powershell : Add-Content $PROFILE 'ezgdal completion powershell | Out-String | Invoke-Expression'; . $PROFILE");
    }
}
