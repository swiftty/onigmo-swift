#!/usr/bin/env bash

set -e

SOURCE_DIR="Onigmo"
OUTPUT_DIR="Sources/COnigmo"

mkdir -p "$OUTPUT_DIR/include" "$OUTPUT_DIR/src"

pushd "$SOURCE_DIR"
./autogen.sh
./configure
popd

EXCLUDE_FILE_PREFIXES=("test" "cp949" "emacs_mule" "gb2312" "us_ascii" "onigmognu" "onigmoposix" "reggnu" "regposix" "regposerr")
EXCLUDE_DIR_NAMES=("test" "sample")

should_exclude() {
  local filepath="$1"
  local filename=$(basename "$filepath")
  local dirpath=$(dirname "$filepath")

  for prefix in "${EXCLUDE_FILE_PREFIXES[@]}"; do
    if [[ "$filename" == "$prefix"* ]]; then
      return 0
    fi
  done

  for dirname in "${EXCLUDE_DIR_NAMES[@]}"; do
    if [[ "$dirpath" == *"/$dirname/"* || "$dirpath" == "$dirname/"* || "$dirpath" == *"/$dirname" ]]; then
      return 0
    fi
  done

  return 1
}

move_files() {
  local ext="$1"
  local dest_dir="$2"
  find "$SOURCE_DIR" -type f -name "*.$ext" | while read file; do
    if should_exclude "$file"; then
      continue
    fi
    relative_path="${file#$SOURCE_DIR/}"
    target_path="$dest_dir/$relative_path"
    mkdir -p "$(dirname "$target_path")"
    cp "$file" "$target_path"
  done
}

move_files "h" "$OUTPUT_DIR/include"
move_files "kwd" "$OUTPUT_DIR/include"
move_files "c" "$OUTPUT_DIR/src"
cp -r "$OUTPUT_DIR/include/enc" "$OUTPUT_DIR/src"
rm -r "$OUTPUT_DIR/include/enc"

echo "✅ done!"
