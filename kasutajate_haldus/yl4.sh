#!/bin/bash

# Kontrollime parameetreid
if [ $# -ne 2 ]; then
    echo "Kasutusjuhend: $0 kasutajad_fail paroolid_fail"
    exit 1
fi

kasutajad_fail=$1
paroolid_fail=$2

# Faili olemasolu kontroll
if [ ! -f "$kasutajad_fail" ] || [ ! -r "$kasutajad_fail" ]; then
    echo "Probleem failiga $kasutajad_fail"
    exit 2
fi

if [ ! -f "$paroolid_fail" ] || [ ! -r "$paroolid_fail" ]; then
    echo "Probleem failiga $paroolid_fail"
    exit 3
fi

# Loome kasutajad
paste "$kasutajad_fail" "$paroolid_fail" | while IFS=$'\t' read -r kasutajanimi parool; do
    if [ -n "$kasutajanimi" ]; then
        echo "Loon kasutaja: $kasutajanimi"

        sudo useradd "$kasutajanimi" -m -s /bin/bash
        kasu_tulemus=$?

        if [ $kasu_tulemus -eq 0 ]; then
            echo "$kasutajanimi:$parool" | sudo chpasswd
            echo "Kasutaja $kasutajanimi loodud koos parooliga."
        else
            echo "Probleem kasutaja $kasutajanimi loomisel (kood $kasu_tulemus)"
        fi
    fi
done
