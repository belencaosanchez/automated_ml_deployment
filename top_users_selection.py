import sys
import os

input_file = sys.argv[sys.argv.index("--input_file") + 1]
top_n = int(sys.argv[sys.argv.index("--top") + 1])
output_file = sys.argv[sys.argv.index("--output_file") + 1]


visitas = {}

with open(input_file, "r") as f:
    for linea in f:
        partes = linea.strip().split()
        if len(partes) >= 1:
            usuario = partes[0]
            visitas[usuario] = visitas.get(usuario, 0) + 1


ordenados = sorted(visitas.items(), key=lambda x: x[1], reverse=True)[:top_n]


with open(output_file, "w") as out:
    for usuario, conteo in ordenados:
        out.write(f"{usuario} {conteo}\n")

print(f"Top {top_n} usuarios guardado en: {output_file}")