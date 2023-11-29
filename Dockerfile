# Usa una imagen de Python como base
FROM python:3.9

# Establece el directorio de trabajo en /app
WORKDIR /run

# Copia el contenido actual del directorio al contenedor en /app
COPY . /run

# Instala las dependencias necesarias
RUN bash run_app.sh

# Expón el puerto 5000
EXPOSE 5000

# Comando para ejecutar tu aplicación cuando el contenedor se inicia
CMD ["python", "run.py"]
