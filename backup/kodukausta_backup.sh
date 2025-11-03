#!/bin/bash
# Aleksandr Skobioale
# Home kausta backupi tegemise skript

KODUKAUST="/home"
VARUKAUST="/home_bcp"

# Kuupäev failinimesse
KUUPAEV=$(date +%d.%m.%Y)

# Loome backup kausta, kui see puudub
if [ ! -d "$VARUKAUST" ]; then
    mkdir -p "$VARUKAUST"
fi

echo "Alustan kodukataloogide varundamist..."

# Käime kõik kasutajate kodukataloogid läbi
for kasutaja in "$KODUKAUST"/*; do
    if [ -d "$kasutaja" ]; then
        nimi=$(basename "$kasutaja")
        arhiiiv="${nimi}.${KUUPAEV}.tar.gz"

        echo "Backupin kasutaja: $nimi"
        tar -czf "$VARUKAUST/$arhiiiv" -C "$KODUKAUST" "$nimi"
    fi
done

echo "Backupimine lõpetatud. Failid asuvad: $VARUKAUST"
