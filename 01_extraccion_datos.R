# 0. Instalar paquetes si no los tienes (descomenta la siguiente línea si es tu primera vez)
 install.packages(c("WDI", "tidyverse"))

# Cargar librerías
library(WDI)        # Para conectarnos a la API del Banco Mundial
library(tidyverse)  # Para la limpieza y manipulación de datos (dplyr, tidyr)

cat("Iniciando extracción de datos macroeconómicos...\n")

# 1. Definir Diccionario de Indicadores
# Usamos un vector con nombres descriptivos para facilitar el trabajo
indicadores <- c(
  "pib_crecimiento" = "NY.GDP.MKTP.KD.ZG",
  "inflacion"       = "FP.CPI.TOTL.ZG",
  "desempleo"       = "SL.UEM.TOTL.ZS",
  "tipo_cambio"     = "PA.NUS.FCRF"
)

# 2. Definir los países (Usamos los códigos ISO-2)
paises_latam <- c("AR", "BR", "CL", "CO", "MX", "PE", "PY")

# 3. Consultar la API del Banco Mundial
# Extraemos datos desde el año 2000 para tener un buen histórico
datos_crudos <- WDI(
  country = paises_latam,
  indicator = indicadores,
  start = 2000,
  end = 2025 
)

# 4. Data Wrangling (Limpieza y transformación)
datos_limpios <- datos_crudos %>%
  # Seleccionamos solo las columnas que nos importan
  select(iso2c, country, year, pib_crecimiento, inflacion, desempleo, tipo_cambio) %>%
  # Renombramos para tener todo en español y estandarizado
  rename(
    codigo_pais = iso2c,
    pais = country,
    anio = year
  ) %>%
  # PASO CLAVE PARA POWER BI: Transformar a formato "Largo" (Tidy Data)
  # En lugar de tener una columna por indicador, tendremos una columna 'indicador' y otra 'valor'
  # Esto facilita enormemente el modelado en estrella y el uso de DAX.
  pivot_longer(
    cols = c(pib_crecimiento, inflacion, desempleo, tipo_cambio),
    names_to = "indicador",
    values_to = "valor"
  ) %>%
  # Eliminamos los valores nulos (años donde el BM aún no tiene datos)
  filter(!is.na(valor))

# 5. Exportar el dataset final
# Generamos un archivo CSV limpio que será nuestra fuente para Power BI
write_csv(datos_limpios, "dataset_macro_latam.csv")

cat("¡Éxito! Dataset exportado como 'dataset_macro_latam.csv'.\n")