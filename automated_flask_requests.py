import requests

# Cambiar URL por la IP de la máquina donde se ejecuta
URL = "http://10.120.134.84:5000/train"

dataset = "iris"
model = "RandomForest"

for i in range(1, 10):
    train_size = round(i / 10, 1)
    test_size = round(1 - train_size,1)

    # Diccionario de datos que se envía al servidor
    dictionary = {
        "dataset": dataset,
        "model": model,
        "train_size": train_size,
        "test_size": test_size
    }

    print(f"Enviando petición para train={train_size} y test={test_size}")
    response = requests.post(URL, data=dictionary)

    # Comprobar que la petición es correcta
    if response.status_code == 200:
        print("Petición realizada correctamente")

        result_name = f"{dataset}Tr{train_size}Tst{test_size}.png"
        img_url = "http://10.120.134.84:5000/static/"+result_name

        img_data = requests.get(img_url)
        if img_data.status_code == 200:
            with open(result_name, "wb") as f:
                f.write(img_data.content)
            print(f"Imagen {result_name} descargada correctamente")
        else:
            print(f"No se pudo descargar la imagen {img_url}")
    else:
        print(f"No se ha podido realizar la petición {response.status_code}")
