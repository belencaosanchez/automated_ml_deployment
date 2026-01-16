#!/bin/sh

URL="https://drive.google.com/uc?export=download&id=1PHWBGuwDHw4ZEIlCbgMTiEUrG8FmlJK2"
PATH_MAIN_PYTHON="ProyectoFUSO/generate_maps.py"
PATH_GOWALLA_FILES="DatasetsGowalla/"
PATH_OUTPUT_GOWALLA_FILES="ProyectoFUSO/templates/html_files/"
ARCHIVO_ZIP="DatasetsGowalla.zip"
PATH_OUTPUT_HTML="ProyectoFUSO/templates/html_files/"
VENV_PATH="/home/alumnoimat/venv_proyectofuso"
SCRIPT_PY_ESTADISTICAS="estadisticas_gowalla.py"
PATH_INDIVIDUAL_MAPS="ProyectoFUSO/generate_individual_maps.py"
MAIN_FILE="/home/alumnoimat/ProyectoFUSO/main.py"


echo "DESCARGANDO ARCHIVO ZIP DE GOWALLA"

if [ ! -f "$ARCHIVO_ZIP" ]; then
    wget --no-check-certificate -O "$ARCHIVO_ZIP" "$URL"
else
    echo "El archivo $ARCHIVO_ZIP ya existe. Se omite la descarga."
fi
unzip -l DatasetsGowalla.zip

echo "DESCOMPRIMIENDO ARCHIVO ZIP"
if [ ! -d "$PATH_GOWALLA_FILES" ]; then
    unzip -o "$ARCHIVO_ZIP"
else
    echo "El directorio $PATH_GOWALLA_FILES ya existe. Se omite la descompresión."
fi

echo ""
echo "PROCESANDO FICHEROS"
mkdir -p FilteredCities
> ALL_LOCATIONS.txt 
echo ""

for f in "$PATH_GOWALLA_FILES"/*.txt; do
    ciudad=$(basename "$f" .txt)

    awk '{print $3, $4, $5}' "$f" >> ALL_LOCATIONS.txt
    awk '{print $1, $2, $5}' "$f" > "FilteredCities/${ciudad}_filtered.txt"

    # Estadísticas simples
    echo "Estadísticas para ${ciudad}.txt"
    usuarios=$(awk '{print $1}' "$f" | sort -u | wc -l)
    lugares=$(awk '{print $5}' "$f" | sort -u | wc -l)
    total=$(wc -l < "$f")
    julio=$(grep "2010-07" "$f" | wc -l)
    agosto=$(grep "2010-08" "$f" | wc -l)

    echo "Numero de usuarios distintos: $usuarios"
    echo "Numero de localizaciones distintas: $lugares"
    echo "Numero de filas completas: $total"
    echo "Numero de check-ins en 2010-07: $julio"
    echo "Numero de check-ins en 2010-08: $agosto"

    echo "Estadísticas para ${ciudad}.txt desde Python"
    python3 "$SCRIPT_PY_ESTADISTICAS" "$f"
echo ""
done

echo "ACTIVANDO ENTORNO VIRTUAL Y GENERANDO MAPAS"
source "$VENV_PATH"/bin/activate

mkdir -p "$PATH_OUTPUT_GOWALLA_FILES"

for ciudad in ElPaso Glasgow Manchester WashingtonDC; do
    input_file="${PATH_GOWALLA_FILES}${ciudad}Gowalla.txt"
    output_file="${PATH_OUTPUT_GOWALLA_FILES}${ciudad}GowallaMap"

    echo "Generando mapa para $ciudad"
    python3 "$PATH_MAIN_PYTHON" --input_file "$input_file" --city_name "$ciudad" --output_html "$output_file"
done

echo ""
echo "GENERANDO MAPAS INDIVIDUALES"

echo "Generando mapa individual para el usuario 106483 en la ciudad de El Paso"
python3 "$PATH_INDIVIDUAL_MAPS" --input_file "$PATH_GOWALLA_FILES"ElPasoGowalla.txt --city_name ElPaso --user_id 106483 --output_html "$PATH_OUTPUT_GOWALLA_FILES"/ElPasoUser106483Map.html
echo "Generando mapa individual para el usuario 152639 en la ciudad de Glasgow"
python3 "$PATH_INDIVIDUAL_MAPS" --input_file "$PATH_GOWALLA_FILES"GlasgowGowalla.txt --city_name Glasgow --user_id 152639 --output_html "$PATH_OUTPUT_GOWALLA_FILES"/GlasgowUser152639Map.html
echo "Generando mapa individual para el usuario 1069 en la ciudad de Manchester"
python3 "$PATH_INDIVIDUAL_MAPS" --input_file "$PATH_GOWALLA_FILES"ManchesterGowalla.txt --city_name Manchester --user_id 1069 --output_html "$PATH_OUTPUT_GOWALLA_FILES"/ManchesterUser1069Map.html
echo "Generando mapa individual para el usuario 1351 en la ciudad de WashingtonDC"
python3 "$PATH_INDIVIDUAL_MAPS" --input_file "$PATH_GOWALLA_FILES"WashingtonDCGowalla.txt --city_name WashingtonDC --user_id 1351 --output_html "$PATH_OUTPUT_GOWALLA_FILES"/WashingtonDCUser1351Map.html


echo ""
echo "CALCULANDO TOP 5 USUARIOS CON MÁS VISITAS"

for ciudad in ElPaso Glasgow Manchester WashingtonDC; do
echo ""
    echo "Procesando ciudad: $ciudad"

    input_file="FilteredCities/${ciudad}Gowalla_filtered.txt"
    out="${ciudad}Gowalla_top5.txt"

    python3 top_users_selection.py --input_file "$input_file" --top 5 --output_file "$out"

    while read -r usuario visitas; do
        echo "Generando mapa del usuario $usuario de la ciudad $ciudad"
        python3 "$PATH_INDIVIDUAL_MAPS" --input_file "$PATH_GOWALLA_FILES${ciudad}Gowalla.txt" --city_name "$ciudad" --user_id "$usuario" --output_html "$PATH_OUTPUT_GOWALLA_FILES/${ciudad}_${usuario}_Map.html"
    done < "$out"
done

echo ""
echo "Ejecutando la aplicación de Flask..."
python3 "$MAIN_FILE"

deactivate
