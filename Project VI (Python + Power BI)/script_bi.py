# Librerias a utilizar 
import pandas as pd
import numpy as np
import requests


# Llave de la api
api_key = "nbxsVHbOnkzqM6sjQ6s5DGfng0ufScUE9AFcopog"
# Lista de parámetros
lista_api = ["VELOC-PROME-DE-BAJAD-DE","ACCES-A-INTER-FIJO-23248","ACCES-A-INTER-FIJO-POR","CONEC-AL-SERVI-DE-INTER","INGRE-TRIME-POR-LA-96059","INGRE-TRIME-POR-LA-PREST","INGRE-TRIME-POR-LA-86109"]
# Lista vacía para ingresar los dataframes de cada iteración
lista_dfs = []
# Iteraremos para realizar distintas llamadas a la api por cada parámetro de la lista
for elemento in lista_api :
    print(elemento)
    url = f"http://api.datosabiertos.enacom.gob.ar/api/v2/datastreams/{elemento}/data.ajson/?auth_key={api_key}"
    response = requests.get(url)
    data = response.json()["result"][1:]
    headers = response.json()["result"][0]
    df = pd.DataFrame(data, columns=headers)
    lista_dfs.append(df)

# Renombramos cada dataframe
df_media_mb = lista_dfs[0]
df_acceso_por_mb = lista_dfs[1]
df_acceso_por_servicio = lista_dfs[2]    
df_localidades = lista_dfs[3]

df_telefonia = lista_dfs[4]
df_movil = lista_dfs[5]
df_tv = lista_dfs[6]


# Por mb
df_acceso_por_mb = lista_dfs[1]
df_acceso_por_mb.replace('', "0", inplace=True)
df_acceso_por_mb.dropna(inplace=True)
serv_mb = ["HASTA 512 kbps","+ 512 Kbps - 1 Mbps","+ 1 Mbps - 6 Mbps","+ 6 Mbps - 10 Mbps","+ 10 Mbps - 20 Mbps","+ 20 Mbps - 30 Mbps","+ 30 Mbps","OTROS","Total"]
for elemento in serv_mb:
    df_acceso_por_mb[elemento] = df_acceso_por_mb[elemento].str.replace(",","")
    df_acceso_por_mb[elemento] = df_acceso_por_mb[elemento].astype(int)
df_filtrado_mb = df_acceso_por_mb[["Año","Provincia","HASTA 512 kbps","+ 512 Kbps - 1 Mbps","+ 1 Mbps - 6 Mbps","+ 6 Mbps - 10 Mbps","+ 10 Mbps - 20 Mbps","+ 20 Mbps - 30 Mbps","+ 30 Mbps","OTROS","Total"]].groupby(["Año","Provincia"]).sum().reset_index()
for elemento in serv_mb : 
    df_filtrado_mb[elemento] = (df_filtrado_mb[elemento]/df_filtrado_mb["Total"]) 
    df_filtrado_mb[elemento] = df_filtrado_mb[elemento].astype(str)
    df_filtrado_mb[elemento] = df_filtrado_mb[elemento].str.replace(".",",")
df_filtrado_mb

# Por servicio
df_acceso_por_servicio = lista_dfs[2]   
df_acceso_por_servicio = df_acceso_por_servicio.drop(840)
serv = ["ADSL","Cablemodem","Fibra óptica","Otros","Wireless","Total"]
for elemento in serv:
    df_acceso_por_servicio[elemento] = df_acceso_por_servicio[elemento].str.replace(",","")
    df_acceso_por_servicio[elemento] = df_acceso_por_servicio[elemento].astype(float)
df_filtrado_servicios = df_acceso_por_servicio[["Año","Provincia","ADSL","Cablemodem","Fibra óptica","Wireless","Otros","Total"]].groupby(["Provincia","Año"]).sum().reset_index()
for elemento in serv : 
    df_filtrado_servicios[elemento] = (df_filtrado_servicios[elemento]/df_filtrado_servicios["Total"])
