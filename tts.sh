#!/usr/bin/env bash
#
# Skrypt dokonuje zamiany tekstu na postać audio za pomocą oprogramowaia
# do syntezy mowy o nazwie RHVoice
# Aby móc uruchamiać ten skrypt należy wpierw dokonać instalacji:
#	sudo apt install rhvoice rhvoice-polish lame
#
# autor: grok.com
# data: 2-03-2026

set -euo pipefail

if [ $# -lt 1 ]; then
    echo "Użycie: $0 plik.txt [wav|mp3] [bitrate] [głos] [tempo] [pitch] [volume]"
    echo "  domyślne: wav | 64 | Natan | 0.85 | 1.0 | 0.9"
    echo "  tempo:    0.4–1.2   (niżej = wolniej)"
    echo "  pitch:    0.7–1.3   (niżej = głębszy głos)"
    echo "  volume:   0.5–1.0   (niżej = ciszej)"
    exit 1
fi

input_file="$1"
base_name="${input_file%.*}"
format="${2:-mp3}"
bitrate="${3:-64}"
voice="${4:-Cezary}"
# rate="${5:-0.85}"       # ← Twoje 0.0 też tu wpiszesz
rate="${5:-0}"       # ← Twoje 0.0 też tu wpiszesz
pitch="${6:-0}"
volume="${7:-0.9}"
text=$(<"$input_file")

output_file="${base_name}.${format}"

echo "Plik wejściowy:  $input_file"
echo "Głos:            $voice"
echo "Tempo:           × $rate"
echo "Pitch:           × $pitch"
echo "Volume:          $volume"
echo "Format:          ${format^^}"
[ "$format" = "mp3" ] && echo "Bitrate:         ${bitrate} kbps"
echo "Plik wyjściowy:  $output_file"

# Główna linia syntezy – dodajemy -r -p -v
if [ "$format" = "wav" ]; then
    RHVoice-client -s "$voice" -r "$rate" -p "$pitch" -v "$volume" <<< "$text" > "$output_file"
else
    RHVoice-client -s "$voice" -r "$rate" -p "$pitch" -v "$volume" <<< "$text" |
        lame - -b "$bitrate" --resample 22.05 -m m "$output_file"
fi

echo -e "\nGotowe → $output_file"

celluloid $output_file & disown
