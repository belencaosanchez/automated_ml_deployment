import sys
import os

def calcular_estadisticas(ruta_fichero: str) -> None:
    if not os.path.isfile(ruta_fichero):
        print(f"El fichero '{ruta_fichero}' no existe.")
        return

    usuarios = [] 
    lugares = []    
    total_filas = 0
    checkins_julio = 0
    checkins_agosto = 0

    with open(ruta_fichero, "r", encoding="utf-8") as f:
        for linea in f:
            linea = linea.strip()
            columnas = linea.split("\t")

            user_id = columnas[0]
            timestamp = columnas[1]
            place_id = columnas[4]

            total_filas += 1

            if user_id not in usuarios:
                usuarios.append(user_id)

            if place_id not in lugares:
                lugares.append(place_id)

            if "2010-07" in timestamp:
                checkins_julio += 1
            if "2010-08" in timestamp:
                checkins_agosto += 1

    nombre_ciudad = os.path.basename(ruta_fichero)

    print(f"Numero de usuarios distintos: {len(usuarios)}")
    print(f"Numero de localizaciones distintas: {len(lugares)}")
    print(f"Numero de filas completas: {total_filas}")
    print(f"Numero de check-ins en 2010-07: {checkins_julio}")
    print(f"Numero de check-ins en 2010-08: {checkins_agosto}")


def main():
    if len(sys.argv) != 2:
        print("Número de argumentos introducidos erróneo")
        sys.exit(1)

    ruta_fichero = sys.argv[1]
    calcular_estadisticas(ruta_fichero)


if __name__ == "__main__":
    main()

