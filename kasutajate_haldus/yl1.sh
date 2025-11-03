#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Kasutusjuhend: $0 kasutajanimi"
else
	kasutajanimi=$1
	sudo useradd $kasutajanimi -m -s /bin/bash
	kasu_tulemus=$?
	if [ $kasu_tulemus -eq 0 ]; then
		echo "Kasutaja nimega $kasutajanimi on lisatud süsteemi"
		cat /etc/passwd | grep $kasutajanimi
		ls -la /home/$kasutajanimi
	else
		echo "Probleem kasutaja $kasutajanimi lisamisega"
		echo "Probleemi kood on $kasu_tulemus"
	fi
fi
