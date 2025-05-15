import os
from datetime import timedelta


DEBUG = True
SQLALCHEMY_DATABASE_URI = 'sqlite:///sample_flask.db'
SQLALCHEMY_TRACK_MODIFICATIONS = True
SECRET_KEY = os.urandom(32)
WTF_CSRF_SECRET_KEY= os.urandom(32)
REMEMBER_COOKIE_DURATION = timedelta(days=1)
