#!/bin/sh
tmp="$(mktemp --suffix=.png)"
grim -g "$(slurp)" "$tmp" || exit 1
dir="$(find "$HOME" -maxdepth 2 -type d | rofi -dmenu -p 'Save to')" || { rm "$tmp"; exit 1; }
mkdir -p "$dir"
file="$dir/shot_crop_$(date +%s).png"
mv "$tmp" "$file"
notify-send -i "$file" "Screenshot" "Saved to $file"


