
# <h1 align=center> **Proyecto: Happiness** </h1>
                                            

<p align="center">
<img src="https://raw.githubusercontent.com/MatyTrova/PI-DataAnalytics/main/imgs/telecomunicaciones%201.png"  height=300>
</p>

--- 
## `Descripción`

En este proyecto, puse en práctica mis sólidas habilidades en Ciencia de Datos. Mi objetivo principal fue comprender las variables que influyen en la felicidad de los países y utilizar modelos de machine learning para predecir el valor de ingresos de cada país. Después de realizar una investigación exhaustiva, extraje los datos necesarios utilizando principalmente **Python**. Durante este proceso, utilicé técnicas de *Web Scraping* por primera vez en un proyecto y quedé encantado con su utilidad.

Después de la extracción de datos y su posterior unificación, obtuve un conjunto de datos muy completo sobre países. Este conjunto de datos incluye las siguientes variables:

+ country: Nombre del país.
+ score: Puntuación de felicidad.
+ gdpPerCapita: Producto interno bruto per cápita.
+ lifeExpectancy: Esperanza de vida.
+ freedom: Nivel de libertad.
+ trust: Percepción de corrupción.
+ generosity: Generosidad.
+ year: Año de la medición.
+ regionValue: Valor de la región.
+ incomeValue: Valor de ingresos.
+ population: Población del país.

A continuación, apliqué el proceso de Extracción, Transformación y Carga (*ETL*) utilizando **SQL**garantizando la calidad y consistencia de los datos. Una vez que los datos estaban limpios y listos para su análisis, desarrollé un modelo de machine learning para realizar predicciones del valor de ingresos (incomeValue) para cada país.

Finalmente, presenté el análisis de manera interactiva en la web utilizando **Streamlit**, brindando una experiencia intuitiva para explorar los resultados obtenidos, al cuál pueden acceder en el siguiente enlace.

(enlace)

Este proyecto me permitió fortalecer mis habilidades en Ciencia de Datos, aplicar técnicas avanzadas de machine learning y desarrollar una comprensión profunda de los factores que influyen en la felicidad mundial. Estoy orgulloso del impacto logrado y del conocimiento adquirido a lo largo de este desafío.


## `Estructura del repositorio`

- [README.md](./README.md): Archivo principal con información detallada del proyecto.

- [Datasets](./Datasets): Contiene los data sets utilizados en el proyecto.

- [Datasets_sql](./Datasets_sql): Contiene el conjunto de datos luego del ETL.

- [imgs](./imgs): Contiene las imágenes del proyecto.

- [pages](./pages): Contiene los archivos.py que conforman las páginas en Streamlit.

- [Extracción.ipynb](./Extracción.ipynb): Notebook de Python con el código para la extracción y unificación de los datos.

- [ETL_sql.sql](./ETL_sql.sql): Notebook de SQL con el código para la trasnformación, y limpieza de los datos.

- [Machine_Learning.ipynb](./Machine_Learning.ipynb): Notebook de Python con el código para la exploración de los datos, su preparación y posterior aplicación de un modelo de Machine Learning.

- [Introducción.py](./Introducción.py): Script de Python que contiene la primer página para la aplicación de Streamlit.

- [requeriments.txt](./requeriments.txt): Archivo de texto que contiene las librerias necesarias para el correcto funcionamiento del Streamlit.


## `Dashboard` 

A continuación se adjuntaran imágenes del respectivo dashboard :
---
<p align="center">
<img src="https://raw.githubusercontent.com/MatyTrova/PI-DataAnalytics/main/imgs/Portada.png"  alt="Happiness">
</p>


---
<p align="center">
<img src="https://raw.githubusercontent.com/MatyTrova/PI-DataAnalytics/main/imgs/P%C3%A1gina%201.png"  alt="Happiness">
</p>



---
<p align="center">
<img src="https://raw.githubusercontent.com/MatyTrova/PI-DataAnalytics/main/imgs/P%C3%A1gina%202.png"  alt="Happiness">
</p>


---
<p align="center">
<img src="https://raw.githubusercontent.com/MatyTrova/PI-DataAnalytics/main/imgs/P%C3%A1gina%203.png"  alt="Happiness">
</p>


---





