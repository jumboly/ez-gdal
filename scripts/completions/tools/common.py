"""compile.py / translate-diff.py が共有する GDAL --json-usage ツリーの walker."""
from __future__ import annotations

from typing import Any, Iterator


def walk_tree(node: dict[str, Any], path: str) -> Iterator[tuple[str, dict[str, Any]]]:
    """JSON ツリーを (path, node) で yield する (深さ優先、root を最初に)."""
    yield path, node
    for s in node.get("sub_algorithms", []) or []:
        sname = s.get("name")
        if not sname:
            continue
        yield from walk_tree(s, f"{path}/{sname}")


def normalize_oneline(s: str) -> str:
    """連続空白 (改行・タブ含む) を半角 1 個に潰し、前後 trim する."""
    return " ".join(s.split())
