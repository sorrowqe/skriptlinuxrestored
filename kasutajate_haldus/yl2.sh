#!/bin/bash
# kasutajate lisamise skript failist

if [ $# -ne 1 ]; then
    echo "Kasutusjuhend: $0 failinimi"
    exit 1
fi

failinimi="$1"

# Kontrollime, kas fail on olemas ja loetav
if [ -r "$failinimi" ]; then
    echo "Fail korras: $failinimi"

    while read -r nimi; do
        # Kontrollime, et rida ei oleks tühi
        if [ -n "$nimi" ]; then
            echo "Lisame kasutaja: $nimi"
            sh yl1 "$nimi"
        fi
    done < "$failinimi"

else
    echo "Probleem failiga: $failinimi"
    exit 2
fi
