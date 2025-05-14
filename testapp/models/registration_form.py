from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import DataRequired, Email


class RegistrationForm(FlaskForm):
    email = StringField('Email', validators=[DataRequired(), Email(message='Incorrect email')])
    user_name = StringField('User Name', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Register')
