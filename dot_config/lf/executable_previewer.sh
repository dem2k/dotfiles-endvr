#!/bin/sh

if [ "$lf_user_hex_view" = true ]; then
    hexdump -C "$1"
else
    cat "$1"
fi
