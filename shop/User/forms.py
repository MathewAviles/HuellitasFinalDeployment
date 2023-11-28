from wtforms import Form, StringField, TextAreaField, PasswordField, SubmitField, validators, ValidationError, IntegerField
from flask_wtf.file import FileRequired, FileAllowed, FileField
from wtforms.validators import DataRequired, Email, EqualTo, Length
from flask_wtf import FlaskForm
from .model import RegistroU

class UserRegisterForm(FlaskForm):
    nombre = StringField('Nombre:' ,[validators.Length(min=4, max=100), validators.Regexp(r'^[a-zA-Z ]+$', message='Ingrese un nombre válido (solo letras)')])
    username = StringField('Usuario',[validators.Length(min=4, max=100)])
    telefono = StringField('Teléfono:', [validators.DataRequired(), validators.Length(min=10, max=10), validators.Regexp(r'^\d{10}$', message='Ingrese un número de teléfono válido (10 dígitos numéricos)') ]) 
    email= StringField('Correo:', [validators.Email(message='Correo inválido '), validators.DataRequired(), validators.Length(min=10, max=100)])
    password = PasswordField('Contraseña:', [validators.DataRequired(), validators.Length(min=8, max=50), validators.EqualTo('confirm',message='Las contraseñas no coinciden ')])
    confirm= PasswordField('Repita la contraseña: ', [validators.DataRequired(), validators.Length(min=8, max=50)])
    profile = FileField('Foto de perfil', validators=[FileAllowed(['jpg','png','jpeg','gif'], 'Solo imágenes por favor ')])
    submit= SubmitField('RegistroU')
    
    
    def validate_username(self, username):
        if RegistroU.query.filter_by(username=username.data).first():
            raise ValidationError("Este nombre de usuario ya está registrado, ingrese otro")


    def validate_email(self, email):
        if RegistroU.query.filter_by(email=email.data).first():
            raise ValidationError("Este correo ya está registrado, ingrese otro")
    
    def validate_telefono(self, telefono):
        if RegistroU.query.filter_by(telefono=telefono.data).first():
            raise ValidationError("Este número de teléfono ya está registrado, ingrese otro")


class UserLoginForm(FlaskForm):
    email=StringField('Correo: ',[validators.Email(message='Correo inválido '), validators.DataRequired()])
    password=PasswordField('Contraseña: ',[validators.DataRequired()])
    


class ResetPasswordForm(FlaskForm):
    email = StringField('Correo Electrónico', validators=[validators.DataRequired()])
    new_password = PasswordField('Nueva Contraseña', validators=[
        validators.DataRequired(),
        validators.Length(min=8),
        validators.EqualTo('confirm_password', message='Las contraseñas no coinciden')
    ])
    confirm_password = PasswordField('Confirmar Contraseña', validators=[
        validators.DataRequired(),
        validators.Length(min=8, max=50)  # Aquí se corrige la validación de longitud
    ])
    submit = SubmitField('Restablecer Contraseña')
    