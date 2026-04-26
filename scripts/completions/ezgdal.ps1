# ezgdal / gdal シェル補完 (PowerShell 5.1+ / 7+)。CurrentCulture が ja なら日本語、
# それ以外は英語。再生成は scripts/completions/tools/compile.py

$script:EzGdalTree = @{}

$script:EzGdalTree['gdal'] = @{
    Subs = @(
        @{ Name = 'dataset'; DescEn = 'Commands to manage datasets.'; DescJa = 'データセット管理コマンド' }
        @{ Name = 'driver'; DescEn = 'Command for driver specific operations.'; DescJa = 'ドライバ固有操作のコマンド' }
        @{ Name = 'mdim'; DescEn = 'Multidimensional commands.'; DescJa = '多次元コマンド' }
        @{ Name = 'pipeline'; DescEn = 'Process a dataset applying several steps.'; DescJa = '複数ステップを適用してデータセットを処理' }
        @{ Name = 'raster'; DescEn = 'Raster commands.'; DescJa = 'ラスタコマンド' }
        @{ Name = 'vector'; DescEn = 'Vector commands.'; DescJa = 'ベクタコマンド' }
        @{ Name = 'vsi'; DescEn = 'GDAL Virtual System Interface (VSI) commands.'; DescJa = 'GDAL VSI コマンド' }
    )
    Opts = @(
        @{ Name = '--drivers'; DescEn = 'Display driver list as JSON document'; DescJa = 'ドライバ一覧を JSON で表示' }
    )
}
$script:EzGdalTree['gdal/dataset'] = @{
    Subs = @(
        @{ Name = 'copy'; DescEn = 'Copy files of a dataset.'; DescJa = 'データセットのファイルをコピー' }
        @{ Name = 'delete'; DescEn = 'Delete dataset(s).'; DescJa = 'データセットを削除' }
        @{ Name = 'identify'; DescEn = 'Identify driver opening dataset(s).'; DescJa = 'データセットを開けるドライバを判定' }
        @{ Name = 'rename'; DescEn = 'Rename files of a dataset.'; DescJa = 'データセットのファイルを改名' }
    )
    Opts = @(
    )
}
$script:EzGdalTree['gdal/dataset/copy'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--source'; DescEn = 'Source dataset name'; DescJa = '入力データセット名' }
        @{ Name = '--destination'; DescEn = 'Destination dataset name'; DescJa = '出力データセット名' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--format'; DescEn = 'Dataset format'; DescJa = 'データセットフォーマット' }
    )
}
$script:EzGdalTree['gdal/dataset/delete'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--filename'; DescEn = 'File or directory name'; DescJa = 'ファイル・ディレクトリ名' }
        @{ Name = '--format'; DescEn = 'Dataset format'; DescJa = 'データセットフォーマット' }
    )
}
$script:EzGdalTree['gdal/dataset/identify'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--filename'; DescEn = 'File or directory name'; DescJa = 'ファイル・ディレクトリ名' }
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--recursive'; DescEn = 'Recursively scan files/folders for datasets'; DescJa = 'ファイル・フォルダを再帰的にスキャンしてデータセットを探す' }
        @{ Name = '--force-recursive'; DescEn = 'Recursively scan folders for datasets, forcing recursion in folders recognized as valid formats'; DescJa = 'フォルダを再帰スキャンしてデータセットを探す (有効フォーマット認識フォルダも強制再帰)' }
        @{ Name = '--report-failures'; DescEn = 'Report failures if file type is unidentified'; DescJa = 'ファイル型を判定できなかった場合に失敗を報告' }
    )
}
$script:EzGdalTree['gdal/dataset/rename'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--source'; DescEn = 'Source dataset name'; DescJa = '入力データセット名' }
        @{ Name = '--destination'; DescEn = 'Destination dataset name'; DescJa = '出力データセット名' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--format'; DescEn = 'Dataset format'; DescJa = 'データセットフォーマット' }
    )
}
$script:EzGdalTree['gdal/driver'] = @{
    Subs = @(
        @{ Name = 'gpkg'; DescEn = 'Command for GPKG driver specific operations.'; DescJa = 'GPKG ドライバ固有操作のコマンド' }
        @{ Name = 'gti'; DescEn = 'Command for GTI driver specific operations.'; DescJa = 'GTI ドライバ固有操作のコマンド' }
        @{ Name = 'openfilegdb'; DescEn = 'Command for OpenFileGDB driver specific operations.'; DescJa = 'OpenFileGDB ドライバ固有操作のコマンド' }
        @{ Name = 'pdf'; DescEn = 'Command for PDF driver specific operations.'; DescJa = 'PDF ドライバ固有操作のコマンド' }
    )
    Opts = @(
    )
}
$script:EzGdalTree['gdal/driver/gpkg'] = @{
    Subs = @(
        @{ Name = 'repack'; DescEn = 'Repack/vacuum in-place a GeoPackage dataset'; DescJa = 'GeoPackage データセットをインプレース再パック・vacuum' }
    )
    Opts = @(
    )
}
$script:EzGdalTree['gdal/driver/gpkg/repack'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--dataset'; DescEn = 'GeoPackage dataset'; DescJa = 'GeoPackage データセット' }
    )
}
$script:EzGdalTree['gdal/driver/gti'] = @{
    Subs = @(
        @{ Name = 'create'; DescEn = 'Create an index of raster datasets compatible of the GDAL Tile Index (GTI) driver.'; DescJa = 'GDAL Tile Index (GTI) ドライバ互換のラスタインデックスを作成' }
    )
    Opts = @(
    )
}
$script:EzGdalTree['gdal/driver/gti/create'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--recursive'; DescEn = 'Whether input directories should be explored recursively.'; DescJa = '入力ディレクトリを再帰的に探索するか' }
        @{ Name = '--filename-filter'; DescEn = 'Pattern that the filenames in input directories should follow (''*'' and ''?'' wildcard)'; DescJa = '入力ディレクトリ内ファイル名が従うパターン (''*'' / ''?'' ワイルドカード)' }
        @{ Name = '--min-pixel-size'; DescEn = 'Minimum pixel size in term of geospatial extent per pixel (resolution) that a raster should have to be selected.'; DescJa = '選択対象ラスタの最小ピクセルサイズ (ピクセルあたりの地理範囲、解像度)' }
        @{ Name = '--max-pixel-size'; DescEn = 'Maximum pixel size in term of geospatial extent per pixel (resolution) that a raster should have to be selected.'; DescJa = '選択対象ラスタの最大ピクセルサイズ (ピクセルあたりの地理範囲、解像度)' }
        @{ Name = '--location-name'; DescEn = 'Name of the field with the raster path'; DescJa = 'ラスタパスを格納するフィールド名' }
        @{ Name = '--absolute-path'; DescEn = 'Whether the path to the input datasets should be stored as an absolute path'; DescJa = '入力データセットのパスを絶対パスで格納するか' }
        @{ Name = '--dst-crs'; DescEn = 'Destination CRS'; DescJa = '出力 CRS' }
        @{ Name = '--metadata'; DescEn = 'Add dataset metadata item'; DescJa = 'データセットメタデータ項目を追加' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors related to input datasets'; DescJa = '入力データセット関連エラーをスキップ' }
        @{ Name = '--xml-filename'; DescEn = 'Filename of the XML Virtual Tile Index file to generate, that can be used as an input for the GDAL GTI / Virtual Raster Tile Index driver'; DescJa = '生成する XML 仮想タイルインデックスファイル名 (GDAL GTI ドライバの入力に利用)' }
        @{ Name = '--resolution'; DescEn = 'Resolution (in destination CRS units) of the virtual mosaic'; DescJa = '仮想モザイクの解像度 (出力 CRS 単位)' }
        @{ Name = '--bbox'; DescEn = 'Bounding box (in destination CRS units) of the virtual mosaic'; DescJa = '仮想モザイクのバウンディングボックス (出力 CRS 単位)' }
        @{ Name = '--output-data-type'; DescEn = 'Datatype of the virtual mosaic'; DescJa = '仮想モザイクのデータ型' }
        @{ Name = '--band-count'; DescEn = 'Number of bands of the virtual mosaic'; DescJa = '仮想モザイクのバンド数' }
        @{ Name = '--nodata'; DescEn = 'Nodata value(s) of the bands of the virtual mosaic'; DescJa = '仮想モザイクのバンド nodata 値' }
        @{ Name = '--color-interpretation'; DescEn = 'Color interpretation(s) of the bands of the virtual mosaic'; DescJa = '仮想モザイクのバンド色解釈' }
        @{ Name = '--mask'; DescEn = 'Defines that the virtual mosaic has a mask band'; DescJa = '仮想モザイクがマスクバンドを持つことを定義' }
        @{ Name = '--fetch-metadata'; DescEn = 'Fetch a metadata item from source rasters and write it as a field in the index.'; DescJa = 'ソースラスタからメタデータ項目を取得してインデックスのフィールドに書き込み' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/driver/openfilegdb'] = @{
    Subs = @(
        @{ Name = 'repack'; DescEn = 'Repack a FileGeoDatabase dataset'; DescJa = 'FileGeoDatabase データセットを再パック' }
    )
    Opts = @(
    )
}
$script:EzGdalTree['gdal/driver/openfilegdb/repack'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--dataset'; DescEn = 'FileGeoDatabase dataset'; DescJa = 'FileGeoDatabase データセット' }
    )
}
$script:EzGdalTree['gdal/driver/pdf'] = @{
    Subs = @(
        @{ Name = 'list-layers'; DescEn = 'List layers of a PDF dataset'; DescJa = 'PDF データセットのレイヤを列挙' }
    )
    Opts = @(
    )
}
$script:EzGdalTree['gdal/driver/pdf/list-layers'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input'; DescEn = 'Input raster or vector dataset'; DescJa = '入力ラスタまたはベクタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
    )
}
$script:EzGdalTree['gdal/mdim'] = @{
    Subs = @(
        @{ Name = 'convert'; DescEn = 'Convert a multidimensional dataset.'; DescJa = '多次元データセットを変換' }
        @{ Name = 'info'; DescEn = 'Return information on a multidimensional dataset.'; DescJa = '多次元データセットの情報を返す' }
        @{ Name = 'mosaic'; DescEn = 'Build a mosaic, either virtual (VRT) or materialized, from multidimensional datasets.'; DescJa = '多次元データセットから仮想 (VRT) または実体化モザイクを構築' }
    )
    Opts = @(
        @{ Name = '--drivers'; DescEn = 'Display multidimensional driver list as JSON document'; DescJa = '多次元ドライバ一覧を JSON で表示' }
    )
}
$script:EzGdalTree['gdal/mdim/convert'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input raster or multidimensional raster dataset'; DescJa = '入力ラスタまたは多次元ラスタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--array'; DescEn = 'Select a single array instead of converting the whole dataset.'; DescJa = 'データセット全体ではなく単一配列を選択' }
        @{ Name = '--array-option'; DescEn = 'Option passed to GDALGroup::GetMDArrayNames() to filter arrays.'; DescJa = '配列フィルタ用に GDALGroup::GetMDArrayNames() に渡すオプション' }
        @{ Name = '--group'; DescEn = 'Select a single group instead of converting the whole dataset.'; DescJa = 'データセット全体ではなく単一グループを選択' }
        @{ Name = '--subset'; DescEn = 'Select a subset of the data.'; DescJa = 'データのサブセットを選択' }
        @{ Name = '--scale-axes'; DescEn = 'Applies a integral scale factor to one or several dimensions'; DescJa = '1 つ以上の次元に整数倍率を適用' }
        @{ Name = '--strict'; DescEn = 'Turn warnings into failures.'; DescJa = '警告を失敗として扱う' }
        @{ Name = '--output'; DescEn = 'Output multidimensional raster dataset'; DescJa = '出力多次元ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/mdim/info'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input multidimensional raster dataset'; DescJa = '入力多次元ラスタデータセット' }
        @{ Name = '--detailed'; DescEn = 'Most verbose output. Report attribute data types and array values.'; DescJa = '最詳細出力 (属性データ型と配列値も報告)' }
        @{ Name = '--array'; DescEn = 'Name of the array, used to restrict the output to the specified array.'; DescJa = '出力対象を絞る配列名' }
        @{ Name = '--limit'; DescEn = 'Number of values in each dimension that is used to limit the display of array values.'; DescJa = '配列値の表示を制限するための各次元の値数' }
        @{ Name = '--array-option'; DescEn = 'Option passed to GDALGroup::GetMDArrayNames() to filter reported arrays.'; DescJa = '報告対象配列のフィルタ用に GDALGroup::GetMDArrayNames() に渡すオプション' }
        @{ Name = '--stats'; DescEn = 'Read and display image statistics.'; DescJa = '画像統計を読み取り表示' }
    )
}
$script:EzGdalTree['gdal/mdim/mosaic'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input multidimensional raster datasets'; DescJa = '入力多次元ラスタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--array'; DescEn = 'Name of array(s) to mosaic.'; DescJa = 'モザイク対象の配列名' }
        @{ Name = '--output'; DescEn = 'Output multidimensional raster dataset'; DescJa = '出力多次元ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/pipeline'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input'; DescEn = 'Input raster or vector datasets'; DescJa = '入力ラスタまたはベクタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--pipeline'; DescEn = 'Pipeline string or filename'; DescJa = 'パイプライン文字列またはファイル名' }
        @{ Name = '--output'; DescEn = 'Output raster or vector dataset'; DescJa = '出力ラスタまたはベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster'] = @{
    Subs = @(
        @{ Name = 'as-features'; DescEn = 'Create features from pixels of a raster dataset'; DescJa = 'ラスタピクセルからフィーチャを作成' }
        @{ Name = 'aspect'; DescEn = 'Generate an aspect map'; DescJa = '斜面方位マップを生成' }
        @{ Name = 'blend'; DescEn = 'Blend/compose two raster datasets'; DescJa = '2 つのラスタデータセットをブレンド・合成' }
        @{ Name = 'calc'; DescEn = 'Perform raster algebra'; DescJa = 'ラスタ代数演算を実行' }
        @{ Name = 'clean-collar'; DescEn = 'Clean the collar of a raster dataset, removing noise.'; DescJa = 'ラスタの周辺部を清掃しノイズを除去' }
        @{ Name = 'clip'; DescEn = 'Clip a raster dataset.'; DescJa = 'ラスタデータセットをクリップ' }
        @{ Name = 'color-map'; DescEn = 'Generate a RGB or RGBA dataset from a single band, using a color map'; DescJa = '単一バンドからカラーマップで RGB / RGBA データセットを生成' }
        @{ Name = 'compare'; DescEn = 'Compare two raster datasets.'; DescJa = '2 つのラスタデータセットを比較' }
        @{ Name = 'contour'; DescEn = 'Creates a vector contour from a raster elevation model (DEM).'; DescJa = 'ラスタ DEM からベクタ等高線を作成' }
        @{ Name = 'convert'; DescEn = 'Convert a raster dataset.'; DescJa = 'ラスタデータセットを変換' }
        @{ Name = 'create'; DescEn = 'Create a new raster dataset.'; DescJa = '新規ラスタデータセットを作成' }
        @{ Name = 'edit'; DescEn = 'Edit a raster dataset.'; DescJa = 'ラスタデータセットを編集' }
        @{ Name = 'fill-nodata'; DescEn = 'Fill nodata raster regions by interpolation from edges.'; DescJa = '端からの補間で nodata 領域を埋める' }
        @{ Name = 'footprint'; DescEn = 'Compute the footprint of a raster dataset.'; DescJa = 'ラスタデータセットのフットプリントを計算' }
        @{ Name = 'hillshade'; DescEn = 'Generate a shaded relief map'; DescJa = '陰影起伏マップを生成' }
        @{ Name = 'index'; DescEn = 'Create a vector index of raster datasets.'; DescJa = 'ラスタデータセットのベクタインデックスを作成' }
        @{ Name = 'info'; DescEn = 'Return information on a raster dataset.'; DescJa = 'ラスタデータセットの情報を返す' }
        @{ Name = 'mosaic'; DescEn = 'Build a mosaic, either virtual (VRT) or materialized.'; DescJa = '仮想 (VRT) または実体化モザイクを構築' }
        @{ Name = 'neighbors'; DescEn = 'Compute the value of each pixel from its neighbors (focal statistics)'; DescJa = '近傍から各ピクセル値を計算 (focal statistics)' }
        @{ Name = 'nodata-to-alpha'; DescEn = 'Replace nodata value(s) with an alpha band.'; DescJa = 'nodata 値をアルファバンドに置換' }
        @{ Name = 'overview'; DescEn = 'Manage overviews of a raster dataset.'; DescJa = 'ラスタデータセットのオーバビューを管理' }
        @{ Name = 'pansharpen'; DescEn = 'Perform a pansharpen operation.'; DescJa = 'パンシャープン処理を実行' }
        @{ Name = 'pipeline'; DescEn = 'Process a raster dataset applying several steps.'; DescJa = '複数ステップを適用してラスタデータセットを処理' }
        @{ Name = 'pixel-info'; DescEn = 'Return information on a pixel of a raster dataset.'; DescJa = 'ラスタデータセットのピクセル情報を返す' }
        @{ Name = 'polygonize'; DescEn = 'Create a polygon feature dataset from a raster band.'; DescJa = 'ラスタバンドからポリゴンフィーチャデータセットを作成' }
        @{ Name = 'proximity'; DescEn = 'Produces a raster proximity map.'; DescJa = 'ラスタ近接マップを生成' }
        @{ Name = 'reclassify'; DescEn = 'Reclassify values in a raster dataset'; DescJa = 'ラスタデータセットの値を再分類' }
        @{ Name = 'reproject'; DescEn = 'Reproject a raster dataset.'; DescJa = 'ラスタデータセットを再投影' }
        @{ Name = 'resize'; DescEn = 'Resize a raster dataset without changing the georeferenced extents.'; DescJa = '地理参照範囲を変えずにラスタデータセットをリサイズ' }
        @{ Name = 'rgb-to-palette'; DescEn = 'Convert a RGB image into a pseudo-color / paletted image.'; DescJa = 'RGB 画像を疑似カラー・パレット画像に変換' }
        @{ Name = 'roughness'; DescEn = 'Generate a roughness map'; DescJa = '粗度マップを生成' }
        @{ Name = 'scale'; DescEn = 'Scale the values of the bands of a raster dataset.'; DescJa = 'ラスタデータセットのバンド値をスケーリング' }
        @{ Name = 'select'; DescEn = 'Select a subset of bands from a raster dataset.'; DescJa = 'ラスタデータセットからバンドのサブセットを選択' }
        @{ Name = 'set-type'; DescEn = 'Modify the data type of bands of a raster dataset.'; DescJa = 'ラスタデータセットのバンドのデータ型を変更' }
        @{ Name = 'sieve'; DescEn = 'Remove small polygons from a raster dataset.'; DescJa = 'ラスタデータセットから小ポリゴンを除去' }
        @{ Name = 'slope'; DescEn = 'Generate a slope map'; DescJa = '傾斜マップを生成' }
        @{ Name = 'stack'; DescEn = 'Combine together input bands into a multi-band output, either virtual (VRT) or materialized.'; DescJa = '入力バンドを多バンド出力に結合 (仮想 VRT または実体化)' }
        @{ Name = 'tile'; DescEn = 'Generate tiles in separate files from a raster dataset.'; DescJa = 'ラスタデータセットから別ファイルでタイルを生成' }
        @{ Name = 'tpi'; DescEn = 'Generate a Topographic Position Index (TPI) map'; DescJa = '地形位置指数 (TPI) マップを生成' }
        @{ Name = 'tri'; DescEn = 'Generate a Terrain Ruggedness Index (TRI) map'; DescJa = '地形粗度指数 (TRI) マップを生成' }
        @{ Name = 'unscale'; DescEn = 'Convert scaled values of a raster dataset into unscaled values.'; DescJa = 'ラスタのスケール値を非スケール値に変換' }
        @{ Name = 'update'; DescEn = 'Update the destination raster with the content of the input one.'; DescJa = '出力ラスタを入力の内容で更新' }
        @{ Name = 'viewshed'; DescEn = 'Compute the viewshed of a raster dataset.'; DescJa = 'ラスタデータセットの可視領域を計算' }
        @{ Name = 'zonal-stats'; DescEn = 'Calculate raster zonal statistics'; DescJa = 'ラスタの領域統計を計算' }
    )
    Opts = @(
        @{ Name = '--drivers'; DescEn = 'Display raster driver list as JSON document'; DescJa = 'ラスタドライバ一覧を JSON で表示' }
    )
}
$script:EzGdalTree['gdal/raster/as-features'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--band'; DescEn = 'Input band(s) (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--geometry-type'; DescEn = 'Geometry type'; DescJa = 'ジオメトリ型' }
        @{ Name = '--skip-nodata'; DescEn = 'Omit NoData pixels from the result'; DescJa = '結果から nodata ピクセルを除外' }
        @{ Name = '--include-xy'; DescEn = 'Include fields for cell center coordinates'; DescJa = 'セル中心座標フィールドを含める' }
        @{ Name = '--include-row-col'; DescEn = 'Include columns for row and column'; DescJa = '行・列の列を含める' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/aspect'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--band'; DescEn = 'Input band (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--convention'; DescEn = 'Convention for output angles'; DescJa = '出力角度の規約' }
        @{ Name = '--gradient-alg'; DescEn = 'Algorithm used to compute terrain gradient'; DescJa = '地形勾配計算アルゴリズム' }
        @{ Name = '--zero-for-flat'; DescEn = 'Whether to output zero for flat areas'; DescJa = '平坦領域に対して 0 を出力するか' }
        @{ Name = '--no-edges'; DescEn = 'Do not try to interpolate values at dataset edges or close to nodata values'; DescJa = 'データセット端や nodata 近傍で値を補間しない' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/blend'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster dataset'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--overlay'; DescEn = 'Overlay dataset'; DescJa = 'オーバーレイデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--operator'; DescEn = 'Composition operator'; DescJa = '合成演算子' }
        @{ Name = '--opacity'; DescEn = 'Opacity percentage to apply to the overlay dataset (0=fully transparent, 100=full use of overlay opacity)'; DescJa = 'オーバーレイデータセットの不透明度 (0=完全透明、100=オーバーレイ不透明度をそのまま使用)' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/calc'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--no-check-srs'; DescEn = 'Do not check consistency of input spatial reference systems'; DescJa = '入力 CRS の整合性チェックを行わない' }
        @{ Name = '--no-check-extent'; DescEn = 'Do not check consistency of input extents'; DescJa = '入力範囲の整合性チェックを行わない' }
        @{ Name = '--propagate-nodata'; DescEn = 'Whether to set pixels to the output NoData value if any of the input pixels is NoData'; DescJa = '入力ピクセルのいずれかが nodata なら出力ピクセルを nodata にするか' }
        @{ Name = '--calc'; DescEn = 'Expression(s) to evaluate'; DescJa = '評価する式' }
        @{ Name = '--dialect'; DescEn = 'Expression dialect'; DescJa = '式の方言' }
        @{ Name = '--flatten'; DescEn = 'Generate a single band output raster per expression, even if input datasets are multiband'; DescJa = '入力が多バンドでも式ごとに単一バンドラスタを生成' }
        @{ Name = '--nodata'; DescEn = 'Assign a specified nodata value to output bands (''none'', numeric value, ''nan'', ''inf'', ''-inf'')'; DescJa = '出力バンドに nodata 値を割り当て (''none'' / 数値 / ''nan'' / ''inf'' / ''-inf'')' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/clean-collar'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input raster dataset'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--color'; DescEn = 'Transparent color(s): tuple of integer (like ''r,g,b''), ''black'', ''white'''; DescJa = '透明色 (整数タプル ''r,g,b'' / ''black'' / ''white'')' }
        @{ Name = '--color-threshold'; DescEn = 'Select how far from specified transparent colors the pixel values are considered transparent.'; DescJa = 'ピクセル値を透明とみなす指定透明色からの距離' }
        @{ Name = '--pixel-distance'; DescEn = 'Number of consecutive transparent pixels that can be encountered before the giving up search inwards.'; DescJa = '内向き探索を諦めるまでに許容する連続透明ピクセル数' }
        @{ Name = '--add-alpha'; DescEn = 'Adds an alpha band to the output dataset.'; DescJa = '出力データセットにアルファバンドを追加' }
        @{ Name = '--add-mask'; DescEn = 'Adds a mask band to the output dataset.'; DescJa = '出力データセットにマスクバンドを追加' }
        @{ Name = '--algorithm'; DescEn = 'Algorithm to apply'; DescJa = '適用するアルゴリズム' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/clip'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--bbox'; DescEn = 'Clipping bounding box as xmin,ymin,xmax,ymax'; DescJa = 'クリップバウンディングボックス (xmin,ymin,xmax,ymax)' }
        @{ Name = '--bbox-crs'; DescEn = 'CRS of clipping bounding box'; DescJa = 'クリップバウンディングボックスの CRS' }
        @{ Name = '--window'; DescEn = 'Raster window as col,line,width,height in pixels'; DescJa = 'ラスタウィンドウ (col,line,width,height ピクセル)' }
        @{ Name = '--geometry'; DescEn = 'Clipping geometry (WKT or GeoJSON)'; DescJa = 'クリップジオメトリ (WKT または GeoJSON)' }
        @{ Name = '--geometry-crs'; DescEn = 'CRS of clipping geometry'; DescJa = 'クリップジオメトリの CRS' }
        @{ Name = '--like'; DescEn = 'Dataset to use as a template for bounds'; DescJa = '境界テンプレートとして使うデータセット' }
        @{ Name = '--like-sql'; DescEn = 'SELECT statement to run on the ''like'' dataset'; DescJa = '''like'' データセットに対する SELECT 文' }
        @{ Name = '--like-layer'; DescEn = 'Name of the layer of the ''like'' dataset'; DescJa = '''like'' データセットのレイヤ名' }
        @{ Name = '--like-where'; DescEn = 'WHERE SQL clause to run on the ''like'' dataset'; DescJa = '''like'' データセットに対する WHERE 句' }
        @{ Name = '--only-bbox'; DescEn = 'For ''geometry'' and ''like'', only consider their bounding box'; DescJa = '''geometry'' と ''like'' についてバウンディングボックスのみ使用' }
        @{ Name = '--allow-bbox-outside-source'; DescEn = 'Allow clipping box to include pixels outside input dataset'; DescJa = 'クリップ範囲が入力データセット外ピクセルを含むことを許可' }
        @{ Name = '--add-alpha'; DescEn = 'Adds an alpha mask band to the destination when the source raster have none.'; DescJa = 'ソースに存在しない場合のみ出力にアルファマスクバンドを追加' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/color-map'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--band'; DescEn = 'Input band (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--color-map'; DescEn = 'Color map filename'; DescJa = 'カラーマップファイル名' }
        @{ Name = '--add-alpha'; DescEn = 'Adds an alpha mask band to the destination.'; DescJa = '出力にアルファマスクバンドを追加' }
        @{ Name = '--color-selection'; DescEn = 'How to compute output colors from input values'; DescJa = '入力値から出力色を算出する方法' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/compare'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--reference'; DescEn = 'Reference dataset'; DescJa = '参照データセット' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster dataset'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--skip-all-optional'; DescEn = 'Skip all optional comparisons'; DescJa = '任意の比較をすべてスキップ' }
        @{ Name = '--skip-binary'; DescEn = 'Skip binary file comparison'; DescJa = 'バイナリファイル比較をスキップ' }
        @{ Name = '--skip-crs'; DescEn = 'Skip CRS comparison'; DescJa = 'CRS 比較をスキップ' }
        @{ Name = '--skip-geotransform'; DescEn = 'Skip geotransform comparison'; DescJa = 'ジオトランスフォーム比較をスキップ' }
        @{ Name = '--skip-overview'; DescEn = 'Skip overview comparison'; DescJa = 'オーバビュー比較をスキップ' }
        @{ Name = '--skip-metadata'; DescEn = 'Skip metadata comparison'; DescJa = 'メタデータ比較をスキップ' }
        @{ Name = '--skip-rpc'; DescEn = 'Skip RPC metadata comparison'; DescJa = 'RPC メタデータ比較をスキップ' }
        @{ Name = '--skip-geolocation'; DescEn = 'Skip Geolocation metadata comparison'; DescJa = 'ジオロケーションメタデータ比較をスキップ' }
        @{ Name = '--skip-subdataset'; DescEn = 'Skip subdataset comparison'; DescJa = 'サブデータセット比較をスキップ' }
    )
}
$script:EzGdalTree['gdal/raster/contour'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--band'; DescEn = 'Input band (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--elevation-name'; DescEn = 'Name of the elevation field'; DescJa = '標高フィールド名' }
        @{ Name = '--min-name'; DescEn = 'Name of the minimum elevation field'; DescJa = '最小標高フィールド名' }
        @{ Name = '--max-name'; DescEn = 'Name of the maximum elevation field'; DescJa = '最大標高フィールド名' }
        @{ Name = '--3d'; DescEn = 'Force production of 3D vectors instead of 2D'; DescJa = '2D ではなく 3D ベクタを強制生成' }
        @{ Name = '--src-nodata'; DescEn = 'Input pixel value to treat as ''nodata'''; DescJa = 'nodata として扱う入力ピクセル値' }
        @{ Name = '--interval'; DescEn = 'Elevation interval between contours'; DescJa = '等高線の標高間隔' }
        @{ Name = '--levels'; DescEn = 'List of contour levels'; DescJa = '等高線レベル一覧' }
        @{ Name = '--exp-base'; DescEn = 'Base for exponential contour level generation'; DescJa = '指数等高線生成の底' }
        @{ Name = '--offset'; DescEn = 'Offset to apply to contour levels'; DescJa = '等高線レベルに適用するオフセット' }
        @{ Name = '--polygonize'; DescEn = 'Create polygons instead of lines'; DescJa = 'ラインではなくポリゴンを作成' }
        @{ Name = '--group-transactions'; DescEn = 'Group n features per transaction (default 100 000)'; DescJa = 'トランザクションあたりのフィーチャ数 (既定 100,000)' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/convert'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/create'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input raster dataset'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--size'; DescEn = 'Output size in pixels'; DescJa = 'ピクセル単位の出力サイズ' }
        @{ Name = '--band-count'; DescEn = 'Number of bands'; DescJa = 'バンド数' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--nodata'; DescEn = 'Assign a specified nodata value to output bands (''none'', numeric value, ''nan'', ''inf'', ''-inf'')'; DescJa = '出力バンドに nodata 値を割り当て (''none'' / 数値 / ''nan'' / ''inf'' / ''-inf'')' }
        @{ Name = '--burn'; DescEn = 'Burn value'; DescJa = '焼き込み値' }
        @{ Name = '--crs'; DescEn = 'Set CRS'; DescJa = 'CRS を設定' }
        @{ Name = '--bbox'; DescEn = 'Bounding box as xmin,ymin,xmax,ymax'; DescJa = 'バウンディングボックス (xmin,ymin,xmax,ymax)' }
        @{ Name = '--metadata'; DescEn = 'Add metadata item'; DescJa = 'メタデータ項目を追加' }
        @{ Name = '--copy-metadata'; DescEn = 'Copy metadata from input dataset'; DescJa = '入力データセットからメタデータをコピー' }
        @{ Name = '--copy-overviews'; DescEn = 'Create same overview levels as input dataset'; DescJa = '入力データセットと同じオーバビューレベルを作成' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/edit'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--dataset'; DescEn = 'Dataset (to be updated in-place, unless --auxiliary)'; DescJa = 'データセット (--auxiliary 指定時を除きインプレース更新)' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--auxiliary'; DescEn = 'Ask for an auxiliary .aux.xml file to be edited'; DescJa = '補助 .aux.xml ファイルの編集を要求' }
        @{ Name = '--crs'; DescEn = 'Override CRS (without reprojection)'; DescJa = 'CRS を上書き (再投影なし)' }
        @{ Name = '--bbox'; DescEn = 'Bounding box as xmin,ymin,xmax,ymax'; DescJa = 'バウンディングボックス (xmin,ymin,xmax,ymax)' }
        @{ Name = '--nodata'; DescEn = 'Assign a specified nodata value to output bands (''none'', numeric value, ''nan'', ''inf'', ''-inf'')'; DescJa = '出力バンドに nodata 値を割り当て (''none'' / 数値 / ''nan'' / ''inf'' / ''-inf'')' }
        @{ Name = '--metadata'; DescEn = 'Add/update dataset metadata item'; DescJa = 'データセットメタデータ項目を追加・更新' }
        @{ Name = '--unset-metadata'; DescEn = 'Remove dataset metadata item(s)'; DescJa = 'データセットメタデータ項目を削除' }
        @{ Name = '--unset-metadata-domain'; DescEn = 'Remove dataset metadata domain(s)'; DescJa = 'データセットメタデータドメインを削除' }
        @{ Name = '--gcp'; DescEn = 'Add ground control point, formatted as pixel,line,easting,northing[,elevation], or @filename'; DescJa = 'GCP を追加 (pixel,line,easting,northing[,elevation] 形式または @filename)' }
        @{ Name = '--stats'; DescEn = 'Compute statistics, using all pixels'; DescJa = '全ピクセルで統計を計算' }
        @{ Name = '--approx-stats'; DescEn = 'Compute statistics, using a subset of pixels'; DescJa = 'ピクセルのサブセットを使い統計を計算' }
        @{ Name = '--hist'; DescEn = 'Compute histogram'; DescJa = 'ヒストグラム計算' }
    )
}
$script:EzGdalTree['gdal/raster/fill-nodata'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--band'; DescEn = 'Input band (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--max-distance'; DescEn = 'The maximum distance (in pixels) that the algorithm will search out for values to interpolate.'; DescJa = '補間値を探索する最大距離 (ピクセル)' }
        @{ Name = '--smoothing-iterations'; DescEn = 'The number of 3x3 average filter smoothing iterations to run after the interpolation to dampen artifacts. The default is zero smoothing iterations.'; DescJa = '補間後にアーティファクトを抑える 3x3 平均フィルタの反復回数 (既定 0)' }
        @{ Name = '--mask'; DescEn = 'Use the first band of the specified file as a validity mask (zero is invalid, non-zero is valid).'; DescJa = '指定ファイルの最初のバンドを妥当性マスクとして使用 (ゼロ=無効、非ゼロ=有効)' }
        @{ Name = '--strategy'; DescEn = 'By default, pixels are interpolated using an inverse distance weighting (invdist). It is also possible to choose a nearest neighbour (nearest) strategy.'; DescJa = '既定で逆距離加重 (invdist) 補間。最近傍 (nearest) も選択可' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/footprint'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--band'; DescEn = 'Input band(s) (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--combine-bands'; DescEn = 'Defines how the mask bands of the selected bands are combined to generate a single mask band, before being vectorized.'; DescJa = 'ベクタ化前の単一マスクバンド生成のため、選択バンドのマスクバンドをどう結合するか定義' }
        @{ Name = '--overview'; DescEn = 'Which overview level of source file must be used'; DescJa = 'ソースファイルのどのオーバビューレベルを使うか' }
        @{ Name = '--src-nodata'; DescEn = 'Set nodata values for input bands.'; DescJa = '入力バンドの nodata 値を設定' }
        @{ Name = '--coordinate-system'; DescEn = 'Target coordinate system'; DescJa = 'ターゲット座標系' }
        @{ Name = '--dst-crs'; DescEn = 'Destination CRS'; DescJa = '出力 CRS' }
        @{ Name = '--split-multipolygons'; DescEn = 'Whether to split multipolygons as several features each with one single polygon'; DescJa = 'マルチポリゴンを単一ポリゴンの複数フィーチャに分割するか' }
        @{ Name = '--convex-hull'; DescEn = 'Whether to compute the convex hull of the footprint'; DescJa = 'フットプリントの凸包を計算するか' }
        @{ Name = '--densify-distance'; DescEn = 'Maximum distance between 2 consecutive points of the output geometry.'; DescJa = '出力ジオメトリの連続 2 点間の最大距離' }
        @{ Name = '--simplify-tolerance'; DescEn = 'Tolerance used to merge consecutive points of the output geometry.'; DescJa = '出力ジオメトリの連続点をマージする許容値' }
        @{ Name = '--min-ring-area'; DescEn = 'Minimum value for the area of a ring'; DescJa = 'リング面積の最小値' }
        @{ Name = '--max-points'; DescEn = 'Maximum number of points of each output geometry'; DescJa = '各出力ジオメトリの最大点数' }
        @{ Name = '--location-field'; DescEn = 'Name of the field where the path of the input dataset will be stored.'; DescJa = '入力データセットのパスを格納するフィールド名' }
        @{ Name = '--no-location-field'; DescEn = 'Disable creating a field with the path of the input dataset'; DescJa = '入力データセットパスのフィールド作成を無効化' }
        @{ Name = '--absolute-path'; DescEn = 'Whether the path to the input dataset should be stored as an absolute path'; DescJa = '入力データセットのパスを絶対パスで格納するか' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/hillshade'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--band'; DescEn = 'Input band (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--zfactor'; DescEn = 'Vertical exaggeration used to pre-multiply the elevations'; DescJa = '標高に事前乗算する垂直強調率' }
        @{ Name = '--xscale'; DescEn = 'Ratio of vertical units to horizontal X axis units'; DescJa = '垂直単位と水平 X 軸単位の比' }
        @{ Name = '--yscale'; DescEn = 'Ratio of vertical units to horizontal Y axis units'; DescJa = '垂直単位と水平 Y 軸単位の比' }
        @{ Name = '--azimuth'; DescEn = 'Azimuth of the light, in degrees'; DescJa = '光源方位角 (度)' }
        @{ Name = '--altitude'; DescEn = 'Altitude of the light, in degrees'; DescJa = '光源高度 (度)' }
        @{ Name = '--gradient-alg'; DescEn = 'Algorithm used to compute terrain gradient'; DescJa = '地形勾配計算アルゴリズム' }
        @{ Name = '--variant'; DescEn = 'Variant of the hillshading algorithm'; DescJa = '陰影起伏アルゴリズムのバリアント' }
        @{ Name = '--no-edges'; DescEn = 'Do not try to interpolate values at dataset edges or close to nodata values'; DescJa = 'データセット端や nodata 近傍で値を補間しない' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/index'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--recursive'; DescEn = 'Whether input directories should be explored recursively.'; DescJa = '入力ディレクトリを再帰的に探索するか' }
        @{ Name = '--filename-filter'; DescEn = 'Pattern that the filenames in input directories should follow (''*'' and ''?'' wildcard)'; DescJa = '入力ディレクトリ内ファイル名が従うパターン (''*'' / ''?'' ワイルドカード)' }
        @{ Name = '--min-pixel-size'; DescEn = 'Minimum pixel size in term of geospatial extent per pixel (resolution) that a raster should have to be selected.'; DescJa = '選択対象ラスタの最小ピクセルサイズ (ピクセルあたりの地理範囲、解像度)' }
        @{ Name = '--max-pixel-size'; DescEn = 'Maximum pixel size in term of geospatial extent per pixel (resolution) that a raster should have to be selected.'; DescJa = '選択対象ラスタの最大ピクセルサイズ (ピクセルあたりの地理範囲、解像度)' }
        @{ Name = '--location-name'; DescEn = 'Name of the field with the raster path'; DescJa = 'ラスタパスを格納するフィールド名' }
        @{ Name = '--absolute-path'; DescEn = 'Whether the path to the input datasets should be stored as an absolute path'; DescJa = '入力データセットのパスを絶対パスで格納するか' }
        @{ Name = '--dst-crs'; DescEn = 'Destination CRS'; DescJa = '出力 CRS' }
        @{ Name = '--metadata'; DescEn = 'Add dataset metadata item'; DescJa = 'データセットメタデータ項目を追加' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors related to input datasets'; DescJa = '入力データセット関連エラーをスキップ' }
        @{ Name = '--source-crs-field-name'; DescEn = 'Name of the field to store the CRS of each dataset'; DescJa = '各データセットの CRS を格納するフィールド名' }
        @{ Name = '--source-crs-format'; DescEn = 'Format in which the CRS of each dataset must be written'; DescJa = '各データセットの CRS を書き出すフォーマット' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/info'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster dataset'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--min-max'; DescEn = 'Compute minimum and maximum value'; DescJa = '最小値・最大値を計算' }
        @{ Name = '--stats'; DescEn = 'Retrieve or compute statistics, using all pixels'; DescJa = '全ピクセルで統計を取得または計算' }
        @{ Name = '--approx-stats'; DescEn = 'Retrieve or compute statistics, using a subset of pixels'; DescJa = 'ピクセルのサブセットで統計を取得または計算' }
        @{ Name = '--hist'; DescEn = 'Retrieve or compute histogram'; DescJa = 'ヒストグラムを取得または計算' }
        @{ Name = '--no-gcp'; DescEn = 'Suppress ground control points list printing'; DescJa = 'GCP 一覧表示を抑制' }
        @{ Name = '--no-md'; DescEn = 'Suppress metadata printing'; DescJa = 'メタデータ表示を抑制' }
        @{ Name = '--no-ct'; DescEn = 'Suppress color table printing'; DescJa = 'カラーテーブル表示を抑制' }
        @{ Name = '--no-fl'; DescEn = 'Suppress file list printing'; DescJa = 'ファイル一覧表示を抑制' }
        @{ Name = '--checksum'; DescEn = 'Compute pixel checksum'; DescJa = 'ピクセルチェックサム計算' }
        @{ Name = '--list-mdd'; DescEn = 'List all metadata domains available for the dataset'; DescJa = 'データセットの全メタデータドメインを列挙' }
        @{ Name = '--metadata-domain'; DescEn = 'Report metadata for the specified domain. ''all'' can be used to report metadata in all domains'; DescJa = '指定ドメインのメタデータを報告 (''all'' で全ドメイン)' }
        @{ Name = '--no-nodata'; DescEn = 'Suppress retrieving nodata value'; DescJa = 'nodata 値の取得を抑制' }
        @{ Name = '--no-mask'; DescEn = 'Suppress mask band information'; DescJa = 'マスクバンド情報を抑制' }
        @{ Name = '--subdataset'; DescEn = 'Use subdataset of specified index (starting at 1), instead of the source dataset itself'; DescJa = 'ソースデータセット自体ではなく指定インデックス (1 始まり) のサブデータセットを使用' }
    )
}
$script:EzGdalTree['gdal/raster/mosaic'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets (or specify a @<filename> to point to a file containing filenames)'; DescJa = '入力ラスタデータセット (@<filename> でファイル一覧指定可)' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--band'; DescEn = 'Input band(s) (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--absolute-path'; DescEn = 'Whether the path to the input datasets should be stored as an absolute path'; DescJa = '入力データセットのパスを絶対パスで格納するか' }
        @{ Name = '--resolution'; DescEn = 'Target resolution (in destination CRS units)'; DescJa = 'ターゲット解像度 (出力 CRS 単位)' }
        @{ Name = '--bbox'; DescEn = 'Target bounding box as xmin,ymin,xmax,ymax (in destination CRS units)'; DescJa = 'ターゲットバウンディングボックス (xmin,ymin,xmax,ymax、出力 CRS 単位)' }
        @{ Name = '--target-aligned-pixels'; DescEn = 'Round target extent to target resolution'; DescJa = 'ターゲット範囲をターゲット解像度に丸める' }
        @{ Name = '--src-nodata'; DescEn = 'Set nodata values for input bands.'; DescJa = '入力バンドの nodata 値を設定' }
        @{ Name = '--dst-nodata'; DescEn = 'Set nodata values at the destination band level.'; DescJa = '出力バンドレベルで nodata 値を設定' }
        @{ Name = '--hide-nodata'; DescEn = 'Makes the destination band not report the NoData.'; DescJa = '出力バンドが nodata を報告しないようにする' }
        @{ Name = '--add-alpha'; DescEn = 'Adds an alpha mask band to the destination when the source raster have none.'; DescJa = 'ソースに存在しない場合のみ出力にアルファマスクバンドを追加' }
        @{ Name = '--pixel-function'; DescEn = 'Specify a pixel function to calculate output value from overlapping inputs'; DescJa = '重なる入力から出力値を計算するピクセル関数を指定' }
        @{ Name = '--pixel-function-arg'; DescEn = 'Specify argument(s) to pass to the pixel function'; DescJa = 'ピクセル関数に渡す引数を指定' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/neighbors'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--band'; DescEn = 'Input band (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--method'; DescEn = 'Method to combine weighed source pixels'; DescJa = '重み付きソースピクセルの結合方法' }
        @{ Name = '--size'; DescEn = 'Neighborhood size'; DescJa = '近傍サイズ' }
        @{ Name = '--kernel'; DescEn = 'Convolution kernel(s) to apply'; DescJa = '適用する畳み込みカーネル' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--nodata'; DescEn = 'Assign a specified nodata value to output bands (''none'', numeric value, ''nan'', ''inf'', ''-inf'')'; DescJa = '出力バンドに nodata 値を割り当て (''none'' / 数値 / ''nan'' / ''inf'' / ''-inf'')' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/nodata-to-alpha'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--nodata'; DescEn = 'Override nodata value of input band(s) (numeric value, ''nan'', ''inf'', ''-inf'')'; DescJa = '入力バンドの nodata 値を上書き (数値 / ''nan'' / ''inf'' / ''-inf'')' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/overview'] = @{
    Subs = @(
        @{ Name = 'add'; DescEn = 'Adding overviews.'; DescJa = 'オーバビュー追加' }
        @{ Name = 'delete'; DescEn = 'Deleting overviews.'; DescJa = 'オーバビュー削除' }
        @{ Name = 'refresh'; DescEn = 'Refresh overviews.'; DescJa = 'オーバビュー再計算' }
    )
    Opts = @(
    )
}
$script:EzGdalTree['gdal/raster/overview/add'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Dataset (to be updated in-place, unless --external)'; DescJa = 'データセット (--external 指定時を除きインプレース更新)' }
        @{ Name = '--overview-src'; DescEn = 'Source overview dataset'; DescJa = 'ソースオーバビューデータセット' }
        @{ Name = '--external'; DescEn = 'Add external overviews'; DescJa = '外部オーバビューを追加' }
        @{ Name = '--resampling'; DescEn = 'Resampling method'; DescJa = 'リサンプリング方式' }
        @{ Name = '--levels'; DescEn = 'Levels / decimation factors'; DescJa = 'レベル・間引き係数' }
        @{ Name = '--min-size'; DescEn = 'Maximum width or height of the smallest overview level.'; DescJa = '最小オーバビューレベルの最大幅・高さ' }
        @{ Name = '--creation-option'; DescEn = 'Overview creation option'; DescJa = 'オーバビュー作成オプション' }
    )
}
$script:EzGdalTree['gdal/raster/overview/delete'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--dataset'; DescEn = 'Dataset (to be updated in-place, unless --read-only)'; DescJa = 'データセット (--read-only 指定時を除きインプレース更新)' }
        @{ Name = '--external'; DescEn = 'Delete external overviews'; DescJa = '外部オーバビューを削除' }
    )
}
$script:EzGdalTree['gdal/raster/overview/refresh'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--dataset'; DescEn = 'Dataset (to be updated in-place, unless --external)'; DescJa = 'データセット (--external 指定時を除きインプレース更新)' }
        @{ Name = '--external'; DescEn = 'Refresh external overviews'; DescJa = '外部オーバビューを再計算' }
        @{ Name = '--resampling'; DescEn = 'Resampling method'; DescJa = 'リサンプリング方式' }
        @{ Name = '--levels'; DescEn = 'Levels / decimation factors'; DescJa = 'レベル・間引き係数' }
        @{ Name = '--bbox'; DescEn = 'Bounding box to refresh'; DescJa = '再計算するバウンディングボックス' }
        @{ Name = '--like'; DescEn = 'Use extent of dataset(s)'; DescJa = 'データセットの範囲を使用' }
        @{ Name = '--use-source-timestamp'; DescEn = 'Use timestamp of VRT or GTI sources as refresh criterion'; DescJa = 'VRT / GTI ソースのタイムスタンプを再計算基準にする' }
    )
}
$script:EzGdalTree['gdal/raster/pansharpen'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input panchromatic raster dataset'; DescJa = '入力パンクロマチックラスタデータセット' }
        @{ Name = '--spectral'; DescEn = 'Input spectral band dataset'; DescJa = '入力スペクトルバンドデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--resampling'; DescEn = 'Resampling algorithm'; DescJa = 'リサンプリングアルゴリズム' }
        @{ Name = '--weights'; DescEn = 'Weight for each input spectral band'; DescJa = '各入力スペクトルバンドの重み' }
        @{ Name = '--nodata'; DescEn = 'Override nodata value of input bands'; DescJa = '入力バンドの nodata 値を上書き' }
        @{ Name = '--bit-depth'; DescEn = 'Override bit depth of input bands'; DescJa = '入力バンドのビット深度を上書き' }
        @{ Name = '--spatial-extent-adjustment'; DescEn = 'Select behavior when bands have not the same extent'; DescJa = 'バンドの範囲が異なる場合の挙動を選択' }
        @{ Name = '--num-threads'; DescEn = 'Number of jobs (or ALL_CPUS)'; DescJa = '並列ジョブ数 (または ALL_CPUS)' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/pipeline'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--pipeline'; DescEn = 'Pipeline string'; DescJa = 'パイプライン文字列' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/pixel-info'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input raster dataset'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--band'; DescEn = 'Input band(s) (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--overview'; DescEn = 'Which overview level of source file must be used'; DescJa = 'ソースファイルのどのオーバビューレベルを使うか' }
        @{ Name = '--position'; DescEn = 'Pixel position'; DescJa = 'ピクセル位置' }
        @{ Name = '--position-crs'; DescEn = 'CRS of position'; DescJa = '位置の CRS' }
        @{ Name = '--resampling'; DescEn = 'Resampling algorithm for interpolation'; DescJa = '補間用リサンプリングアルゴリズム' }
    )
}
$script:EzGdalTree['gdal/raster/polygonize'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--band'; DescEn = 'Input band (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--attribute-name'; DescEn = 'Name of the field with the pixel value'; DescJa = 'ピクセル値を格納するフィールド名' }
        @{ Name = '--connect-diagonal-pixels'; DescEn = 'Consider diagonal pixels as connected'; DescJa = '対角ピクセルを連結とみなす' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/proximity'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--band'; DescEn = 'Input band (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--target-values'; DescEn = 'Target pixel values'; DescJa = 'ターゲットピクセル値' }
        @{ Name = '--distance-units'; DescEn = 'Distance units'; DescJa = '距離単位' }
        @{ Name = '--max-distance'; DescEn = 'Maximum distance. The nodata value will be used for pixels beyond this distance'; DescJa = '最大距離。これを超えるピクセルには nodata 値を使用' }
        @{ Name = '--fixed-value'; DescEn = 'Fixed value for the pixels that are beyond the maximum distance (instead of the actual distance)'; DescJa = '最大距離を超えるピクセル用の固定値 (実距離の代わり)' }
        @{ Name = '--nodata'; DescEn = 'Specify a nodata value to use for pixels that are beyond the maximum distance'; DescJa = '最大距離を超えるピクセル用の nodata 値を指定' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/reclassify'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--mapping'; DescEn = 'Reclassification mappings (or specify a @<filename> to point to a file containing mappings'; DescJa = '再分類マッピング (@<filename> でファイル指定可)' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/reproject'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--src-crs'; DescEn = 'Source CRS'; DescJa = '入力 CRS' }
        @{ Name = '--dst-crs'; DescEn = 'Destination CRS'; DescJa = '出力 CRS' }
        @{ Name = '--resampling'; DescEn = 'Resampling method'; DescJa = 'リサンプリング方式' }
        @{ Name = '--resolution'; DescEn = 'Target resolution (in destination CRS units)'; DescJa = 'ターゲット解像度 (出力 CRS 単位)' }
        @{ Name = '--size'; DescEn = 'Target size in pixels'; DescJa = 'ピクセル単位のターゲットサイズ' }
        @{ Name = '--bbox'; DescEn = 'Target bounding box (in destination CRS units)'; DescJa = 'ターゲットバウンディングボックス (出力 CRS 単位)' }
        @{ Name = '--bbox-crs'; DescEn = 'CRS of target bounding box'; DescJa = 'ターゲットバウンディングボックスの CRS' }
        @{ Name = '--target-aligned-pixels'; DescEn = 'Round target extent to target resolution'; DescJa = 'ターゲット範囲をターゲット解像度に丸める' }
        @{ Name = '--src-nodata'; DescEn = 'Set nodata values for input bands (''None'' to unset).'; DescJa = '入力バンドの nodata 値を設定 (''None'' で解除)' }
        @{ Name = '--dst-nodata'; DescEn = 'Set nodata values for output bands (''None'' to unset).'; DescJa = '出力バンドの nodata 値を設定 (''None'' で解除)' }
        @{ Name = '--add-alpha'; DescEn = 'Adds an alpha mask band to the destination when the source raster have none.'; DescJa = 'ソースに存在しない場合のみ出力にアルファマスクバンドを追加' }
        @{ Name = '--warp-option'; DescEn = 'Warping option(s)'; DescJa = 'ワーピングオプション' }
        @{ Name = '--transform-option'; DescEn = 'Transform option(s)'; DescJa = '変換オプション' }
        @{ Name = '--error-threshold'; DescEn = 'Error threshold'; DescJa = 'エラーしきい値' }
        @{ Name = '--num-threads'; DescEn = 'Number of jobs (or ALL_CPUS)'; DescJa = '並列ジョブ数 (または ALL_CPUS)' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/resize'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--resolution'; DescEn = 'Target resolution (in destination CRS units)'; DescJa = 'ターゲット解像度 (出力 CRS 単位)' }
        @{ Name = '--size'; DescEn = 'Target size in pixels (or percentage if using ''%'' suffix)'; DescJa = 'ピクセル単位のターゲットサイズ (''%'' 接尾辞でパーセント指定可)' }
        @{ Name = '--resampling'; DescEn = 'Resampling method'; DescJa = 'リサンプリング方式' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/rgb-to-palette'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--color-count'; DescEn = 'Select the number of colors in the generated color table'; DescJa = '生成カラーテーブルの色数を選択' }
        @{ Name = '--color-map'; DescEn = 'Color map filename'; DescJa = 'カラーマップファイル名' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/roughness'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--band'; DescEn = 'Input band (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--no-edges'; DescEn = 'Do not try to interpolate values at dataset edges or close to nodata values'; DescJa = 'データセット端や nodata 近傍で値を補間しない' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/scale'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--band'; DescEn = 'Select band to restrict the scaling (1-based index)'; DescJa = 'スケーリング対象を制限するバンドを選択 (1 始まりインデックス)' }
        @{ Name = '--src-min'; DescEn = 'Minimum value of the source range'; DescJa = '入力範囲の最小値' }
        @{ Name = '--src-max'; DescEn = 'Maximum value of the source range'; DescJa = '入力範囲の最大値' }
        @{ Name = '--dst-min'; DescEn = 'Minimum value of the destination range'; DescJa = '出力範囲の最小値' }
        @{ Name = '--dst-max'; DescEn = 'Maximum value of the destination range'; DescJa = '出力範囲の最大値' }
        @{ Name = '--exponent'; DescEn = 'Exponent to apply non-linear scaling with a power function'; DescJa = 'べき関数で非線形スケーリングする指数' }
        @{ Name = '--no-clip'; DescEn = 'Do not clip input values to [srcmin, srcmax]'; DescJa = '入力値を [srcmin, srcmax] にクリップしない' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/select'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--band'; DescEn = 'Band(s) (1-based index, ''mask'' or ''mask:<band>'')'; DescJa = 'バンド (1 始まりインデックス / ''mask'' / ''mask:<band>'')' }
        @{ Name = '--mask'; DescEn = 'Mask band (1-based index, ''mask'', ''mask:<band>'' or ''none'')'; DescJa = 'マスクバンド (1 始まりインデックス / ''mask'' / ''mask:<band>'' / ''none'')' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/set-type'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/sieve'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--mask'; DescEn = 'Use the first band of the specified file as a validity mask (all pixels with a value other than zero will be considered suitable for inclusion in polygons)'; DescJa = '指定ファイルの最初のバンドを妥当性マスクとして使用 (非ゼロピクセルがポリゴン包含対象)' }
        @{ Name = '--band'; DescEn = 'Input band (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--size-threshold'; DescEn = 'Minimum size of polygons to keep'; DescJa = '保持するポリゴンの最小サイズ' }
        @{ Name = '--connect-diagonal-pixels'; DescEn = 'Consider diagonal pixels as connected'; DescJa = '対角ピクセルを連結とみなす' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/slope'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--band'; DescEn = 'Input band (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--unit'; DescEn = 'Unit in which to express slopes'; DescJa = '傾斜を表現する単位' }
        @{ Name = '--xscale'; DescEn = 'Ratio of vertical units to horizontal X axis units'; DescJa = '垂直単位と水平 X 軸単位の比' }
        @{ Name = '--yscale'; DescEn = 'Ratio of vertical units to horizontal Y axis units'; DescJa = '垂直単位と水平 Y 軸単位の比' }
        @{ Name = '--gradient-alg'; DescEn = 'Algorithm used to compute terrain gradient'; DescJa = '地形勾配計算アルゴリズム' }
        @{ Name = '--no-edges'; DescEn = 'Do not try to interpolate values at dataset edges or close to nodata values'; DescJa = 'データセット端や nodata 近傍で値を補間しない' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/stack'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets (or specify a @<filename> to point to a file containing filenames)'; DescJa = '入力ラスタデータセット (@<filename> でファイル一覧指定可)' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--band'; DescEn = 'Input band(s) (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--absolute-path'; DescEn = 'Whether the path to the input datasets should be stored as an absolute path'; DescJa = '入力データセットのパスを絶対パスで格納するか' }
        @{ Name = '--resolution'; DescEn = 'Target resolution (in destination CRS units)'; DescJa = 'ターゲット解像度 (出力 CRS 単位)' }
        @{ Name = '--bbox'; DescEn = 'Target bounding box as xmin,ymin,xmax,ymax (in destination CRS units)'; DescJa = 'ターゲットバウンディングボックス (xmin,ymin,xmax,ymax、出力 CRS 単位)' }
        @{ Name = '--target-aligned-pixels'; DescEn = 'Round target extent to target resolution'; DescJa = 'ターゲット範囲をターゲット解像度に丸める' }
        @{ Name = '--src-nodata'; DescEn = 'Set nodata values for input bands.'; DescJa = '入力バンドの nodata 値を設定' }
        @{ Name = '--dst-nodata'; DescEn = 'Set nodata values at the destination band level.'; DescJa = '出力バンドレベルで nodata 値を設定' }
        @{ Name = '--hide-nodata'; DescEn = 'Makes the destination band not report the NoData.'; DescJa = '出力バンドが nodata を報告しないようにする' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/tile'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--output'; DescEn = 'Output directory'; DescJa = '出力ディレクトリ' }
        @{ Name = '--tiling-scheme'; DescEn = 'Tiling scheme'; DescJa = 'タイリング方式' }
        @{ Name = '--min-zoom'; DescEn = 'Minimum zoom level'; DescJa = '最小ズームレベル' }
        @{ Name = '--max-zoom'; DescEn = 'Maximum zoom level'; DescJa = '最大ズームレベル' }
        @{ Name = '--min-x'; DescEn = 'Minimum tile X coordinate'; DescJa = '最小タイル X 座標' }
        @{ Name = '--max-x'; DescEn = 'Maximum tile X coordinate'; DescJa = '最大タイル X 座標' }
        @{ Name = '--min-y'; DescEn = 'Minimum tile Y coordinate'; DescJa = '最小タイル Y 座標' }
        @{ Name = '--max-y'; DescEn = 'Maximum tile Y coordinate'; DescJa = '最大タイル Y 座標' }
        @{ Name = '--no-intersection-ok'; DescEn = 'Whether dataset extent not intersecting tile matrix is only a warning'; DescJa = 'データセット範囲がタイル行列と交差しない場合を警告のみとするか' }
        @{ Name = '--resampling'; DescEn = 'Resampling method for max zoom'; DescJa = '最大ズーム用リサンプリング方式' }
        @{ Name = '--overview-resampling'; DescEn = 'Resampling method for overviews'; DescJa = 'オーバビュー用リサンプリング方式' }
        @{ Name = '--convention'; DescEn = 'Tile numbering convention: xyz (from top) or tms (from bottom)'; DescJa = 'タイル番号規約 (xyz: 上原点 / tms: 下原点)' }
        @{ Name = '--tile-size'; DescEn = 'Override default tile size'; DescJa = '既定タイルサイズを上書き' }
        @{ Name = '--add-alpha'; DescEn = 'Whether to force adding an alpha channel'; DescJa = 'アルファチャネル追加を強制するか' }
        @{ Name = '--no-alpha'; DescEn = 'Whether to disable adding an alpha channel'; DescJa = 'アルファチャネル追加を無効化するか' }
        @{ Name = '--dst-nodata'; DescEn = 'Destination nodata value'; DescJa = '出力 nodata 値' }
        @{ Name = '--skip-blank'; DescEn = 'Do not generate blank tiles'; DescJa = '空タイルを生成しない' }
        @{ Name = '--metadata'; DescEn = 'Add metadata item to output tiles'; DescJa = '出力タイルにメタデータ項目を追加' }
        @{ Name = '--copy-src-metadata'; DescEn = 'Whether to copy metadata from source dataset'; DescJa = 'ソースデータセットからメタデータをコピーするか' }
        @{ Name = '--aux-xml'; DescEn = 'Generate .aux.xml sidecar files when needed'; DescJa = '必要時に .aux.xml サイドカーを生成' }
        @{ Name = '--kml'; DescEn = 'Generate KML files'; DescJa = 'KML ファイルを生成' }
        @{ Name = '--resume'; DescEn = 'Generate only missing files'; DescJa = '欠けているファイルのみ生成' }
        @{ Name = '--num-threads'; DescEn = 'Number of jobs (or ALL_CPUS)'; DescJa = '並列ジョブ数 (または ALL_CPUS)' }
        @{ Name = '--parallel-method'; DescEn = 'Parallelization method (thread, spawn, fork)'; DescJa = '並列化方式 (thread / spawn / fork)' }
        @{ Name = '--excluded-values'; DescEn = 'Tuples of values (e.g. <R>,<G>,<B> or (<R1>,<G1>,<B1>),(<R2>,<G2>,<B2>)) that must beignored as contributing source pixels during (average) resampling'; DescJa = '(平均) リサンプリング時に寄与ピクセルから除外する値のタプル (例 <R>,<G>,<B> や複数組)' }
        @{ Name = '--excluded-values-pct-threshold'; DescEn = 'Minimum percentage of source pixels that must be set at one of the --excluded-values to cause the excluded value to be used as the target pixel value'; DescJa = '--excluded-values の値を出力に採用させるための、当該値が占めるソースピクセル最小割合' }
        @{ Name = '--nodata-values-pct-threshold'; DescEn = 'Minimum percentage of source pixels that must be set at one of nodata (or alpha=0 or any other way to express transparent pixelto cause the target pixel value to be transparent'; DescJa = '出力ピクセルを透明扱いにするために透明 (nodata / alpha=0 等) でなければならないソースピクセルの最小割合' }
        @{ Name = '--webviewer'; DescEn = 'Web viewer to generate'; DescJa = '生成するウェブビューア' }
        @{ Name = '--url'; DescEn = 'URL address where the generated tiles are going to be published'; DescJa = '生成タイルを公開する URL アドレス' }
        @{ Name = '--title'; DescEn = 'Title of the map'; DescJa = 'マップのタイトル' }
        @{ Name = '--copyright'; DescEn = 'Copyright for the map'; DescJa = 'マップの著作権表示' }
        @{ Name = '--mapml-template'; DescEn = 'Filename of a template mapml file where variables will be substituted'; DescJa = '変数置換用のテンプレート mapml ファイル名' }
    )
}
$script:EzGdalTree['gdal/raster/tpi'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--band'; DescEn = 'Input band (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--no-edges'; DescEn = 'Do not try to interpolate values at dataset edges or close to nodata values'; DescJa = 'データセット端や nodata 近傍で値を補間しない' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/tri'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--band'; DescEn = 'Input band (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--algorithm'; DescEn = 'Algorithm to compute TRI'; DescJa = 'TRI 計算アルゴリズム' }
        @{ Name = '--no-edges'; DescEn = 'Do not try to interpolate values at dataset edges or close to nodata values'; DescJa = 'データセット端や nodata 近傍で値を補間しない' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/unscale'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/update'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input raster dataset'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--geometry'; DescEn = 'Clipping geometry (WKT or GeoJSON)'; DescJa = 'クリップジオメトリ (WKT または GeoJSON)' }
        @{ Name = '--geometry-crs'; DescEn = 'CRS of clipping geometry'; DescJa = 'クリップジオメトリの CRS' }
        @{ Name = '--resampling'; DescEn = 'Resampling method'; DescJa = 'リサンプリング方式' }
        @{ Name = '--warp-option'; DescEn = 'Warping option(s)'; DescJa = 'ワーピングオプション' }
        @{ Name = '--transform-option'; DescEn = 'Transform option(s)'; DescJa = '変換オプション' }
        @{ Name = '--error-threshold'; DescEn = 'Error threshold'; DescJa = 'エラーしきい値' }
        @{ Name = '--no-update-overviews'; DescEn = 'Do not update existing overviews'; DescJa = '既存オーバビューを更新しない' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/viewshed'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Append as a subdataset to existing output'; DescJa = '既存出力にサブデータセットとして追加' }
        @{ Name = '--position'; DescEn = 'Observer position'; DescJa = '観測者位置' }
        @{ Name = '--height'; DescEn = 'Observer height'; DescJa = '観測者高度' }
        @{ Name = '--target-height'; DescEn = 'Height of the target above the DEM surface in the height unit of the DEM.'; DescJa = 'DEM 単位での DEM 表面からのターゲット高度' }
        @{ Name = '--mode'; DescEn = 'Sets what information the output contains.'; DescJa = '出力に含める情報を設定' }
        @{ Name = '--max-distance'; DescEn = 'Maximum distance from observer to compute visibility. It is also used to clamp the extent of the output raster.'; DescJa = '可視性計算の観測者からの最大距離 (出力ラスタ範囲の制限にも使用)' }
        @{ Name = '--min-distance'; DescEn = 'Mask all cells less than this distance from the observer. Must be less than ''max-distance''.'; DescJa = '観測者からこの距離未満のセルをマスク (max-distance より小)' }
        @{ Name = '--start-angle'; DescEn = 'Mask all cells outside of the arc (''start-angle'', ''end-angle''). Clockwise degrees from north. Also used to clamp the extent of the output raster.'; DescJa = '弧 (''start-angle'', ''end-angle'') 外のセルをマスク (北から時計回り度、出力ラスタ範囲の制限にも使用)' }
        @{ Name = '--end-angle'; DescEn = 'Mask all cells outside of the arc (''start-angle'', ''end-angle''). Clockwise degrees from north. Also used to clamp the extent of the output raster.'; DescJa = '弧 (''start-angle'', ''end-angle'') 外のセルをマスク (北から時計回り度、出力ラスタ範囲の制限にも使用)' }
        @{ Name = '--high-pitch'; DescEn = 'Mark all cells out-of-range where the observable height would be higher than the ''high-pitch'' angle from the observer. Degrees from horizontal - positive is up. Must be greater than ''low-pitch''.'; DescJa = '観測者からの high-pitch 角度より高い可視高度のセルを範囲外とマーク (水平からの度、上が正、low-pitch より大)' }
        @{ Name = '--low-pitch'; DescEn = 'Bound observable height to be no lower than the ''low-pitch'' angle from the observer. Degrees from horizontal - positive is up. Must be less than ''high-pitch''.'; DescJa = '観測者からの low-pitch 角度より低い可視高度を制限 (水平からの度、上が正、high-pitch より小)' }
        @{ Name = '--curvature-coefficient'; DescEn = 'Coefficient to consider the effect of the curvature and refraction.'; DescJa = '曲率・屈折効果係数' }
        @{ Name = '--band'; DescEn = 'Input band (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--visible-value'; DescEn = 'Pixel value to set for visible areas'; DescJa = '可視領域に設定するピクセル値' }
        @{ Name = '--invisible-value'; DescEn = 'Pixel value to set for invisible areas'; DescJa = '不可視領域に設定するピクセル値' }
        @{ Name = '--out-of-range-value'; DescEn = 'Pixel value to set for the cells that fall outside of the range specified by the observer location and the maximum distance'; DescJa = '観測者位置と最大距離の範囲外セルに設定するピクセル値' }
        @{ Name = '--dst-nodata'; DescEn = 'The value to be set for the cells in the output raster that have no data.'; DescJa = '出力ラスタの nodata セルに設定する値' }
        @{ Name = '--observer-spacing'; DescEn = 'Cell Spacing between observers'; DescJa = '観測者間のセル間隔' }
        @{ Name = '--num-threads'; DescEn = 'Number of jobs (or ALL_CPUS)'; DescJa = '並列ジョブ数 (または ALL_CPUS)' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/raster/zonal-stats'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input raster datasets'; DescJa = '入力ラスタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--band'; DescEn = 'Input band(s) (1-based index)'; DescJa = '入力バンド (1 始まりインデックス)' }
        @{ Name = '--zones'; DescEn = 'Dataset containing zone definitions'; DescJa = 'ゾーン定義を含むデータセット' }
        @{ Name = '--zones-band'; DescEn = 'Band from which zones should be read'; DescJa = 'ゾーンを読むバンド' }
        @{ Name = '--zones-layer'; DescEn = 'Layer from which zones should be read'; DescJa = 'ゾーンを読むレイヤ' }
        @{ Name = '--weights'; DescEn = 'Weighting raster dataset'; DescJa = '重み付けラスタデータセット' }
        @{ Name = '--weights-band'; DescEn = 'Band from which weights should be read'; DescJa = '重みを読むバンド' }
        @{ Name = '--pixels'; DescEn = 'Method to determine which pixels are included in stat calculation.'; DescJa = '統計計算に含めるピクセルの決定方法' }
        @{ Name = '--stat'; DescEn = 'Statistic(s) to compute for each zone'; DescJa = '各ゾーンで計算する統計量' }
        @{ Name = '--include-field'; DescEn = 'Fields from polygon zones to include in output'; DescJa = '出力に含めるポリゴンゾーンのフィールド' }
        @{ Name = '--strategy'; DescEn = 'For polygon zones, whether to iterate over input features or raster chunks'; DescJa = 'ポリゴンゾーンで入力フィーチャ単位かラスタチャンク単位かを選択' }
        @{ Name = '--chunk-size'; DescEn = 'Maximum size of raster chunks read into memory'; DescJa = 'メモリに読むラスタチャンクの最大サイズ' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector'] = @{
    Subs = @(
        @{ Name = 'buffer'; DescEn = 'Compute a buffer around geometries of a vector dataset.'; DescJa = 'ベクタデータセットのジオメトリ周辺にバッファを計算' }
        @{ Name = 'check-coverage'; DescEn = 'Check a polygon coverage for validity'; DescJa = 'ポリゴンカバレッジの妥当性を検査' }
        @{ Name = 'check-geometry'; DescEn = 'Check a dataset for invalid geometries'; DescJa = 'データセットの無効ジオメトリを検査' }
        @{ Name = 'clean-coverage'; DescEn = 'Alter polygon boundaries to make shared edges identical, removing gaps and overlaps'; DescJa = 'ポリゴン境界を調整して共有辺を一致させ、ギャップと重なりを除去' }
        @{ Name = 'clip'; DescEn = 'Clip a vector dataset.'; DescJa = 'ベクタデータセットをクリップ' }
        @{ Name = 'concat'; DescEn = 'Concatenate vector datasets.'; DescJa = 'ベクタデータセットを連結' }
        @{ Name = 'convert'; DescEn = 'Convert a vector dataset.'; DescJa = 'ベクタデータセットを変換' }
        @{ Name = 'edit'; DescEn = 'Edit metadata of a vector dataset.'; DescJa = 'ベクタデータセットのメタデータを編集' }
        @{ Name = 'explode-collections'; DescEn = 'Explode geometries of type collection of a vector dataset.'; DescJa = 'ベクタデータセットのコレクション型ジオメトリを展開' }
        @{ Name = 'filter'; DescEn = 'Filter a vector dataset.'; DescJa = 'ベクタデータセットをフィルタ' }
        @{ Name = 'grid'; DescEn = 'Create a regular grid from scattered points.'; DescJa = '散在点から規則格子を作成' }
        @{ Name = 'index'; DescEn = 'Create a vector index of vector datasets.'; DescJa = 'ベクタデータセットのベクタインデックスを作成' }
        @{ Name = 'info'; DescEn = 'Return information on a vector dataset.'; DescJa = 'ベクタデータセットの情報を返す' }
        @{ Name = 'layer-algebra'; DescEn = 'Perform algebraic operation between 2 layers.'; DescJa = '2 つのレイヤ間で代数演算を実行' }
        @{ Name = 'make-point'; DescEn = 'Create point geometries from attribute fields'; DescJa = '属性フィールドから点ジオメトリを作成' }
        @{ Name = 'make-valid'; DescEn = 'Fix validity of geometries of a vector dataset.'; DescJa = 'ベクタデータセットのジオメトリ妥当性を修復' }
        @{ Name = 'partition'; DescEn = 'Partition a vector dataset into multiple files.'; DescJa = 'ベクタデータセットを複数ファイルに分割' }
        @{ Name = 'pipeline'; DescEn = 'Process a vector dataset applying several steps.'; DescJa = '複数ステップを適用してベクタデータセットを処理' }
        @{ Name = 'rasterize'; DescEn = 'Burns vector geometries into a raster.'; DescJa = 'ベクタジオメトリをラスタへ焼き込み' }
        @{ Name = 'reproject'; DescEn = 'Reproject a vector dataset.'; DescJa = 'ベクタデータセットを再投影' }
        @{ Name = 'segmentize'; DescEn = 'Segmentize geometries of a vector dataset.'; DescJa = 'ベクタデータセットのジオメトリをセグメント化' }
        @{ Name = 'select'; DescEn = 'Select a subset of fields from a vector dataset.'; DescJa = 'ベクタデータセットからフィールドのサブセットを選択' }
        @{ Name = 'set-field-type'; DescEn = 'Modify the type of a field of a vector dataset.'; DescJa = 'ベクタデータセットのフィールド型を変更' }
        @{ Name = 'set-geom-type'; DescEn = 'Modify the geometry type of a vector dataset.'; DescJa = 'ベクタデータセットのジオメトリ型を変更' }
        @{ Name = 'simplify'; DescEn = 'Simplify geometries of a vector dataset.'; DescJa = 'ベクタデータセットのジオメトリを簡略化' }
        @{ Name = 'simplify-coverage'; DescEn = 'Simplify shared boundaries of a polygonal vector dataset.'; DescJa = 'ポリゴンベクタデータセットの共有境界を簡略化' }
        @{ Name = 'sql'; DescEn = 'Apply SQL statement(s) to a dataset.'; DescJa = 'データセットに SQL 文を適用' }
        @{ Name = 'swap-xy'; DescEn = 'Swap X and Y coordinates of geometries of a vector dataset.'; DescJa = 'ベクタデータセットのジオメトリの X / Y 座標を入れ替え' }
    )
    Opts = @(
        @{ Name = '--drivers'; DescEn = 'Display vector driver list as JSON document and exit'; DescJa = 'ベクタドライバ一覧を JSON で表示して終了' }
    )
}
$script:EzGdalTree['gdal/vector/buffer'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--active-geometry'; DescEn = 'Geometry field name to which to restrict the processing (if not specified, all)'; DescJa = '処理対象のジオメトリフィールド名 (未指定で全フィールド)' }
        @{ Name = '--distance'; DescEn = 'Distance to which to extend the geometry.'; DescJa = 'ジオメトリを拡張する距離' }
        @{ Name = '--endcap-style'; DescEn = 'Endcap style.'; DescJa = '端部スタイル' }
        @{ Name = '--join-style'; DescEn = 'Join style.'; DescJa = '結合スタイル' }
        @{ Name = '--mitre-limit'; DescEn = 'Mitre ratio limit (only affects mitered join style).'; DescJa = 'マイター比限界 (mitered 結合スタイル時のみ適用)' }
        @{ Name = '--quadrant-segments'; DescEn = 'Number of line segments used to approximate a quarter circle.'; DescJa = '四分円を近似する線分数' }
        @{ Name = '--side'; DescEn = 'Sets whether the computed buffer should be single-sided or not.'; DescJa = '計算するバッファを片側にするかどうかを設定' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/check-coverage'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--include-valid'; DescEn = 'Include valid inputs in output, with empty geometry'; DescJa = '有効な入力を空ジオメトリ付きで出力に含める' }
        @{ Name = '--geometry-field'; DescEn = 'Name of geometry field to check'; DescJa = '検査するジオメトリフィールド名' }
        @{ Name = '--maximum-gap-width'; DescEn = 'Maximum width of a gap to be flagged'; DescJa = 'フラグを立てるギャップの最大幅' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/check-geometry'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--include-field'; DescEn = 'Fields from input layer to include in output'; DescJa = '出力に含める入力レイヤのフィールド' }
        @{ Name = '--include-valid'; DescEn = 'Include valid inputs in output, with empty geometry'; DescJa = '有効な入力を空ジオメトリ付きで出力に含める' }
        @{ Name = '--geometry-field'; DescEn = 'Name of geometry field to check'; DescJa = '検査するジオメトリフィールド名' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/clean-coverage'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--snapping-distance'; DescEn = 'Distance tolerance for snapping nodes'; DescJa = 'ノードスナップの距離許容値' }
        @{ Name = '--merge-strategy'; DescEn = 'Algorithm to assign overlaps to neighboring polygons'; DescJa = '重なり領域を隣接ポリゴンに割り当てるアルゴリズム' }
        @{ Name = '--maximum-gap-width'; DescEn = 'Maximum width of a gap to be closed'; DescJa = '閉じるギャップの最大幅' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/clip'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--bbox'; DescEn = 'Clipping bounding box as xmin,ymin,xmax,ymax'; DescJa = 'クリップバウンディングボックス (xmin,ymin,xmax,ymax)' }
        @{ Name = '--bbox-crs'; DescEn = 'CRS of clipping bounding box'; DescJa = 'クリップバウンディングボックスの CRS' }
        @{ Name = '--geometry'; DescEn = 'Clipping geometry (WKT or GeoJSON)'; DescJa = 'クリップジオメトリ (WKT または GeoJSON)' }
        @{ Name = '--geometry-crs'; DescEn = 'CRS of clipping geometry'; DescJa = 'クリップジオメトリの CRS' }
        @{ Name = '--like'; DescEn = 'Dataset to use as a template for bounds'; DescJa = '境界テンプレートとして使うデータセット' }
        @{ Name = '--like-sql'; DescEn = 'SELECT statement to run on the ''like'' dataset'; DescJa = '''like'' データセットに対する SELECT 文' }
        @{ Name = '--like-layer'; DescEn = 'Name of the layer of the ''like'' dataset'; DescJa = '''like'' データセットのレイヤ名' }
        @{ Name = '--like-where'; DescEn = 'WHERE SQL clause to run on the ''like'' dataset'; DescJa = '''like'' データセットに対する WHERE 句' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/concat'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--mode'; DescEn = 'Determine the strategy to create output layers from source layers'; DescJa = 'ソースレイヤから出力レイヤを作る戦略を決定' }
        @{ Name = '--output-layer'; DescEn = 'Name of the output vector layer (single mode), or template to name the output vector layers (stack mode)'; DescJa = '出力ベクタレイヤ名 (single モード) またはレイヤ名テンプレート (stack モード)' }
        @{ Name = '--source-layer-field-name'; DescEn = 'Name of the new field to add to contain identificoncation of the source layer, with value determined from ''source-layer-field-content'''; DescJa = 'ソースレイヤ識別を格納する新規フィールド名 (''source-layer-field-content'' から値決定)' }
        @{ Name = '--source-layer-field-content'; DescEn = 'A string, possibly using {AUTO_NAME}, {DS_NAME}, {DS_BASENAME}, {DS_INDEX}, {LAYER_NAME}, {LAYER_INDEX}'; DescJa = '文字列 ({AUTO_NAME}/{DS_NAME}/{DS_BASENAME}/{DS_INDEX}/{LAYER_NAME}/{LAYER_INDEX} 変数使用可)' }
        @{ Name = '--field-strategy'; DescEn = 'How to determine target fields from source fields'; DescJa = 'ソースフィールドからターゲットフィールドを決定する方法' }
        @{ Name = '--src-crs'; DescEn = 'Source CRS'; DescJa = '入力 CRS' }
        @{ Name = '--dst-crs'; DescEn = 'Destination CRS'; DescJa = '出力 CRS' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/convert'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/edit'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--geometry-type'; DescEn = 'Layer geometry type'; DescJa = 'レイヤジオメトリ型' }
        @{ Name = '--crs'; DescEn = 'Override CRS (without reprojection)'; DescJa = 'CRS を上書き (再投影なし)' }
        @{ Name = '--metadata'; DescEn = 'Add/update dataset metadata item'; DescJa = 'データセットメタデータ項目を追加・更新' }
        @{ Name = '--unset-metadata'; DescEn = 'Remove dataset metadata item'; DescJa = 'データセットメタデータ項目を削除' }
        @{ Name = '--layer-metadata'; DescEn = 'Add/update layer metadata item'; DescJa = 'レイヤメタデータ項目を追加・更新' }
        @{ Name = '--unset-layer-metadata'; DescEn = 'Remove layer metadata item'; DescJa = 'レイヤメタデータ項目を削除' }
        @{ Name = '--unset-fid'; DescEn = 'Unset the identifier of each feature and the FID column name'; DescJa = '各フィーチャの識別子と FID カラム名を解除' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/explode-collections'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--active-geometry'; DescEn = 'Geometry field name to which to restrict the processing (if not specified, all)'; DescJa = '処理対象のジオメトリフィールド名 (未指定で全フィールド)' }
        @{ Name = '--geometry-type'; DescEn = 'Geometry type'; DescJa = 'ジオメトリ型' }
        @{ Name = '--skip-on-type-mismatch'; DescEn = 'Skip feature when change of feature geometry type failed'; DescJa = 'フィーチャジオメトリ型の変換失敗時にフィーチャをスキップ' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/filter'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--bbox'; DescEn = 'Bounding box as xmin,ymin,xmax,ymax'; DescJa = 'バウンディングボックス (xmin,ymin,xmax,ymax)' }
        @{ Name = '--where'; DescEn = 'Attribute query in a restricted form of the queries used in the SQL WHERE statement'; DescJa = 'SQL WHERE 句の制限形式による属性クエリ' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/grid'] = @{
    Subs = @(
        @{ Name = 'average'; DescEn = 'Create a regular grid from scattered points using moving average interpolation.'; DescJa = '散在点から移動平均補間で規則格子を作成' }
        @{ Name = 'average-distance'; DescEn = 'Create a regular grid from scattered points using the average distance between the grid node (center of the search ellipse) and all of the data points in the search ellipse.'; DescJa = '格子点 (探索楕円中心) と楕円内全データ点の平均距離で規則格子を作成' }
        @{ Name = 'average-distance-points'; DescEn = 'Create a regular grid from scattered points using the average distance between the data points in the search ellipse.'; DescJa = '探索楕円内データ点間の平均距離で散在点から規則格子を作成' }
        @{ Name = 'count'; DescEn = 'Create a regular grid from scattered points using the number of points in the search ellipse.'; DescJa = '探索楕円内の点数で散在点から規則格子を作成' }
        @{ Name = 'invdist'; DescEn = 'Create a regular grid from scattered points using weighted inverse distance interpolation.'; DescJa = '重み付き逆距離補間で散在点から規則格子を作成' }
        @{ Name = 'invdistnn'; DescEn = 'Create a regular grid from scattered points using weighted inverse distance interpolation nearest neighbour.'; DescJa = '最近傍版の重み付き逆距離補間で散在点から規則格子を作成' }
        @{ Name = 'linear'; DescEn = 'Create a regular grid from scattered points using linear/barycentric interpolation.'; DescJa = '散在点から線形・重心補間で規則格子を作成' }
        @{ Name = 'maximum'; DescEn = 'Create a regular grid from scattered points using the maximum value in the search ellipse.'; DescJa = '探索楕円内の最大値で散在点から規則格子を作成' }
        @{ Name = 'minimum'; DescEn = 'Create a regular grid from scattered points using the minimum value in the search ellipse.'; DescJa = '探索楕円内の最小値で散在点から規則格子を作成' }
        @{ Name = 'nearest'; DescEn = 'Create a regular grid from scattered points using nearest neighbor interpolation.'; DescJa = '散在点から最近傍補間で規則格子を作成' }
        @{ Name = 'range'; DescEn = 'Create a regular grid from scattered points using the difference between the minimum and maximum values in the search ellipse.'; DescJa = '探索楕円内の最小最大差で散在点から規則格子を作成' }
    )
    Opts = @(
    )
}
$script:EzGdalTree['gdal/vector/grid/average'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--extent'; DescEn = 'Set the target georeferenced extent'; DescJa = 'ターゲット地理参照範囲を設定' }
        @{ Name = '--resolution'; DescEn = 'Set the target resolution'; DescJa = 'ターゲット解像度を設定' }
        @{ Name = '--size'; DescEn = 'Set the target size in pixels and lines'; DescJa = 'ターゲットサイズをピクセル・ライン単位で設定' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--crs'; DescEn = 'Override the projection for the output file'; DescJa = '出力ファイルの投影を上書き' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name'; DescJa = '入力レイヤ名' }
        @{ Name = '--sql'; DescEn = 'SQL statement'; DescJa = 'SQL 文' }
        @{ Name = '--bbox'; DescEn = 'Select only points contained within the specified bounding box'; DescJa = '指定バウンディングボックス内の点のみ選択' }
        @{ Name = '--zfield'; DescEn = 'Field name from which to get Z values.'; DescJa = 'Z 値を取得するフィールド名' }
        @{ Name = '--zoffset'; DescEn = 'Value to add to the Z field value (applied before zmultiply)'; DescJa = 'Z フィールド値に加算する値 (zmultiply の前に適用)' }
        @{ Name = '--zmultiply'; DescEn = 'Multiplication factor for the Z field value (applied after zoffset)'; DescJa = 'Z フィールド値の乗算係数 (zoffset の後に適用)' }
        @{ Name = '--radius'; DescEn = 'Radius of the search circle'; DescJa = '探索円の半径' }
        @{ Name = '--radius1'; DescEn = 'First axis of the search ellipse'; DescJa = '探索楕円の第 1 軸' }
        @{ Name = '--radius2'; DescEn = 'Second axis of the search ellipse'; DescJa = '探索楕円の第 2 軸' }
        @{ Name = '--angle'; DescEn = 'Angle of search ellipse rotation in degrees (counter clockwise)'; DescJa = '探索楕円の回転角 (度、反時計回り)' }
        @{ Name = '--min-points'; DescEn = 'Minimum number of data points to use'; DescJa = '使用する最小データ点数' }
        @{ Name = '--max-points'; DescEn = 'Maximum number of data points to use'; DescJa = '使用する最大データ点数' }
        @{ Name = '--min-points-per-quadrant'; DescEn = 'Minimum number of data points to use per quadrant'; DescJa = '象限あたりの最小データ点数' }
        @{ Name = '--max-points-per-quadrant'; DescEn = 'Maximum number of data points to use per quadrant'; DescJa = '象限あたりの最大データ点数' }
        @{ Name = '--nodata'; DescEn = 'Target nodata value'; DescJa = 'ターゲット nodata 値' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/grid/average-distance'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--extent'; DescEn = 'Set the target georeferenced extent'; DescJa = 'ターゲット地理参照範囲を設定' }
        @{ Name = '--resolution'; DescEn = 'Set the target resolution'; DescJa = 'ターゲット解像度を設定' }
        @{ Name = '--size'; DescEn = 'Set the target size in pixels and lines'; DescJa = 'ターゲットサイズをピクセル・ライン単位で設定' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--crs'; DescEn = 'Override the projection for the output file'; DescJa = '出力ファイルの投影を上書き' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name'; DescJa = '入力レイヤ名' }
        @{ Name = '--sql'; DescEn = 'SQL statement'; DescJa = 'SQL 文' }
        @{ Name = '--bbox'; DescEn = 'Select only points contained within the specified bounding box'; DescJa = '指定バウンディングボックス内の点のみ選択' }
        @{ Name = '--zfield'; DescEn = 'Field name from which to get Z values.'; DescJa = 'Z 値を取得するフィールド名' }
        @{ Name = '--zoffset'; DescEn = 'Value to add to the Z field value (applied before zmultiply)'; DescJa = 'Z フィールド値に加算する値 (zmultiply の前に適用)' }
        @{ Name = '--zmultiply'; DescEn = 'Multiplication factor for the Z field value (applied after zoffset)'; DescJa = 'Z フィールド値の乗算係数 (zoffset の後に適用)' }
        @{ Name = '--radius'; DescEn = 'Radius of the search circle'; DescJa = '探索円の半径' }
        @{ Name = '--radius1'; DescEn = 'First axis of the search ellipse'; DescJa = '探索楕円の第 1 軸' }
        @{ Name = '--radius2'; DescEn = 'Second axis of the search ellipse'; DescJa = '探索楕円の第 2 軸' }
        @{ Name = '--angle'; DescEn = 'Angle of search ellipse rotation in degrees (counter clockwise)'; DescJa = '探索楕円の回転角 (度、反時計回り)' }
        @{ Name = '--min-points'; DescEn = 'Minimum number of data points to use'; DescJa = '使用する最小データ点数' }
        @{ Name = '--min-points-per-quadrant'; DescEn = 'Minimum number of data points to use per quadrant'; DescJa = '象限あたりの最小データ点数' }
        @{ Name = '--max-points-per-quadrant'; DescEn = 'Maximum number of data points to use per quadrant'; DescJa = '象限あたりの最大データ点数' }
        @{ Name = '--nodata'; DescEn = 'Target nodata value'; DescJa = 'ターゲット nodata 値' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/grid/average-distance-points'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--extent'; DescEn = 'Set the target georeferenced extent'; DescJa = 'ターゲット地理参照範囲を設定' }
        @{ Name = '--resolution'; DescEn = 'Set the target resolution'; DescJa = 'ターゲット解像度を設定' }
        @{ Name = '--size'; DescEn = 'Set the target size in pixels and lines'; DescJa = 'ターゲットサイズをピクセル・ライン単位で設定' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--crs'; DescEn = 'Override the projection for the output file'; DescJa = '出力ファイルの投影を上書き' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name'; DescJa = '入力レイヤ名' }
        @{ Name = '--sql'; DescEn = 'SQL statement'; DescJa = 'SQL 文' }
        @{ Name = '--bbox'; DescEn = 'Select only points contained within the specified bounding box'; DescJa = '指定バウンディングボックス内の点のみ選択' }
        @{ Name = '--zfield'; DescEn = 'Field name from which to get Z values.'; DescJa = 'Z 値を取得するフィールド名' }
        @{ Name = '--zoffset'; DescEn = 'Value to add to the Z field value (applied before zmultiply)'; DescJa = 'Z フィールド値に加算する値 (zmultiply の前に適用)' }
        @{ Name = '--zmultiply'; DescEn = 'Multiplication factor for the Z field value (applied after zoffset)'; DescJa = 'Z フィールド値の乗算係数 (zoffset の後に適用)' }
        @{ Name = '--radius'; DescEn = 'Radius of the search circle'; DescJa = '探索円の半径' }
        @{ Name = '--radius1'; DescEn = 'First axis of the search ellipse'; DescJa = '探索楕円の第 1 軸' }
        @{ Name = '--radius2'; DescEn = 'Second axis of the search ellipse'; DescJa = '探索楕円の第 2 軸' }
        @{ Name = '--angle'; DescEn = 'Angle of search ellipse rotation in degrees (counter clockwise)'; DescJa = '探索楕円の回転角 (度、反時計回り)' }
        @{ Name = '--min-points'; DescEn = 'Minimum number of data points to use'; DescJa = '使用する最小データ点数' }
        @{ Name = '--min-points-per-quadrant'; DescEn = 'Minimum number of data points to use per quadrant'; DescJa = '象限あたりの最小データ点数' }
        @{ Name = '--max-points-per-quadrant'; DescEn = 'Maximum number of data points to use per quadrant'; DescJa = '象限あたりの最大データ点数' }
        @{ Name = '--nodata'; DescEn = 'Target nodata value'; DescJa = 'ターゲット nodata 値' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/grid/count'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--extent'; DescEn = 'Set the target georeferenced extent'; DescJa = 'ターゲット地理参照範囲を設定' }
        @{ Name = '--resolution'; DescEn = 'Set the target resolution'; DescJa = 'ターゲット解像度を設定' }
        @{ Name = '--size'; DescEn = 'Set the target size in pixels and lines'; DescJa = 'ターゲットサイズをピクセル・ライン単位で設定' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--crs'; DescEn = 'Override the projection for the output file'; DescJa = '出力ファイルの投影を上書き' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name'; DescJa = '入力レイヤ名' }
        @{ Name = '--sql'; DescEn = 'SQL statement'; DescJa = 'SQL 文' }
        @{ Name = '--bbox'; DescEn = 'Select only points contained within the specified bounding box'; DescJa = '指定バウンディングボックス内の点のみ選択' }
        @{ Name = '--zfield'; DescEn = 'Field name from which to get Z values.'; DescJa = 'Z 値を取得するフィールド名' }
        @{ Name = '--zoffset'; DescEn = 'Value to add to the Z field value (applied before zmultiply)'; DescJa = 'Z フィールド値に加算する値 (zmultiply の前に適用)' }
        @{ Name = '--zmultiply'; DescEn = 'Multiplication factor for the Z field value (applied after zoffset)'; DescJa = 'Z フィールド値の乗算係数 (zoffset の後に適用)' }
        @{ Name = '--radius'; DescEn = 'Radius of the search circle'; DescJa = '探索円の半径' }
        @{ Name = '--radius1'; DescEn = 'First axis of the search ellipse'; DescJa = '探索楕円の第 1 軸' }
        @{ Name = '--radius2'; DescEn = 'Second axis of the search ellipse'; DescJa = '探索楕円の第 2 軸' }
        @{ Name = '--angle'; DescEn = 'Angle of search ellipse rotation in degrees (counter clockwise)'; DescJa = '探索楕円の回転角 (度、反時計回り)' }
        @{ Name = '--min-points'; DescEn = 'Minimum number of data points to use'; DescJa = '使用する最小データ点数' }
        @{ Name = '--min-points-per-quadrant'; DescEn = 'Minimum number of data points to use per quadrant'; DescJa = '象限あたりの最小データ点数' }
        @{ Name = '--max-points-per-quadrant'; DescEn = 'Maximum number of data points to use per quadrant'; DescJa = '象限あたりの最大データ点数' }
        @{ Name = '--nodata'; DescEn = 'Target nodata value'; DescJa = 'ターゲット nodata 値' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/grid/invdist'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--extent'; DescEn = 'Set the target georeferenced extent'; DescJa = 'ターゲット地理参照範囲を設定' }
        @{ Name = '--resolution'; DescEn = 'Set the target resolution'; DescJa = 'ターゲット解像度を設定' }
        @{ Name = '--size'; DescEn = 'Set the target size in pixels and lines'; DescJa = 'ターゲットサイズをピクセル・ライン単位で設定' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--crs'; DescEn = 'Override the projection for the output file'; DescJa = '出力ファイルの投影を上書き' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name'; DescJa = '入力レイヤ名' }
        @{ Name = '--sql'; DescEn = 'SQL statement'; DescJa = 'SQL 文' }
        @{ Name = '--bbox'; DescEn = 'Select only points contained within the specified bounding box'; DescJa = '指定バウンディングボックス内の点のみ選択' }
        @{ Name = '--zfield'; DescEn = 'Field name from which to get Z values.'; DescJa = 'Z 値を取得するフィールド名' }
        @{ Name = '--zoffset'; DescEn = 'Value to add to the Z field value (applied before zmultiply)'; DescJa = 'Z フィールド値に加算する値 (zmultiply の前に適用)' }
        @{ Name = '--zmultiply'; DescEn = 'Multiplication factor for the Z field value (applied after zoffset)'; DescJa = 'Z フィールド値の乗算係数 (zoffset の後に適用)' }
        @{ Name = '--power'; DescEn = 'Weighting power'; DescJa = '重みの累乗' }
        @{ Name = '--smoothing'; DescEn = 'Smoothing parameter'; DescJa = '平滑化パラメータ' }
        @{ Name = '--radius'; DescEn = 'Radius of the search circle'; DescJa = '探索円の半径' }
        @{ Name = '--radius1'; DescEn = 'First axis of the search ellipse'; DescJa = '探索楕円の第 1 軸' }
        @{ Name = '--radius2'; DescEn = 'Second axis of the search ellipse'; DescJa = '探索楕円の第 2 軸' }
        @{ Name = '--angle'; DescEn = 'Angle of search ellipse rotation in degrees (counter clockwise)'; DescJa = '探索楕円の回転角 (度、反時計回り)' }
        @{ Name = '--min-points'; DescEn = 'Minimum number of data points to use'; DescJa = '使用する最小データ点数' }
        @{ Name = '--max-points'; DescEn = 'Maximum number of data points to use'; DescJa = '使用する最大データ点数' }
        @{ Name = '--min-points-per-quadrant'; DescEn = 'Minimum number of data points to use per quadrant'; DescJa = '象限あたりの最小データ点数' }
        @{ Name = '--max-points-per-quadrant'; DescEn = 'Maximum number of data points to use per quadrant'; DescJa = '象限あたりの最大データ点数' }
        @{ Name = '--nodata'; DescEn = 'Target nodata value'; DescJa = 'ターゲット nodata 値' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/grid/invdistnn'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--extent'; DescEn = 'Set the target georeferenced extent'; DescJa = 'ターゲット地理参照範囲を設定' }
        @{ Name = '--resolution'; DescEn = 'Set the target resolution'; DescJa = 'ターゲット解像度を設定' }
        @{ Name = '--size'; DescEn = 'Set the target size in pixels and lines'; DescJa = 'ターゲットサイズをピクセル・ライン単位で設定' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--crs'; DescEn = 'Override the projection for the output file'; DescJa = '出力ファイルの投影を上書き' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name'; DescJa = '入力レイヤ名' }
        @{ Name = '--sql'; DescEn = 'SQL statement'; DescJa = 'SQL 文' }
        @{ Name = '--bbox'; DescEn = 'Select only points contained within the specified bounding box'; DescJa = '指定バウンディングボックス内の点のみ選択' }
        @{ Name = '--zfield'; DescEn = 'Field name from which to get Z values.'; DescJa = 'Z 値を取得するフィールド名' }
        @{ Name = '--zoffset'; DescEn = 'Value to add to the Z field value (applied before zmultiply)'; DescJa = 'Z フィールド値に加算する値 (zmultiply の前に適用)' }
        @{ Name = '--zmultiply'; DescEn = 'Multiplication factor for the Z field value (applied after zoffset)'; DescJa = 'Z フィールド値の乗算係数 (zoffset の後に適用)' }
        @{ Name = '--power'; DescEn = 'Weighting power'; DescJa = '重みの累乗' }
        @{ Name = '--smoothing'; DescEn = 'Smoothing parameter'; DescJa = '平滑化パラメータ' }
        @{ Name = '--radius'; DescEn = 'Radius of the search circle'; DescJa = '探索円の半径' }
        @{ Name = '--min-points'; DescEn = 'Minimum number of data points to use'; DescJa = '使用する最小データ点数' }
        @{ Name = '--max-points'; DescEn = 'Maximum number of data points to use'; DescJa = '使用する最大データ点数' }
        @{ Name = '--min-points-per-quadrant'; DescEn = 'Minimum number of data points to use per quadrant'; DescJa = '象限あたりの最小データ点数' }
        @{ Name = '--max-points-per-quadrant'; DescEn = 'Maximum number of data points to use per quadrant'; DescJa = '象限あたりの最大データ点数' }
        @{ Name = '--nodata'; DescEn = 'Target nodata value'; DescJa = 'ターゲット nodata 値' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/grid/linear'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--extent'; DescEn = 'Set the target georeferenced extent'; DescJa = 'ターゲット地理参照範囲を設定' }
        @{ Name = '--resolution'; DescEn = 'Set the target resolution'; DescJa = 'ターゲット解像度を設定' }
        @{ Name = '--size'; DescEn = 'Set the target size in pixels and lines'; DescJa = 'ターゲットサイズをピクセル・ライン単位で設定' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--crs'; DescEn = 'Override the projection for the output file'; DescJa = '出力ファイルの投影を上書き' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name'; DescJa = '入力レイヤ名' }
        @{ Name = '--sql'; DescEn = 'SQL statement'; DescJa = 'SQL 文' }
        @{ Name = '--bbox'; DescEn = 'Select only points contained within the specified bounding box'; DescJa = '指定バウンディングボックス内の点のみ選択' }
        @{ Name = '--zfield'; DescEn = 'Field name from which to get Z values.'; DescJa = 'Z 値を取得するフィールド名' }
        @{ Name = '--zoffset'; DescEn = 'Value to add to the Z field value (applied before zmultiply)'; DescJa = 'Z フィールド値に加算する値 (zmultiply の前に適用)' }
        @{ Name = '--zmultiply'; DescEn = 'Multiplication factor for the Z field value (applied after zoffset)'; DescJa = 'Z フィールド値の乗算係数 (zoffset の後に適用)' }
        @{ Name = '--radius'; DescEn = 'Radius of the search circle'; DescJa = '探索円の半径' }
        @{ Name = '--nodata'; DescEn = 'Target nodata value'; DescJa = 'ターゲット nodata 値' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/grid/maximum'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--extent'; DescEn = 'Set the target georeferenced extent'; DescJa = 'ターゲット地理参照範囲を設定' }
        @{ Name = '--resolution'; DescEn = 'Set the target resolution'; DescJa = 'ターゲット解像度を設定' }
        @{ Name = '--size'; DescEn = 'Set the target size in pixels and lines'; DescJa = 'ターゲットサイズをピクセル・ライン単位で設定' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--crs'; DescEn = 'Override the projection for the output file'; DescJa = '出力ファイルの投影を上書き' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name'; DescJa = '入力レイヤ名' }
        @{ Name = '--sql'; DescEn = 'SQL statement'; DescJa = 'SQL 文' }
        @{ Name = '--bbox'; DescEn = 'Select only points contained within the specified bounding box'; DescJa = '指定バウンディングボックス内の点のみ選択' }
        @{ Name = '--zfield'; DescEn = 'Field name from which to get Z values.'; DescJa = 'Z 値を取得するフィールド名' }
        @{ Name = '--zoffset'; DescEn = 'Value to add to the Z field value (applied before zmultiply)'; DescJa = 'Z フィールド値に加算する値 (zmultiply の前に適用)' }
        @{ Name = '--zmultiply'; DescEn = 'Multiplication factor for the Z field value (applied after zoffset)'; DescJa = 'Z フィールド値の乗算係数 (zoffset の後に適用)' }
        @{ Name = '--radius'; DescEn = 'Radius of the search circle'; DescJa = '探索円の半径' }
        @{ Name = '--radius1'; DescEn = 'First axis of the search ellipse'; DescJa = '探索楕円の第 1 軸' }
        @{ Name = '--radius2'; DescEn = 'Second axis of the search ellipse'; DescJa = '探索楕円の第 2 軸' }
        @{ Name = '--angle'; DescEn = 'Angle of search ellipse rotation in degrees (counter clockwise)'; DescJa = '探索楕円の回転角 (度、反時計回り)' }
        @{ Name = '--min-points'; DescEn = 'Minimum number of data points to use'; DescJa = '使用する最小データ点数' }
        @{ Name = '--min-points-per-quadrant'; DescEn = 'Minimum number of data points to use per quadrant'; DescJa = '象限あたりの最小データ点数' }
        @{ Name = '--max-points-per-quadrant'; DescEn = 'Maximum number of data points to use per quadrant'; DescJa = '象限あたりの最大データ点数' }
        @{ Name = '--nodata'; DescEn = 'Target nodata value'; DescJa = 'ターゲット nodata 値' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/grid/minimum'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--extent'; DescEn = 'Set the target georeferenced extent'; DescJa = 'ターゲット地理参照範囲を設定' }
        @{ Name = '--resolution'; DescEn = 'Set the target resolution'; DescJa = 'ターゲット解像度を設定' }
        @{ Name = '--size'; DescEn = 'Set the target size in pixels and lines'; DescJa = 'ターゲットサイズをピクセル・ライン単位で設定' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--crs'; DescEn = 'Override the projection for the output file'; DescJa = '出力ファイルの投影を上書き' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name'; DescJa = '入力レイヤ名' }
        @{ Name = '--sql'; DescEn = 'SQL statement'; DescJa = 'SQL 文' }
        @{ Name = '--bbox'; DescEn = 'Select only points contained within the specified bounding box'; DescJa = '指定バウンディングボックス内の点のみ選択' }
        @{ Name = '--zfield'; DescEn = 'Field name from which to get Z values.'; DescJa = 'Z 値を取得するフィールド名' }
        @{ Name = '--zoffset'; DescEn = 'Value to add to the Z field value (applied before zmultiply)'; DescJa = 'Z フィールド値に加算する値 (zmultiply の前に適用)' }
        @{ Name = '--zmultiply'; DescEn = 'Multiplication factor for the Z field value (applied after zoffset)'; DescJa = 'Z フィールド値の乗算係数 (zoffset の後に適用)' }
        @{ Name = '--radius'; DescEn = 'Radius of the search circle'; DescJa = '探索円の半径' }
        @{ Name = '--radius1'; DescEn = 'First axis of the search ellipse'; DescJa = '探索楕円の第 1 軸' }
        @{ Name = '--radius2'; DescEn = 'Second axis of the search ellipse'; DescJa = '探索楕円の第 2 軸' }
        @{ Name = '--angle'; DescEn = 'Angle of search ellipse rotation in degrees (counter clockwise)'; DescJa = '探索楕円の回転角 (度、反時計回り)' }
        @{ Name = '--min-points'; DescEn = 'Minimum number of data points to use'; DescJa = '使用する最小データ点数' }
        @{ Name = '--min-points-per-quadrant'; DescEn = 'Minimum number of data points to use per quadrant'; DescJa = '象限あたりの最小データ点数' }
        @{ Name = '--max-points-per-quadrant'; DescEn = 'Maximum number of data points to use per quadrant'; DescJa = '象限あたりの最大データ点数' }
        @{ Name = '--nodata'; DescEn = 'Target nodata value'; DescJa = 'ターゲット nodata 値' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/grid/nearest'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--extent'; DescEn = 'Set the target georeferenced extent'; DescJa = 'ターゲット地理参照範囲を設定' }
        @{ Name = '--resolution'; DescEn = 'Set the target resolution'; DescJa = 'ターゲット解像度を設定' }
        @{ Name = '--size'; DescEn = 'Set the target size in pixels and lines'; DescJa = 'ターゲットサイズをピクセル・ライン単位で設定' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--crs'; DescEn = 'Override the projection for the output file'; DescJa = '出力ファイルの投影を上書き' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name'; DescJa = '入力レイヤ名' }
        @{ Name = '--sql'; DescEn = 'SQL statement'; DescJa = 'SQL 文' }
        @{ Name = '--bbox'; DescEn = 'Select only points contained within the specified bounding box'; DescJa = '指定バウンディングボックス内の点のみ選択' }
        @{ Name = '--zfield'; DescEn = 'Field name from which to get Z values.'; DescJa = 'Z 値を取得するフィールド名' }
        @{ Name = '--zoffset'; DescEn = 'Value to add to the Z field value (applied before zmultiply)'; DescJa = 'Z フィールド値に加算する値 (zmultiply の前に適用)' }
        @{ Name = '--zmultiply'; DescEn = 'Multiplication factor for the Z field value (applied after zoffset)'; DescJa = 'Z フィールド値の乗算係数 (zoffset の後に適用)' }
        @{ Name = '--radius'; DescEn = 'Radius of the search circle'; DescJa = '探索円の半径' }
        @{ Name = '--radius1'; DescEn = 'First axis of the search ellipse'; DescJa = '探索楕円の第 1 軸' }
        @{ Name = '--radius2'; DescEn = 'Second axis of the search ellipse'; DescJa = '探索楕円の第 2 軸' }
        @{ Name = '--angle'; DescEn = 'Angle of search ellipse rotation in degrees (counter clockwise)'; DescJa = '探索楕円の回転角 (度、反時計回り)' }
        @{ Name = '--nodata'; DescEn = 'Target nodata value'; DescJa = 'ターゲット nodata 値' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/grid/range'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--extent'; DescEn = 'Set the target georeferenced extent'; DescJa = 'ターゲット地理参照範囲を設定' }
        @{ Name = '--resolution'; DescEn = 'Set the target resolution'; DescJa = 'ターゲット解像度を設定' }
        @{ Name = '--size'; DescEn = 'Set the target size in pixels and lines'; DescJa = 'ターゲットサイズをピクセル・ライン単位で設定' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--crs'; DescEn = 'Override the projection for the output file'; DescJa = '出力ファイルの投影を上書き' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name'; DescJa = '入力レイヤ名' }
        @{ Name = '--sql'; DescEn = 'SQL statement'; DescJa = 'SQL 文' }
        @{ Name = '--bbox'; DescEn = 'Select only points contained within the specified bounding box'; DescJa = '指定バウンディングボックス内の点のみ選択' }
        @{ Name = '--zfield'; DescEn = 'Field name from which to get Z values.'; DescJa = 'Z 値を取得するフィールド名' }
        @{ Name = '--zoffset'; DescEn = 'Value to add to the Z field value (applied before zmultiply)'; DescJa = 'Z フィールド値に加算する値 (zmultiply の前に適用)' }
        @{ Name = '--zmultiply'; DescEn = 'Multiplication factor for the Z field value (applied after zoffset)'; DescJa = 'Z フィールド値の乗算係数 (zoffset の後に適用)' }
        @{ Name = '--radius'; DescEn = 'Radius of the search circle'; DescJa = '探索円の半径' }
        @{ Name = '--radius1'; DescEn = 'First axis of the search ellipse'; DescJa = '探索楕円の第 1 軸' }
        @{ Name = '--radius2'; DescEn = 'Second axis of the search ellipse'; DescJa = '探索楕円の第 2 軸' }
        @{ Name = '--angle'; DescEn = 'Angle of search ellipse rotation in degrees (counter clockwise)'; DescJa = '探索楕円の回転角 (度、反時計回り)' }
        @{ Name = '--min-points'; DescEn = 'Minimum number of data points to use'; DescJa = '使用する最小データ点数' }
        @{ Name = '--min-points-per-quadrant'; DescEn = 'Minimum number of data points to use per quadrant'; DescJa = '象限あたりの最小データ点数' }
        @{ Name = '--max-points-per-quadrant'; DescEn = 'Maximum number of data points to use per quadrant'; DescJa = '象限あたりの最大データ点数' }
        @{ Name = '--nodata'; DescEn = 'Target nodata value'; DescJa = 'ターゲット nodata 値' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/index'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--recursive'; DescEn = 'Whether input directories should be explored recursively.'; DescJa = '入力ディレクトリを再帰的に探索するか' }
        @{ Name = '--filename-filter'; DescEn = 'Pattern that the filenames in input directories should follow (''*'' and ''?'' wildcard)'; DescJa = '入力ディレクトリ内ファイル名が従うパターン (''*'' / ''?'' ワイルドカード)' }
        @{ Name = '--location-name'; DescEn = 'Name of the field with the vector path'; DescJa = 'ベクタパスを格納するフィールド名' }
        @{ Name = '--absolute-path'; DescEn = 'Whether the path to the input datasets should be stored as an absolute path'; DescJa = '入力データセットのパスを絶対パスで格納するか' }
        @{ Name = '--dst-crs'; DescEn = 'Destination CRS'; DescJa = '出力 CRS' }
        @{ Name = '--metadata'; DescEn = 'Add dataset metadata item'; DescJa = 'データセットメタデータ項目を追加' }
        @{ Name = '--source-crs-field-name'; DescEn = 'Name of the field to store the CRS of each dataset'; DescJa = '各データセットの CRS を格納するフィールド名' }
        @{ Name = '--source-crs-format'; DescEn = 'Format in which the CRS of each dataset must be written'; DescJa = '各データセットの CRS を書き出すフォーマット' }
        @{ Name = '--source-layer-name'; DescEn = 'Add layer of specified name from each source file in the tile index'; DescJa = '各ソースファイルから指定名のレイヤをタイルインデックスに追加' }
        @{ Name = '--source-layer-index'; DescEn = 'Add layer of specified index (0-based) from each source file in the tile index'; DescJa = '各ソースファイルから指定インデックス (0 始まり) のレイヤをタイルインデックスに追加' }
        @{ Name = '--accept-different-crs'; DescEn = 'Whether layers with different CRS are accepted'; DescJa = '異なる CRS のレイヤを受け入れるか' }
        @{ Name = '--accept-different-schemas'; DescEn = 'Whether layers with different schemas are accepted'; DescJa = '異なるスキーマのレイヤを受け入れるか' }
        @{ Name = '--dataset-name-only'; DescEn = 'Whether to write the dataset name only, instead of suffixed with the layer index'; DescJa = 'レイヤインデックス付きではなくデータセット名のみで書き出すか' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/info'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name'; DescJa = '入力レイヤ名' }
        @{ Name = '--features'; DescEn = 'List all features (beware of RAM consumption on large layers)'; DescJa = '全フィーチャを列挙 (大きいレイヤではメモリ消費に注意)' }
        @{ Name = '--summary'; DescEn = 'List the layer names and the geometry type'; DescJa = 'レイヤ名とジオメトリ型を列挙' }
        @{ Name = '--limit'; DescEn = 'Limit the number of features per layer (implies --features)'; DescJa = 'レイヤあたりのフィーチャ数を制限 (--features を含意)' }
        @{ Name = '--sql'; DescEn = 'Execute the indicated SQL statement and return the result'; DescJa = '指定 SQL 文を実行し結果を返す' }
        @{ Name = '--where'; DescEn = 'Attribute query in a restricted form of the queries used in the SQL WHERE statement'; DescJa = 'SQL WHERE 句の制限形式による属性クエリ' }
        @{ Name = '--dialect'; DescEn = 'SQL dialect'; DescJa = 'SQL 方言' }
        @{ Name = '--update'; DescEn = 'Open the dataset in update mode'; DescJa = 'データセットを更新モードで開く' }
    )
}
$script:EzGdalTree['gdal/vector/layer-algebra'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--operation'; DescEn = 'Operation to perform'; DescJa = '実行する操作' }
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input vector dataset'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--method'; DescEn = 'Method vector dataset'; DescJa = 'method ベクタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name'; DescJa = '入力レイヤ名' }
        @{ Name = '--method-layer'; DescEn = 'Method layer name'; DescJa = 'method レイヤ名' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--geometry-type'; DescEn = 'Geometry type'; DescJa = 'ジオメトリ型' }
        @{ Name = '--input-prefix'; DescEn = 'Prefix for fields corresponding to input layer'; DescJa = '入力レイヤ対応フィールドのプレフィックス' }
        @{ Name = '--input-field'; DescEn = 'Input field(s) to add to output layer'; DescJa = '出力レイヤに追加する入力フィールド' }
        @{ Name = '--no-input-field'; DescEn = 'Do not add any input field to output layer'; DescJa = '入力レイヤのフィールドを出力レイヤに追加しない' }
        @{ Name = '--all-input-field'; DescEn = 'Add all input fields to output layer'; DescJa = '入力レイヤの全フィールドを出力レイヤに追加' }
        @{ Name = '--method-prefix'; DescEn = 'Prefix for fields corresponding to method layer'; DescJa = 'method レイヤ対応フィールドのプレフィックス' }
        @{ Name = '--method-field'; DescEn = 'Method field(s) to add to output layer'; DescJa = '出力レイヤに追加する method フィールド' }
        @{ Name = '--no-method-field'; DescEn = 'Do not add any method field to output layer'; DescJa = 'method レイヤのフィールドを出力レイヤに追加しない' }
        @{ Name = '--all-method-field'; DescEn = 'Add all method fields to output layer'; DescJa = 'method レイヤの全フィールドを出力レイヤに追加' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/make-point'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--x'; DescEn = 'Field from which X coordinate should be read'; DescJa = 'X 座標を読むフィールド' }
        @{ Name = '--y'; DescEn = 'Field from which Y coordinate should be read'; DescJa = 'Y 座標を読むフィールド' }
        @{ Name = '--z'; DescEn = 'Optional field from which Z coordinate should be read'; DescJa = 'Z 座標を読む任意フィールド' }
        @{ Name = '--m'; DescEn = 'Optional field from which M coordinate should be read'; DescJa = 'M 座標を読む任意フィールド' }
        @{ Name = '--dst-crs'; DescEn = 'Destination CRS'; DescJa = '出力 CRS' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/make-valid'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--active-geometry'; DescEn = 'Geometry field name to which to restrict the processing (if not specified, all)'; DescJa = '処理対象のジオメトリフィールド名 (未指定で全フィールド)' }
        @{ Name = '--method'; DescEn = 'Algorithm to use when repairing invalid geometries.'; DescJa = '無効ジオメトリ修復に使うアルゴリズム' }
        @{ Name = '--keep-lower-dim'; DescEn = 'Keep components of lower dimension after MakeValid()'; DescJa = 'MakeValid() 後に低次元コンポーネントを保持' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/partition'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--output'; DescEn = 'Output directory'; DescJa = '出力ディレクトリ' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--field'; DescEn = 'Field(s) on which to partition'; DescJa = 'パーティション対象フィールド' }
        @{ Name = '--scheme'; DescEn = 'Partitioning scheme'; DescJa = 'パーティション方式' }
        @{ Name = '--pattern'; DescEn = 'Filename pattern (''part_%010d'' for scheme=hive, ''{LAYER_NAME}_{FIELD_VALUE}_%010d'' for scheme=flat)'; DescJa = 'ファイル名パターン (scheme=hive で ''part_%010d''、scheme=flat で ''{LAYER_NAME}_{FIELD_VALUE}_%010d'')' }
        @{ Name = '--feature-limit'; DescEn = 'Maximum number of features per file'; DescJa = 'ファイルあたりの最大フィーチャ数' }
        @{ Name = '--max-file-size'; DescEn = 'Maximum file size (MB or GB suffix can be used)'; DescJa = '最大ファイルサイズ (MB / GB 接尾辞可)' }
        @{ Name = '--omit-partitioned-field'; DescEn = 'Whether to omit partitioned fields from target layer definition'; DescJa = 'ターゲットレイヤ定義からパーティションフィールドを省くか' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
    )
}
$script:EzGdalTree['gdal/vector/pipeline'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--pipeline'; DescEn = 'Pipeline string'; DescJa = 'パイプライン文字列' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/rasterize'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--band'; DescEn = 'The band(s) to burn values into (1-based index)'; DescJa = '値を焼き込むバンド (1 始まりインデックス)' }
        @{ Name = '--invert'; DescEn = 'Invert the rasterization'; DescJa = 'ラスタライズを反転' }
        @{ Name = '--all-touched'; DescEn = 'Enables the ALL_TOUCHED rasterization option'; DescJa = 'ALL_TOUCHED ラスタライズオプションを有効化' }
        @{ Name = '--burn'; DescEn = 'Burn value'; DescJa = '焼き込み値' }
        @{ Name = '--attribute-name'; DescEn = 'Attribute name'; DescJa = '属性名' }
        @{ Name = '--3d'; DescEn = 'Indicates that a burn value should be extracted from the Z values of the feature'; DescJa = '焼き込み値をフィーチャの Z 値から取得' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name'; DescJa = '入力レイヤ名' }
        @{ Name = '--where'; DescEn = 'SQL where clause'; DescJa = 'SQL WHERE 句' }
        @{ Name = '--sql'; DescEn = 'SQL select statement'; DescJa = 'SQL SELECT 文' }
        @{ Name = '--dialect'; DescEn = 'SQL dialect'; DescJa = 'SQL 方言' }
        @{ Name = '--nodata'; DescEn = 'Assign a specified nodata value to output bands'; DescJa = '出力バンドに指定した nodata 値を割り当て' }
        @{ Name = '--init'; DescEn = 'Pre-initialize output bands with specified value'; DescJa = '指定値で出力バンドを初期化' }
        @{ Name = '--crs'; DescEn = 'Override the projection for the output file'; DescJa = '出力ファイルの投影を上書き' }
        @{ Name = '--transformer-option'; DescEn = 'Set a transformer option suitable to pass to GDALCreateGenImgProjTransformer2'; DescJa = 'GDALCreateGenImgProjTransformer2 に渡す変換器オプションを設定' }
        @{ Name = '--extent'; DescEn = 'Set the target georeferenced extent'; DescJa = 'ターゲット地理参照範囲を設定' }
        @{ Name = '--resolution'; DescEn = 'Set the target resolution'; DescJa = 'ターゲット解像度を設定' }
        @{ Name = '--target-aligned-pixels'; DescEn = '(target aligned pixels) Align the coordinates of the extent of the output file to the values of the resolution'; DescJa = '出力ファイルの範囲座標を解像度値にアラインする (TAP)' }
        @{ Name = '--size'; DescEn = 'Set the target size in pixels and lines'; DescJa = 'ターゲットサイズをピクセル・ライン単位で設定' }
        @{ Name = '--output-data-type'; DescEn = 'Output data type'; DescJa = '出力データ型' }
        @{ Name = '--optimization'; DescEn = 'Force the algorithm used (results are identical)'; DescJa = '使用アルゴリズムを強制 (結果は同一)' }
        @{ Name = '--add'; DescEn = 'Add to existing raster'; DescJa = '既存ラスタに追加' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--output'; DescEn = 'Output raster dataset'; DescJa = '出力ラスタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/reproject'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--src-crs'; DescEn = 'Source CRS'; DescJa = '入力 CRS' }
        @{ Name = '--dst-crs'; DescEn = 'Destination CRS'; DescJa = '出力 CRS' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/segmentize'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--active-geometry'; DescEn = 'Geometry field name to which to restrict the processing (if not specified, all)'; DescJa = '処理対象のジオメトリフィールド名 (未指定で全フィールド)' }
        @{ Name = '--max-length'; DescEn = 'Maximum length of a segment'; DescJa = 'セグメントの最大長' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/select'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--fields'; DescEn = 'Fields to select (or exclude if --exclude)'; DescJa = '選択するフィールド (--exclude 指定時は除外対象)' }
        @{ Name = '--exclude'; DescEn = 'Exclude specified fields'; DescJa = '指定フィールドを除外' }
        @{ Name = '--ignore-missing-fields'; DescEn = 'Ignore missing fields'; DescJa = '欠落フィールドを無視' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/set-field-type'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--field-name'; DescEn = 'Field name'; DescJa = 'フィールド名' }
        @{ Name = '--src-field-type'; DescEn = 'Source field type or subtype'; DescJa = 'ソースフィールドの型・サブタイプ' }
        @{ Name = '--field-type'; DescEn = 'Target field type or subtype'; DescJa = 'ターゲットフィールドの型・サブタイプ' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/set-geom-type'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--active-geometry'; DescEn = 'Geometry field name to which to restrict the processing (if not specified, all)'; DescJa = '処理対象のジオメトリフィールド名 (未指定で全フィールド)' }
        @{ Name = '--layer-only'; DescEn = 'Only modify the layer geometry type'; DescJa = 'レイヤジオメトリ型のみ変更' }
        @{ Name = '--feature-only'; DescEn = 'Only modify the geometry type of features'; DescJa = 'フィーチャのジオメトリ型のみ変更' }
        @{ Name = '--geometry-type'; DescEn = 'Geometry type'; DescJa = 'ジオメトリ型' }
        @{ Name = '--multi'; DescEn = 'Force geometries to MULTI geometry types'; DescJa = 'ジオメトリを MULTI 型に強制' }
        @{ Name = '--single'; DescEn = 'Force geometries to non-MULTI geometry types'; DescJa = 'ジオメトリを非 MULTI 型に強制' }
        @{ Name = '--linear'; DescEn = 'Convert curve geometries to linear types'; DescJa = '曲線ジオメトリを線形型に変換' }
        @{ Name = '--curve'; DescEn = 'Convert linear geometries to curve types'; DescJa = '線形ジオメトリを曲線型に変換' }
        @{ Name = '--dim'; DescEn = 'Force geometries to the specified dimension'; DescJa = 'ジオメトリを指定次元に強制' }
        @{ Name = '--skip'; DescEn = 'Skip feature when change of feature geometry type failed'; DescJa = 'フィーチャジオメトリ型の変換失敗時にフィーチャをスキップ' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/simplify'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--active-geometry'; DescEn = 'Geometry field name to which to restrict the processing (if not specified, all)'; DescJa = '処理対象のジオメトリフィールド名 (未指定で全フィールド)' }
        @{ Name = '--tolerance'; DescEn = 'Distance tolerance for simplification.'; DescJa = '簡略化の距離許容値' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/simplify-coverage'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--tolerance'; DescEn = 'Distance tolerance for simplification.'; DescJa = '簡略化の距離許容値' }
        @{ Name = '--preserve-boundary'; DescEn = 'Whether the exterior boundary should be preserved.'; DescJa = '外周境界を保持するか' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/sql'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--sql'; DescEn = 'SQL statement(s)'; DescJa = 'SQL 文' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name(s)'; DescJa = '出力レイヤ名' }
        @{ Name = '--dialect'; DescEn = 'SQL dialect (e.g. OGRSQL, SQLITE)'; DescJa = 'SQL 方言 (OGRSQL / SQLITE 等)' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vector/swap-xy'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input-format'; DescEn = 'Input formats'; DescJa = '入力フォーマット' }
        @{ Name = '--open-option'; DescEn = 'Open options'; DescJa = 'オープンオプション' }
        @{ Name = '--input'; DescEn = 'Input vector datasets'; DescJa = '入力ベクタデータセット' }
        @{ Name = '--input-layer'; DescEn = 'Input layer name(s)'; DescJa = '入力レイヤ名' }
        @{ Name = '--output-format'; DescEn = 'Output format ("GDALG" allowed)'; DescJa = '出力フォーマット ("GDALG" 可)' }
        @{ Name = '--output-open-option'; DescEn = 'Output open options'; DescJa = '出力オープンオプション' }
        @{ Name = '--creation-option'; DescEn = 'Creation option'; DescJa = '作成オプション' }
        @{ Name = '--layer-creation-option'; DescEn = 'Layer creation option'; DescJa = 'レイヤ作成オプション' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--update'; DescEn = 'Whether to open existing dataset in update mode'; DescJa = '既存データセットを更新モードで開くか' }
        @{ Name = '--overwrite-layer'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--append'; DescEn = 'Whether appending to existing layer is allowed'; DescJa = '既存レイヤへの追記を許可するか' }
        @{ Name = '--upsert'; DescEn = 'Upsert features (implies ''append'')'; DescJa = 'フィーチャを upsert (''append'' を含意)' }
        @{ Name = '--output-layer'; DescEn = 'Output layer name'; DescJa = '出力レイヤ名' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors when writing features'; DescJa = 'フィーチャ書き込みエラーをスキップ' }
        @{ Name = '--active-layer'; DescEn = 'Set active layer (if not specified, all)'; DescJa = 'アクティブレイヤを設定 (未指定で全レイヤ)' }
        @{ Name = '--active-geometry'; DescEn = 'Geometry field name to which to restrict the processing (if not specified, all)'; DescJa = '処理対象のジオメトリフィールド名 (未指定で全フィールド)' }
        @{ Name = '--output'; DescEn = 'Output vector dataset'; DescJa = '出力ベクタデータセット' }
    )
}
$script:EzGdalTree['gdal/vsi'] = @{
    Subs = @(
        @{ Name = 'copy'; DescEn = 'Copy files located on GDAL Virtual System Interface (VSI).'; DescJa = 'GDAL VSI 上のファイルをコピー' }
        @{ Name = 'delete'; DescEn = 'Delete files located on GDAL Virtual System Interface (VSI).'; DescJa = 'GDAL VSI 上のファイルを削除' }
        @{ Name = 'list'; DescEn = 'List files of one of the GDAL Virtual System Interface (VSI).'; DescJa = 'GDAL VSI 上のファイルを列挙' }
        @{ Name = 'move'; DescEn = 'Move/rename a file/directory located on GDAL Virtual System Interface (VSI).'; DescJa = 'GDAL VSI 上のファイル・ディレクトリを移動・改名' }
        @{ Name = 'sozip'; DescEn = 'Seek-optimized ZIP (SOZIP) commands.'; DescJa = 'シーク最適化 ZIP (SOZIP) コマンド' }
        @{ Name = 'sync'; DescEn = 'Synchronize source and target file/directory located on GDAL Virtual System Interface (VSI).'; DescJa = 'GDAL VSI 上のソースとターゲットを同期' }
    )
    Opts = @(
    )
}
$script:EzGdalTree['gdal/vsi/copy'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--source'; DescEn = 'Source file or directory name'; DescJa = '入力ファイル・ディレクトリ名' }
        @{ Name = '--destination'; DescEn = 'Destination file or directory name'; DescJa = '出力ファイル・ディレクトリ名' }
        @{ Name = '--recursive'; DescEn = 'Copy subdirectories recursively'; DescJa = 'サブディレクトリを再帰的にコピー' }
        @{ Name = '--skip-errors'; DescEn = 'Skip errors'; DescJa = 'エラーをスキップ' }
    )
}
$script:EzGdalTree['gdal/vsi/delete'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--filename'; DescEn = 'File or directory name to delete'; DescJa = '削除対象のファイル・ディレクトリ名' }
        @{ Name = '--recursive'; DescEn = 'Delete directories recursively'; DescJa = 'ディレクトリを再帰的に削除' }
    )
}
$script:EzGdalTree['gdal/vsi/list'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--filename'; DescEn = 'File or directory name'; DescJa = 'ファイル・ディレクトリ名' }
        @{ Name = '--output-format'; DescEn = 'Output format'; DescJa = '出力フォーマット' }
        @{ Name = '--long-listing'; DescEn = 'Use a long listing format'; DescJa = 'ロングフォーマットで一覧表示' }
        @{ Name = '--recursive'; DescEn = 'List subdirectories recursively'; DescJa = 'サブディレクトリを再帰的に列挙' }
        @{ Name = '--depth'; DescEn = 'Maximum depth in recursive mode'; DescJa = '再帰モードの最大深さ' }
        @{ Name = '--absolute-path'; DescEn = 'Display absolute path'; DescJa = '絶対パスで表示' }
        @{ Name = '--tree'; DescEn = 'Use a hierarchical presentation for JSON output'; DescJa = 'JSON 出力を階層表現にする' }
    )
}
$script:EzGdalTree['gdal/vsi/move'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--source'; DescEn = 'Source file or directory name'; DescJa = '入力ファイル・ディレクトリ名' }
        @{ Name = '--destination'; DescEn = 'Destination file or directory name'; DescJa = '出力ファイル・ディレクトリ名' }
    )
}
$script:EzGdalTree['gdal/vsi/sozip'] = @{
    Subs = @(
        @{ Name = 'create'; DescEn = 'Create a Seek-optimized ZIP (SOZIP) file.'; DescJa = 'シーク最適化 ZIP (SOZIP) を作成' }
        @{ Name = 'list'; DescEn = 'List content of a ZIP file, with SOZIP related information.'; DescJa = 'ZIP ファイルの内容を SOZIP 関連情報付きで列挙' }
        @{ Name = 'optimize'; DescEn = 'Create a Seek-optimized ZIP (SOZIP) file from a regular ZIP file.'; DescJa = '通常 ZIP からシーク最適化 ZIP (SOZIP) を作成' }
        @{ Name = 'validate'; DescEn = 'Validate a ZIP file, possibly using SOZIP optimization.'; DescJa = 'ZIP ファイルを検証 (SOZIP 最適化対応)' }
    )
    Opts = @(
    )
}
$script:EzGdalTree['gdal/vsi/sozip/create'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input'; DescEn = 'Input filenames'; DescJa = '入力ファイル名' }
        @{ Name = '--output'; DescEn = 'Output ZIP filename'; DescJa = '出力 ZIP ファイル名' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--recursive'; DescEn = 'Travels the directory structure of the specified directories recursively'; DescJa = '指定ディレクトリのディレクトリ構造を再帰的にたどる' }
        @{ Name = '--no-paths'; DescEn = 'Store just the name of a saved file, and do not store directory names'; DescJa = 'ディレクトリ名を含めず保存ファイル名のみ格納' }
        @{ Name = '--enable-sozip'; DescEn = 'Whether to automatically/systematically/never apply the SOZIP optimization'; DescJa = 'SOZIP 最適化を自動・常時・適用しないかを選択' }
        @{ Name = '--sozip-chunk-size'; DescEn = 'Chunk size for a seek-optimized file'; DescJa = 'シーク最適化ファイルのチャンクサイズ' }
        @{ Name = '--sozip-min-file-size'; DescEn = 'Minimum file size to decide if a file should be seek-optimized'; DescJa = 'シーク最適化対象とする最小ファイルサイズ' }
        @{ Name = '--content-type'; DescEn = 'Store the Content-Type of the file being added.'; DescJa = '追加するファイルの Content-Type を格納' }
    )
}
$script:EzGdalTree['gdal/vsi/sozip/list'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input'; DescEn = 'Input ZIP filename'; DescJa = '入力 ZIP ファイル名' }
    )
}
$script:EzGdalTree['gdal/vsi/sozip/optimize'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input'; DescEn = 'Input ZIP filename'; DescJa = '入力 ZIP ファイル名' }
        @{ Name = '--output'; DescEn = 'Output ZIP filename'; DescJa = '出力 ZIP ファイル名' }
        @{ Name = '--overwrite'; DescEn = 'Whether overwriting existing output is allowed'; DescJa = '既存出力の上書きを許可するか' }
        @{ Name = '--enable-sozip'; DescEn = 'Whether to automatically/systematically/never apply the SOZIP optimization'; DescJa = 'SOZIP 最適化を自動・常時・適用しないかを選択' }
        @{ Name = '--sozip-chunk-size'; DescEn = 'Chunk size for a seek-optimized file'; DescJa = 'シーク最適化ファイルのチャンクサイズ' }
        @{ Name = '--sozip-min-file-size'; DescEn = 'Minimum file size to decide if a file should be seek-optimized'; DescJa = 'シーク最適化対象とする最小ファイルサイズ' }
    )
}
$script:EzGdalTree['gdal/vsi/sozip/validate'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--input'; DescEn = 'Input ZIP filename'; DescJa = '入力 ZIP ファイル名' }
    )
}
$script:EzGdalTree['gdal/vsi/sync'] = @{
    Subs = @(
    )
    Opts = @(
        @{ Name = '--source'; DescEn = 'Source file or directory name'; DescJa = '入力ファイル・ディレクトリ名' }
        @{ Name = '--destination'; DescEn = 'Destination file or directory name'; DescJa = '出力ファイル・ディレクトリ名' }
        @{ Name = '--recursive'; DescEn = 'Synchronize recursively'; DescJa = '再帰的に同期' }
        @{ Name = '--strategy'; DescEn = 'Synchronization strategy'; DescJa = '同期戦略' }
        @{ Name = '--num-threads'; DescEn = 'Number of jobs (or ALL_CPUS)'; DescJa = '並列ジョブ数 (または ALL_CPUS)' }
    )
}


$script:EzGdalCompleter = {
    param($wordToComplete, $commandAst, $cursorPosition)
    $useJa = ([System.Globalization.CultureInfo]::CurrentCulture.TwoLetterISOLanguageName -eq 'ja')
    $tokens = @()
    foreach ($e in $commandAst.CommandElements) {
        $tokens += $e.Extent.Text
    }
    $path = 'gdal'
    for ($i = 1; $i -lt $tokens.Count; $i++) {
        $t = $tokens[$i]
        if ($t.StartsWith('-')) { break }
        # Why: 末尾要素は補完対象 (まだ確定していない単語) なので path に組み込まない
        if (-not [string]::IsNullOrEmpty($wordToComplete) -and $i -eq $tokens.Count - 1) { break }
        $trial = "$path/$t"
        if ($script:EzGdalTree.ContainsKey($trial)) {
            $path = $trial
        } else {
            break
        }
    }
    $node = $script:EzGdalTree[$path]
    if ($null -eq $node) { return }
    if ($wordToComplete.StartsWith('-')) {
        foreach ($o in $node.Opts) {
            if ($o.Name -like "$wordToComplete*") {
                $desc = if ($useJa) { $o.DescJa } else { $o.DescEn }
                [System.Management.Automation.CompletionResult]::new(
                    $o.Name, $o.Name, 'ParameterName', $desc)
            }
        }
    } else {
        foreach ($s in $node.Subs) {
            if ($s.Name -like "$wordToComplete*") {
                $desc = if ($useJa) { $s.DescJa } else { $s.DescEn }
                [System.Management.Automation.CompletionResult]::new(
                    $s.Name, $s.Name, 'Command', $desc)
            }
        }
    }
}

Register-ArgumentCompleter -CommandName 'ezgdal','gdal' -Native -ScriptBlock $script:EzGdalCompleter

