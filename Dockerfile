# Utiliza una imagen base de Python
FROM python:3.9.13

# Establece el directorio de trabajo en /app
WORKDIR /run

# Copia el archivo requirements.txt al contenedor
COPY requirements.txt .

# Instala las dependencias de la aplicación
RUN pip install -r requirements.txt

# Modifica flask_uploads.py
#RUN sed -i 's/from werkzeug import secure_filename, FileStorage/from werkzeug.utils import secure_filename\nfrom werkzeug.datastructures import FileStorage/g' /run/venv/lib/site-packages/flask_uploads.py

# Copia todo el contenido del directorio actual al contenedor
COPY . .

# Expone el puerto 5000 (o el puerto en el que se ejecute tu aplicación Flask)
EXPOSE 5000

# Comando para ejecutar tu aplicación Flask
CMD ["python", "run.py"]