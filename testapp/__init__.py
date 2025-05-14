from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_wtf.csrf import CSRFProtect

app = Flask(__name__)
app.config.from_object('testapp.config')

db = SQLAlchemy(app)
csrf = CSRFProtect(app)
from .models import member

from testapp import views
