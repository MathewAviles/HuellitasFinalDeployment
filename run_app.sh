#!/bin/bash

# Mensaje de inicio
echo "Iniciando la configuración del entorno..."

# Crea el entorno virtual si no existe
echo "Creando el entorno virtual..."
python -m venv venv || python3 -m venv venv

# Activa el entorno virtual
echo "Activando el entorno virtual..."
source venv/Scripts/activate

# Actualiza pip
echo "Actualizando pip..."
python -m pip install --upgrade pip

# Instala las dependencias desde el archivo requirements.txt
echo "Instalando dependencias desde requirements.txt..."
pip install -r requirements.txt

# Cambia al directorio del script
cd "$(dirname "$0")"

# Reemplaza la línea de código en flask_uploads.py
echo "Realizando el reemplazo en flask_uploads.py..."
sed -i 's/from werkzeug import secure_filename, FileStorage/from werkzeug.utils import secure_filename\nfrom werkzeug.datastructures import FileStorage/' venv/lib/site-packages/flask_uploads.py

# Regresa al directorio original
cd -

# Mensaje de finalización
echo "Configuración completada. Ejecutando la aplicación..."

# Ejecuta tu aplicación
python run.py
