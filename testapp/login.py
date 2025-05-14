from flask_login import LoginManager
from . import app
from .models.member import Member

#インスタンス化
login_manager = LoginManager()
#アプリをログイン機能を紐付ける
login_manager.init_app(app)
#未ログインユーザーを転送する(ここでは'login'ビュー関数を指定)
login_manager.login_view = 'login'

#現在のログインユーザーの情報を保持し、必要なときに参照できるようになる。
@login_manager.user_loader
def load_user(user_id):
    return Member.query.get(user_id)
