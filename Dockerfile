# Usa una imagen de Python como base
FROM python:3.9

# Establece el directorio de trabajo en /run
WORKDIR /run

# Copia el archivo de requisitos al contenedor
COPY requirements.txt .

# Instala las dependencias necesarias
RUN pip install --no-cache-dir -r requirements.txt

# Copia el contenido actual del directorio al contenedor en /run
COPY . .

# Reemplaza la línea de código en flask_uploads.py
RUN sed -i 's/from werkzeug import secure_filename, FileStorage/from werkzeug.utils import secure_filename\nfrom werkzeug.datastructures import FileStorage/' /usr/local/lib/python3.9/site-packages/flask_uploads.py

# Expón el puerto 6000
EXPOSE 5000

# Comando para ejecutar tu aplicación cuando el contenedor se inicia
CMD ["python", "run.py"]
