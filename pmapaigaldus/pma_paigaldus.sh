#!/bin/bash
# phpmyadmin paigaldusskript

# Kontrollime, mitu korda phpmyadmin on süsteemis märgitud kui "ok installed"
# ja salvestame tulemuse muutujasse PMA
PMA=$(dpkg-query -W -f='${Status}' phpmyadmin 2>/dev/null | grep -c "ok installed")

# Kui PMA muutuja väärtus võrdub 0-ga
if [ $PMA -eq 0 ]; then
    # siis phpmyadmin ei ole leitud
    # ja väljastame vastava teate ning paigaldame teenuse
    echo "Paigaldame phpmyadmini ja vajalikud lisad"
    apt install phpmyadmin -y
    echo "phpmyadmin on paigaldatud"

# Kui PMA muutuja väärtus võrdub 1-ga
elif [ $PMA -eq 1 ]; then
    # siis phpmyadmin on juba paigaldatud
    echo "phpmyadmin on juba paigaldatud"
fi

# Skripti lõpp