df_filtrado_servicios
query10 = df_filtrado_servicios[df_filtrado_servicios["Año"] == '2022']
query10 = query10[["Provincia",'ADSL', 'Cablemodem', 'Fibra óptica', 'Wireless']]
dff = query10.melt("Provincia")
dff.groupby(["Provincia","variable"]).max().reset_index()



# Accesos por hogar
df_accesos_por_hogar = pd.read_csv(r"C:\Users\matia\OneDrive\Desktop\PI data analytics\Internet_Penetracion.csv")
df_accesos_por_hogar["Accesos por cada 100 hogares"] = df_accesos_por_hogar["Accesos por cada 100 hogares"].str.replace(",",".")
df_accesos_por_hogar["Accesos por cada 100 hogares"] = df_accesos_por_hogar["Accesos por cada 100 hogares"].astype(float) 
trimestre2_2022 = df_accesos_por_hogar[(df_accesos_por_hogar['Año'] == 2022) & (df_accesos_por_hogar['Trimestre'] == 2)]
hogares_adicionales = trimestre2_2022['Accesos por cada 100 hogares'] * 0.02
objetivo = trimestre2_2022['Accesos por cada 100 hogares'] + hogares_adicionales
objetivo = objetivo.round(2)
columnas = ['Provincia', 'Accesos por cada 100 hogares', 'Objetivo para T3 2022']
df_objetivo_t3_2022 = pd.DataFrame({
    'Provincia': trimestre2_2022['Provincia'],
    'Accesos por cada 100 hogares': trimestre2_2022['Accesos por cada 100 hogares'],
    'Objetivo para T3 2022': objetivo
})
df_objetivo_t3_2022 = df_objetivo_t3_2022.copy()

# Ingresos
df_ingresos = pd.read_csv(r"C:\Users\matia\OneDrive\Desktop\PI data analytics\Internet_Ingresos.csv")
df_ingresos["Ingresos (miles de pesos)"] = df_ingresos["Ingresos (miles de pesos)"].str.replace(".","", regex=False)
df_ingresos["Ingresos (miles de pesos)"] = df_ingresos["Ingresos (miles de pesos)"].astype(int)
df_ingresos["Año"] = df_ingresos["Año"].astype(int)
df_ingresos["Trimestre"] = df_ingresos["Trimestre"].astype(int)
ingresos_por_año = df_ingresos.groupby('Año')['Ingresos (miles de pesos)'].sum()
porcentaje_cambio = (ingresos_por_año.pct_change() * 100).round(2)
df_ingresos_por_año = pd.DataFrame(ingresos_por_año).rename(columns={'Ingresos (miles de pesos)': 'Ingresos totales'})
df_ingresos_por_año['Año'] = df_ingresos_por_año.index
df_porcentaje_cambio = pd.DataFrame(porcentaje_cambio).rename(columns={'Ingresos (miles de pesos)': 'Porcentaje de cambio'})
df_resultado = pd.concat([df_ingresos_por_año, df_porcentaje_cambio], axis=1)

# Localidades
df_localidades = pd.read_csv(r"C:\Users\matia\OneDrive\Desktop\PI data analytics\concectividad.csv")
df_localidades["servicio"] = df_localidades["SATELITAL"] + df_localidades["WIRELESS"] + df_localidades["TELEFONIAFIJA"] + df_localidades["3G"] + df_localidades["4G"] + df_localidades["FIBRAOPTICA"] + df_localidades["DIALUP"] + df_localidades["CABLEMODEM"] + df_localidades["ADSL"]
localidades = df_localidades[(df_localidades["servicio"] == "------------------")]
query1 = localidades[["Provincia"]].groupby("Provincia").value_counts().reset_index(name="Sin_servicio")
df_localidades_por_prov = df_localidades["Provincia"].value_counts().reset_index()
df_localidades_por_prov.columns = ["Provincia", "Total de localidades"]
df_merged = pd.merge(df_localidades_por_prov, query1[["Provincia","Sin_servicio"]], on="Provincia", how="left")
df_merged["Porcentaje de localidades sin servicios"] = (df_merged["Sin_servicio"] / df_merged["Total de localidades"]) * 100
df_merged.fillna(0,inplace=True)
df_merged
