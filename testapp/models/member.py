from testapp import db
from datetime import datetime
from flask_login import UserMixin
from werkzeug.security import check_password_hash, generate_password_hash


class Member(db.Model, UserMixin):
    __tablename__ = 'member'
    id = db.Column(db.Integer, primary_key=True)  # システムで使う番号
    email = db.Column(db.String(255), unique=True, index=True)  # メール
    user_name = db.Column(db.String(255), unique=True, index=True)
    password_hash = db.Column(db.String(255))
    created_at = db.Column(db.DateTime, nullable=False, default=datetime.now)  # 作成日時
    updated_at = db.Column(db.DateTime, nullable=False, default=datetime.now, onupdate=datetime.now)  # 更新日時

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    @property
    def password(self):
        raise AttributeError('password is not a readable attribute')
    @password.setter
    def password(self, password):
        self.password_hash = generate_password_hash(password)
