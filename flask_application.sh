#!/bin/bash

REPOSITORIO="https://github.com/pablosanchezp/ProyectoFUSO.git"
DIRECTORIO_VENV="/home/alumnoimat/venv_proyectofuso"
MAIN_FILE="/home/alumnoimat/ProyectoFUSO/main.py"

if [ ! -d "ProyectoFUSO" ]; then
echo "Clonando repositorio"
git clone "$REPOSITORIO"
else
echo "Repositorio ya existe, se omite el clon"
fi

if [ ! -d "$DIRECTORIO_VENV" ]; then
echo "Creando entorno virtual"
python3 -m venv "$DIRECTORIO_VENV"
else
echo "El entorno virtual \"$DIRECTORIO_VENV\" ya existe"
fi

echo "Activando entorno virtual"
source "$DIRECTORIO_VENV"/bin/activate

echo "Instalando dependencias desde requirements"
python3 -m pip install --upgrade pip
python3 -m pip install -r python_requirements.txt

echo "Ejecutando la aplicación de Flask"
python3 "$MAIN_FILE"
