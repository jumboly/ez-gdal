# ezgdal / gdal シェル補完 (bash 4+)。再生成は scripts/completions/tools/compile.py

if [ -z "$BASH_VERSION" ] || [ "${BASH_VERSINFO[0]:-0}" -lt 4 ]; then
    return 0 2>/dev/null || exit 0
fi

declare -A __EZGDAL_SUBS
declare -A __EZGDAL_OPTS

__EZGDAL_SUBS[gdal]='dataset driver mdim pipeline raster vector vsi'
__EZGDAL_OPTS[gdal]=--drivers
__EZGDAL_SUBS[gdal/dataset]='copy delete identify rename'
__EZGDAL_OPTS[gdal/dataset/copy]='--source --destination --overwrite --format'
__EZGDAL_OPTS[gdal/dataset/delete]='--filename --format'
__EZGDAL_OPTS[gdal/dataset/identify]='--filename --output-format --recursive --force-recursive --report-failures'
__EZGDAL_OPTS[gdal/dataset/rename]='--source --destination --overwrite --format'
__EZGDAL_SUBS[gdal/driver]='gpkg gti openfilegdb pdf'
__EZGDAL_SUBS[gdal/driver/gpkg]=repack
__EZGDAL_OPTS[gdal/driver/gpkg/repack]=--dataset
__EZGDAL_SUBS[gdal/driver/gti]=create
__EZGDAL_OPTS[gdal/driver/gti/create]='--input --output-format --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --output-layer --recursive --filename-filter --min-pixel-size --max-pixel-size --location-name --absolute-path --dst-crs --metadata --skip-errors --xml-filename --resolution --bbox --output-data-type --band-count --nodata --color-interpretation --mask --fetch-metadata --output'
__EZGDAL_SUBS[gdal/driver/openfilegdb]=repack
__EZGDAL_OPTS[gdal/driver/openfilegdb/repack]=--dataset
__EZGDAL_SUBS[gdal/driver/pdf]=list-layers
__EZGDAL_OPTS[gdal/driver/pdf/list-layers]='--input --output-format'
__EZGDAL_SUBS[gdal/mdim]='convert info mosaic'
__EZGDAL_OPTS[gdal/mdim]=--drivers
__EZGDAL_OPTS[gdal/mdim/convert]='--output-format --open-option --input-format --input --creation-option --overwrite --array --array-option --group --subset --scale-axes --strict --output'
__EZGDAL_OPTS[gdal/mdim/info]='--open-option --input-format --input --detailed --array --limit --array-option --stats'
__EZGDAL_OPTS[gdal/mdim/mosaic]='--output-format --open-option --input-format --input --creation-option --overwrite --array --output'
__EZGDAL_OPTS[gdal/pipeline]='--input --output-format --pipeline --output'
__EZGDAL_SUBS[gdal/raster]='as-features aspect blend calc clean-collar clip color-map compare contour convert create edit fill-nodata footprint hillshade index info mosaic neighbors nodata-to-alpha overview pansharpen pipeline pixel-info polygonize proximity reclassify reproject resize rgb-to-palette roughness scale select set-type sieve slope stack tile tpi tri unscale update viewshed zonal-stats'
__EZGDAL_OPTS[gdal/raster]=--drivers
__EZGDAL_OPTS[gdal/raster/as-features]='--input-format --open-option --input --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --output-layer --band --geometry-type --skip-nodata --include-xy --include-row-col --output'
__EZGDAL_OPTS[gdal/raster/aspect]='--input-format --open-option --input --output-format --creation-option --overwrite --append --band --convention --gradient-alg --zero-for-flat --no-edges --output'
__EZGDAL_OPTS[gdal/raster/blend]='--input-format --open-option --input --overlay --output-format --creation-option --overwrite --append --operator --opacity --output'
__EZGDAL_OPTS[gdal/raster/calc]='--input-format --open-option --input --output-format --creation-option --overwrite --append --output-data-type --no-check-srs --no-check-extent --propagate-nodata --calc --dialect --flatten --nodata --output'
__EZGDAL_OPTS[gdal/raster/clean-collar]='--open-option --input-format --input --output-format --creation-option --overwrite --update --color --color-threshold --pixel-distance --add-alpha --add-mask --algorithm --output'
__EZGDAL_OPTS[gdal/raster/clip]='--input-format --open-option --input --output-format --creation-option --overwrite --append --bbox --bbox-crs --window --geometry --geometry-crs --like --like-sql --like-layer --like-where --only-bbox --allow-bbox-outside-source --add-alpha --output'
__EZGDAL_OPTS[gdal/raster/color-map]='--input-format --open-option --input --output-format --creation-option --overwrite --append --band --color-map --add-alpha --color-selection --output'
__EZGDAL_OPTS[gdal/raster/compare]='--reference --input-format --open-option --input --skip-all-optional --skip-binary --skip-crs --skip-geotransform --skip-overview --skip-metadata --skip-rpc --skip-geolocation --skip-subdataset'
__EZGDAL_OPTS[gdal/raster/contour]='--input-format --open-option --input --output-format --output-open-option --creation-option --layer-creation-option --overwrite --output-layer --band --elevation-name --min-name --max-name --3d --src-nodata --interval --levels --exp-base --offset --polygonize --group-transactions --output'
__EZGDAL_OPTS[gdal/raster/convert]='--input-format --open-option --input --output-format --creation-option --overwrite --append --output'
__EZGDAL_OPTS[gdal/raster/create]='--output-format --open-option --input-format --input --creation-option --overwrite --append --size --band-count --output-data-type --nodata --burn --crs --bbox --metadata --copy-metadata --copy-overviews --output'
__EZGDAL_OPTS[gdal/raster/edit]='--dataset --open-option --auxiliary --crs --bbox --nodata --metadata --unset-metadata --unset-metadata-domain --gcp --stats --approx-stats --hist'
__EZGDAL_OPTS[gdal/raster/fill-nodata]='--input-format --open-option --input --output-format --creation-option --overwrite --append --band --max-distance --smoothing-iterations --mask --strategy --output'
__EZGDAL_OPTS[gdal/raster/footprint]='--open-option --input-format --input --output-format --creation-option --layer-creation-option --append --overwrite --output-layer --band --combine-bands --overview --src-nodata --coordinate-system --dst-crs --split-multipolygons --convex-hull --densify-distance --simplify-tolerance --min-ring-area --max-points --location-field --no-location-field --absolute-path --output'
__EZGDAL_OPTS[gdal/raster/hillshade]='--input-format --open-option --input --output-format --creation-option --overwrite --append --band --zfactor --xscale --yscale --azimuth --altitude --gradient-alg --variant --no-edges --output'
__EZGDAL_OPTS[gdal/raster/index]='--input --output-format --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --output-layer --recursive --filename-filter --min-pixel-size --max-pixel-size --location-name --absolute-path --dst-crs --metadata --skip-errors --source-crs-field-name --source-crs-format --output'
__EZGDAL_OPTS[gdal/raster/info]='--input-format --open-option --input --output-format --min-max --stats --approx-stats --hist --no-gcp --no-md --no-ct --no-fl --checksum --list-mdd --metadata-domain --no-nodata --no-mask --subdataset'
__EZGDAL_OPTS[gdal/raster/mosaic]='--input-format --open-option --input --output-format --creation-option --overwrite --append --band --absolute-path --resolution --bbox --target-aligned-pixels --src-nodata --dst-nodata --hide-nodata --add-alpha --pixel-function --pixel-function-arg --output'
__EZGDAL_OPTS[gdal/raster/neighbors]='--input-format --open-option --input --output-format --creation-option --overwrite --append --band --method --size --kernel --output-data-type --nodata --output'
__EZGDAL_OPTS[gdal/raster/nodata-to-alpha]='--input-format --open-option --input --output-format --creation-option --overwrite --append --nodata --output'
__EZGDAL_SUBS[gdal/raster/overview]='add delete refresh'
__EZGDAL_OPTS[gdal/raster/overview/add]='--open-option --input --overview-src --external --resampling --levels --min-size --creation-option'
__EZGDAL_OPTS[gdal/raster/overview/delete]='--open-option --dataset --external'
__EZGDAL_OPTS[gdal/raster/overview/refresh]='--open-option --dataset --external --resampling --levels --bbox --like --use-source-timestamp'
__EZGDAL_OPTS[gdal/raster/pansharpen]='--input-format --open-option --input --spectral --output-format --creation-option --overwrite --append --resampling --weights --nodata --bit-depth --spatial-extent-adjustment --num-threads --output'
__EZGDAL_OPTS[gdal/raster/pipeline]='--input-format --open-option --input --pipeline --output-format --creation-option --overwrite --append --output'
__EZGDAL_OPTS[gdal/raster/pixel-info]='--output-format --open-option --input-format --input --band --overview --position --position-crs --resampling'
__EZGDAL_OPTS[gdal/raster/polygonize]='--input-format --open-option --input --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --output-layer --band --attribute-name --connect-diagonal-pixels --output'
__EZGDAL_OPTS[gdal/raster/proximity]='--input-format --open-option --input --output-format --creation-option --overwrite --append --output-data-type --band --target-values --distance-units --max-distance --fixed-value --nodata --output'
__EZGDAL_OPTS[gdal/raster/reclassify]='--input-format --open-option --input --output-format --creation-option --overwrite --append --mapping --output-data-type --output'
__EZGDAL_OPTS[gdal/raster/reproject]='--input-format --open-option --input --output-format --creation-option --overwrite --append --src-crs --dst-crs --resampling --resolution --size --bbox --bbox-crs --target-aligned-pixels --src-nodata --dst-nodata --add-alpha --warp-option --transform-option --error-threshold --num-threads --output'
__EZGDAL_OPTS[gdal/raster/resize]='--input-format --open-option --input --output-format --creation-option --overwrite --append --resolution --size --resampling --output'
__EZGDAL_OPTS[gdal/raster/rgb-to-palette]='--input-format --open-option --input --output-format --creation-option --overwrite --append --color-count --color-map --output'
__EZGDAL_OPTS[gdal/raster/roughness]='--input-format --open-option --input --output-format --creation-option --overwrite --append --band --no-edges --output'
__EZGDAL_OPTS[gdal/raster/scale]='--input-format --open-option --input --output-format --creation-option --overwrite --append --output-data-type --band --src-min --src-max --dst-min --dst-max --exponent --no-clip --output'
__EZGDAL_OPTS[gdal/raster/select]='--input-format --open-option --input --output-format --creation-option --overwrite --append --band --mask --output'
__EZGDAL_OPTS[gdal/raster/set-type]='--input-format --open-option --input --output-format --creation-option --overwrite --append --output-data-type --output'
__EZGDAL_OPTS[gdal/raster/sieve]='--input-format --open-option --input --output-format --creation-option --overwrite --append --mask --band --size-threshold --connect-diagonal-pixels --output'
__EZGDAL_OPTS[gdal/raster/slope]='--input-format --open-option --input --output-format --creation-option --overwrite --append --band --unit --xscale --yscale --gradient-alg --no-edges --output'
__EZGDAL_OPTS[gdal/raster/stack]='--input-format --open-option --input --output-format --creation-option --overwrite --append --band --absolute-path --resolution --bbox --target-aligned-pixels --src-nodata --dst-nodata --hide-nodata --output'
__EZGDAL_OPTS[gdal/raster/tile]='--input-format --open-option --input --output-format --creation-option --output --tiling-scheme --min-zoom --max-zoom --min-x --max-x --min-y --max-y --no-intersection-ok --resampling --overview-resampling --convention --tile-size --add-alpha --no-alpha --dst-nodata --skip-blank --metadata --copy-src-metadata --aux-xml --kml --resume --num-threads --parallel-method --excluded-values --excluded-values-pct-threshold --nodata-values-pct-threshold --webviewer --url --title --copyright --mapml-template'
__EZGDAL_OPTS[gdal/raster/tpi]='--input-format --open-option --input --output-format --creation-option --overwrite --append --band --no-edges --output'
__EZGDAL_OPTS[gdal/raster/tri]='--input-format --open-option --input --output-format --creation-option --overwrite --append --band --algorithm --no-edges --output'
__EZGDAL_OPTS[gdal/raster/unscale]='--input-format --open-option --input --output-format --creation-option --overwrite --append --output-data-type --output'
__EZGDAL_OPTS[gdal/raster/update]='--open-option --input-format --input --geometry --geometry-crs --resampling --warp-option --transform-option --error-threshold --no-update-overviews --output'
__EZGDAL_OPTS[gdal/raster/viewshed]='--input-format --open-option --input --output-format --creation-option --overwrite --append --position --height --target-height --mode --max-distance --min-distance --start-angle --end-angle --high-pitch --low-pitch --curvature-coefficient --band --visible-value --invisible-value --out-of-range-value --dst-nodata --observer-spacing --num-threads --output'
__EZGDAL_OPTS[gdal/raster/zonal-stats]='--input-format --open-option --input --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --band --zones --zones-band --zones-layer --weights --weights-band --pixels --stat --include-field --strategy --chunk-size --output'
__EZGDAL_SUBS[gdal/vector]='buffer check-coverage check-geometry clean-coverage clip concat convert edit explode-collections filter grid index info layer-algebra make-point make-valid partition pipeline rasterize reproject segmentize select set-field-type set-geom-type simplify simplify-coverage sql swap-xy'
__EZGDAL_OPTS[gdal/vector]=--drivers
__EZGDAL_OPTS[gdal/vector/buffer]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --active-geometry --distance --endcap-style --join-style --mitre-limit --quadrant-segments --side --output'
__EZGDAL_OPTS[gdal/vector/check-coverage]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --include-valid --geometry-field --maximum-gap-width --output'
__EZGDAL_OPTS[gdal/vector/check-geometry]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --include-field --include-valid --geometry-field --output'
__EZGDAL_OPTS[gdal/vector/clean-coverage]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --snapping-distance --merge-strategy --maximum-gap-width --output'
__EZGDAL_OPTS[gdal/vector/clip]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --bbox --bbox-crs --geometry --geometry-crs --like --like-sql --like-layer --like-where --output'
__EZGDAL_OPTS[gdal/vector/concat]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --skip-errors --mode --output-layer --source-layer-field-name --source-layer-field-content --field-strategy --src-crs --dst-crs --output'
__EZGDAL_OPTS[gdal/vector/convert]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --output'
__EZGDAL_OPTS[gdal/vector/edit]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --geometry-type --crs --metadata --unset-metadata --layer-metadata --unset-layer-metadata --unset-fid --output'
__EZGDAL_OPTS[gdal/vector/explode-collections]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --active-geometry --geometry-type --skip-on-type-mismatch --output'
__EZGDAL_OPTS[gdal/vector/filter]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --bbox --where --output'
__EZGDAL_SUBS[gdal/vector/grid]='average average-distance average-distance-points count invdist invdistnn linear maximum minimum nearest range'
__EZGDAL_OPTS[gdal/vector/grid/average]='--output-format --open-option --input-format --input --creation-option --extent --resolution --size --output-data-type --crs --overwrite --input-layer --sql --bbox --zfield --zoffset --zmultiply --radius --radius1 --radius2 --angle --min-points --max-points --min-points-per-quadrant --max-points-per-quadrant --nodata --output'
__EZGDAL_OPTS[gdal/vector/grid/average-distance]='--output-format --open-option --input-format --input --creation-option --extent --resolution --size --output-data-type --crs --overwrite --input-layer --sql --bbox --zfield --zoffset --zmultiply --radius --radius1 --radius2 --angle --min-points --min-points-per-quadrant --max-points-per-quadrant --nodata --output'
__EZGDAL_OPTS[gdal/vector/grid/average-distance-points]='--output-format --open-option --input-format --input --creation-option --extent --resolution --size --output-data-type --crs --overwrite --input-layer --sql --bbox --zfield --zoffset --zmultiply --radius --radius1 --radius2 --angle --min-points --min-points-per-quadrant --max-points-per-quadrant --nodata --output'
__EZGDAL_OPTS[gdal/vector/grid/count]='--output-format --open-option --input-format --input --creation-option --extent --resolution --size --output-data-type --crs --overwrite --input-layer --sql --bbox --zfield --zoffset --zmultiply --radius --radius1 --radius2 --angle --min-points --min-points-per-quadrant --max-points-per-quadrant --nodata --output'
__EZGDAL_OPTS[gdal/vector/grid/invdist]='--output-format --open-option --input-format --input --creation-option --extent --resolution --size --output-data-type --crs --overwrite --input-layer --sql --bbox --zfield --zoffset --zmultiply --power --smoothing --radius --radius1 --radius2 --angle --min-points --max-points --min-points-per-quadrant --max-points-per-quadrant --nodata --output'
__EZGDAL_OPTS[gdal/vector/grid/invdistnn]='--output-format --open-option --input-format --input --creation-option --extent --resolution --size --output-data-type --crs --overwrite --input-layer --sql --bbox --zfield --zoffset --zmultiply --power --smoothing --radius --min-points --max-points --min-points-per-quadrant --max-points-per-quadrant --nodata --output'
__EZGDAL_OPTS[gdal/vector/grid/linear]='--output-format --open-option --input-format --input --creation-option --extent --resolution --size --output-data-type --crs --overwrite --input-layer --sql --bbox --zfield --zoffset --zmultiply --radius --nodata --output'
__EZGDAL_OPTS[gdal/vector/grid/maximum]='--output-format --open-option --input-format --input --creation-option --extent --resolution --size --output-data-type --crs --overwrite --input-layer --sql --bbox --zfield --zoffset --zmultiply --radius --radius1 --radius2 --angle --min-points --min-points-per-quadrant --max-points-per-quadrant --nodata --output'
__EZGDAL_OPTS[gdal/vector/grid/minimum]='--output-format --open-option --input-format --input --creation-option --extent --resolution --size --output-data-type --crs --overwrite --input-layer --sql --bbox --zfield --zoffset --zmultiply --radius --radius1 --radius2 --angle --min-points --min-points-per-quadrant --max-points-per-quadrant --nodata --output'
__EZGDAL_OPTS[gdal/vector/grid/nearest]='--output-format --open-option --input-format --input --creation-option --extent --resolution --size --output-data-type --crs --overwrite --input-layer --sql --bbox --zfield --zoffset --zmultiply --radius --radius1 --radius2 --angle --nodata --output'
__EZGDAL_OPTS[gdal/vector/grid/range]='--output-format --open-option --input-format --input --creation-option --extent --resolution --size --output-data-type --crs --overwrite --input-layer --sql --bbox --zfield --zoffset --zmultiply --radius --radius1 --radius2 --angle --min-points --min-points-per-quadrant --max-points-per-quadrant --nodata --output'
__EZGDAL_OPTS[gdal/vector/index]='--input --output-format --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --output-layer --recursive --filename-filter --location-name --absolute-path --dst-crs --metadata --source-crs-field-name --source-crs-format --source-layer-name --source-layer-index --accept-different-crs --accept-different-schemas --dataset-name-only --output'
__EZGDAL_OPTS[gdal/vector/info]='--output-format --open-option --input-format --input --input-layer --features --summary --limit --sql --where --dialect --update'
__EZGDAL_OPTS[gdal/vector/layer-algebra]='--operation --output-format --open-option --input-format --input --method --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --input-layer --method-layer --output-layer --geometry-type --input-prefix --input-field --no-input-field --all-input-field --method-prefix --method-field --no-method-field --all-method-field --output'
__EZGDAL_OPTS[gdal/vector/make-point]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --x --y --z --m --dst-crs --output'
__EZGDAL_OPTS[gdal/vector/make-valid]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --active-geometry --method --keep-lower-dim --output'
__EZGDAL_OPTS[gdal/vector/partition]='--input-format --open-option --input --output --overwrite --append --output-format --creation-option --layer-creation-option --field --scheme --pattern --feature-limit --max-file-size --omit-partitioned-field --skip-errors'
__EZGDAL_OPTS[gdal/vector/pipeline]='--input-format --open-option --input --input-layer --pipeline --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --output'
__EZGDAL_OPTS[gdal/vector/rasterize]='--output-format --open-option --input-format --input --creation-option --overwrite --band --invert --all-touched --burn --attribute-name --3d --input-layer --where --sql --dialect --nodata --init --crs --transformer-option --extent --resolution --target-aligned-pixels --size --output-data-type --optimization --add --update --output'
__EZGDAL_OPTS[gdal/vector/reproject]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --src-crs --dst-crs --output'
__EZGDAL_OPTS[gdal/vector/segmentize]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --active-geometry --max-length --output'
__EZGDAL_OPTS[gdal/vector/select]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --fields --exclude --ignore-missing-fields --output'
__EZGDAL_OPTS[gdal/vector/set-field-type]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --field-name --src-field-type --field-type --output'
__EZGDAL_OPTS[gdal/vector/set-geom-type]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --active-geometry --layer-only --feature-only --geometry-type --multi --single --linear --curve --dim --skip --output'
__EZGDAL_OPTS[gdal/vector/simplify]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --active-geometry --tolerance --output'
__EZGDAL_OPTS[gdal/vector/simplify-coverage]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --tolerance --preserve-boundary --output'
__EZGDAL_OPTS[gdal/vector/sql]='--input-format --open-option --input --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --skip-errors --sql --output-layer --dialect --output'
__EZGDAL_OPTS[gdal/vector/swap-xy]='--input-format --open-option --input --input-layer --output-format --output-open-option --creation-option --layer-creation-option --overwrite --update --overwrite-layer --append --upsert --output-layer --skip-errors --active-layer --active-geometry --output'
__EZGDAL_SUBS[gdal/vsi]='copy delete list move sozip sync'
__EZGDAL_OPTS[gdal/vsi/copy]='--source --destination --recursive --skip-errors'
__EZGDAL_OPTS[gdal/vsi/delete]='--filename --recursive'
__EZGDAL_OPTS[gdal/vsi/list]='--filename --output-format --long-listing --recursive --depth --absolute-path --tree'
__EZGDAL_OPTS[gdal/vsi/move]='--source --destination'
__EZGDAL_SUBS[gdal/vsi/sozip]='create list optimize validate'
__EZGDAL_OPTS[gdal/vsi/sozip/create]='--input --output --overwrite --recursive --no-paths --enable-sozip --sozip-chunk-size --sozip-min-file-size --content-type'
__EZGDAL_OPTS[gdal/vsi/sozip/list]=--input
__EZGDAL_OPTS[gdal/vsi/sozip/optimize]='--input --output --overwrite --enable-sozip --sozip-chunk-size --sozip-min-file-size'
__EZGDAL_OPTS[gdal/vsi/sozip/validate]=--input
__EZGDAL_OPTS[gdal/vsi/sync]='--source --destination --recursive --strategy --num-threads'


_ezgdal_complete() {
    local cur prev words cword
    if declare -f _init_completion >/dev/null 2>&1; then
        _init_completion -n : || return
    else
        cur="${COMP_WORDS[COMP_CWORD]}"
        prev="${COMP_WORDS[COMP_CWORD-1]}"
        words=("${COMP_WORDS[@]}")
        cword=$COMP_CWORD
    fi

    local path="gdal"
    local i=1
    while (( i < cword )); do
        local w="${words[i]}"
        if [[ "$w" == -* ]]; then break; fi
        local trial="${path}/${w}"
        if [[ -n "${__EZGDAL_SUBS[$trial]:-}" || -n "${__EZGDAL_OPTS[$trial]:-}" ]]; then
            path="$trial"
            ((i++))
        else
            break
        fi
    done

    local cands
    if [[ "$cur" == -* ]]; then
        cands="${__EZGDAL_OPTS[$path]:-}"
    else
        cands="${__EZGDAL_SUBS[$path]:-}"
    fi
    COMPREPLY=( $(compgen -W "$cands" -- "$cur") )
    return 0
}
complete -F _ezgdal_complete ezgdal
complete -F _ezgdal_complete gdal

