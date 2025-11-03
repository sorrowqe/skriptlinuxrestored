#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Kasutusjuhend: $0 failinimi"
else
	failinimi=$1
	if [ -f $failinimi -a -r $failinimi ]; then
		echo "Fail on korras"
		for rida in $(cat $failinimi)
		do
			kasutajanimi=$(echo "$rida" | cut -f1 -d:)
			sh yl1 $kasutajanimi
			echo "$rida" | chpasswd
		done
	else
		echo "Probleem failiga $failinimi"
	fi
fi
