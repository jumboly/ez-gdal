namespace EzGdal.Util;

internal sealed class ArgParser
{
    private readonly Dictionary<string, int> _optionArity;

    public ArgParser(IDictionary<string, int> optionArity)
    {
        _optionArity = new Dictionary<string, int>(optionArity, StringComparer.Ordinal);
    }

    public (List<string> Options, List<string> Positionals) Split(string[] args)
    {
        var options = new List<string>();
        var positionals = new List<string>();
        for (int i = 0; i < args.Length; i++)
        {
            var a = args[i];
            if (a.Length > 0 && a[0] == '-' && a != "-")
            {
                options.Add(a);
                if (_optionArity.TryGetValue(a, out var arity))
                {
                    for (int k = 0; k < arity && i + 1 < args.Length; k++)
                    {
                        options.Add(args[++i]);
                    }
                }
                // 未知のオプションは引数なしとみなしてそのまま渡す。
                // 後続の GDAL Util API 側 (*OptionsNew) が不正なら拒否する。
            }
            else
            {
                positionals.Add(a);
            }
        }
        return (options, positionals);
    }
}
