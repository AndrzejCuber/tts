#!/usr/bin/env bash
set -x
xclip -out -selection clipboard | sed ':a; /-$/N; s/-\n//; ta' > /tmp/$$.txt
~/tts.sh /tmp/$$.txt wav 64 Cezary "0.5"
celluloid /tmp/$$.wav & disown

