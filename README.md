# Automatización y Despliegue de un Sistema de Machine Learning

Este proyecto aborda la automatización completa de la instalación, despliegue y
ejecución de un sistema de machine learning en una máquina virtual con Linux Alpine.

El objetivo principal es automatizar, mediante scripts Bash y Python, la instalación
de dependencias del sistema, la clonación de repositorios, la creación de entornos
virtuales, la ejecución de una aplicación Flask, la descarga y procesamiento de datos,
la generación de estadísticas y mapas, y la realización de peticiones HTTP.

---

## Descripción General

El sistema se ejecuta sobre una máquina virtual con Alpine Linux y hace uso de
herramientas vistas a lo largo de la asignatura, como:

- Scripts Bash
- Entornos virtuales de Python
- Automatización de instalaciones
- Servicios web con Flask
- Procesamiento y análisis de datos
- Monitorización del rendimiento del sistema

El flujo de trabajo permite desplegar un proyecto completo de forma automática y
estructurada.

---

## Instalación de Dependencias del Sistema

La instalación de los paquetes necesarios del sistema se realiza mediante un script
Bash que utiliza el gestor de paquetes `apk` de Alpine Linux.

Este script instala Python, Git, Bash, compiladores y librerías necesarias para la
ejecución del sistema.

Archivo:
- `install_system_dependencies.sh`

---

## Despliegue del Proyecto

El despliegue del sistema se realiza mediante un script Bash que automatiza:

- La clonación de un repositorio Git
- La creación y activación de un entorno virtual de Python
- La instalación de las dependencias del proyecto
- La ejecución de una aplicación Flask

Este proceso permite poner en marcha el sistema con una única ejecución.

Archivo:
- `deploy_flask_application.sh`

---

## Descarga y Procesamiento de Datos

Se desarrolla un script Bash que automatiza la descarga de un conjunto de datos
(Gowalla), su descompresión y el procesamiento de los ficheros correspondientes
a distintas ciudades.

El script calcula estadísticas básicas por ciudad tanto en Bash como en Python,
filtra los datos y genera mapas globales e individuales que pueden ser visualizados
desde la aplicación Flask.

Archivo:
- `download_and_process_gowalla_data.sh`

---

## Aplicación Flask

La aplicación Flask proporciona una interfaz web desde la que se pueden ejecutar
distintas funcionalidades, entre ellas:

- Entrenamiento y evaluación de modelos
- Obtención de estadísticas de datasets
- Análisis exploratorio de datos
- Generación de datasets sintéticos
- Comparación de ejecución secuencial y paralela

Los resultados se presentan mediante gráficos e interfaces HTML.

---

## Automatización de Peticiones HTTP

Se desarrolla un script en Python que automatiza peticiones GET y POST al servicio
`/train` de la aplicación Flask, utilizando distintos valores de partición de datos
(train/test) y descargando automáticamente las imágenes generadas.

Archivo:
- `automated_flask_requests.py`

---

## Análisis de Datos

El proyecto incluye scripts en Python para el análisis de los datos descargados,
cálculo de estadísticas por ciudad y selección del top de usuarios con mayor número
de visitas.

Archivos:
- `gowalla_statistics.py`
- `top_users_selection.py`

---

## Procesamiento y Rendimiento

Se analiza el rendimiento del sistema comparando la ejecución secuencial y paralela
de tareas computacionalmente costosas, observando el uso de CPU y memoria mediante
herramientas del sistema como `htop`.

Los resultados muestran un mejor aprovechamiento de los núcleos del sistema al
utilizar procesamiento en paralelo.

---

## Tecnologías Utilizadas

- Bash
- Python
- Flask
- Linux Alpine
- scikit-learn
- Pandas
- NumPy
- Matplotlib
- Seaborn

---

## Conclusiones

El proyecto permite automatizar de forma completa el proceso de instalación,
despliegue y ejecución de un sistema de machine learning en un entorno Linux.

Se integran scripts Bash, entornos virtuales de Python y una aplicación Flask
funcional, automatizando la generación de resultados, análisis de datos y evaluación
del rendimiento del sistema.
