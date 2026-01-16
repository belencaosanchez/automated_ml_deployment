#!/bin/bash

while read -r linea; do

if [ "$linea" != "libc-dev" ]; then
if apk list --installed | sed -E 's/-[0-9].*$//' | grep -qx "$linea"; then
echo "Paquete ya existente y, por tanto, no se instala"
else
apk add "$linea"
fi
else
apk add "$linea"
fi
done < system_requirements.txt
