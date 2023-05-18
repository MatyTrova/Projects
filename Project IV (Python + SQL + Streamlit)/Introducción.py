import streamlit as st

# Título de la página
st.title("**Proyecto Happiness**")

# Imagen
#st.image("ruta/a/tu/imagen.jpg", caption="Imagen de ejemplo", use_column_width=True)
# Línea divisoria
st.markdown("---")
# Encabezado
st.header("Bienvenido :)")

# Texto descriptivo
st.write("¡Explora el mundo de la felicidad y el bienestar!")
st.write("Bienvenido a mi **Proyecto Happiness**, una aplicación interactiva diseñada para sumergirte en los datos mundiales relacionados con la felicidad, el PIB, la población y muchas otras variables de interés.")

# Sección de información
st.subheader("¿Qué puedes encontrar aquí?")
st.write("En esta aplicación, podrás descubrir una variedad de secciones y características para tu análisis y descubrimiento:")
st.write("+ **Datos**: Explora una visualización completa y actualizada de los datos recopilados.")
st.write("+ **Visualizaciones**: Sumérgete en gráficos interactivos y descubre las historias que se esconden detrás de los números.")

st.subheader("Explora y descubre")
st.write("Aquí puedes explorar diversos aspectos de los países, su felicidad y otros indicadores relacionados. Puedes visualizar gráficos interactivos, filtrar los datos por país o año, y comparar variables para obtener insights interesantes sobre el bienestar y desarrollo de las naciones. Selecciona diferentes variables, como el PIB per cápita, la esperanza de vida, la libertad, la generosidad y más, para ver cómo han evolucionado a lo largo de los años en diferentes países. Además, podrás descubrir cuáles son los países con los puntajes de felicidad más altos y más bajos, y explorar la relación entre el PIB y el puntaje de felicidad.")

# Línea divisoria
st.markdown("---")

# Créditos
st.text("Desarrollado por: Matias Trovatto")
