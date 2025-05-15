from . import app
from flask import render_template, request, redirect, url_for, flash
from flask_login import login_user, current_user, logout_user
from testapp import db
from testapp.models.member import Member
from .models.login_form import LoginForm
from .models.registration_form import RegistrationForm
import testapp.login


@app.route('/', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        #フォーム入力したアドレスがDB内にあるか検索
        user = Member.query.filter_by(email=form.email.data).first()
        if user is not None:
            #check_passwordはUserモデル内の関数
            if user.check_password(form.password.data):
                #ログイン処理。ログイン状態として扱われる。
                login_user(user)
                next = request.args.get('next')
                if next == None or not next[0] == '/':
                    next = url_for('login')
                return redirect(next)
            else:
                flash('パスワードが一致しません')
        else:
            flash('入力されたユーザーは存在しません')
    return render_template('index.html', form=form, current_user=current_user)

@app.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('login'))

@app.route('/register', methods=['GET', 'POST'])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        member = Member(email=form.email.data, user_name=form.user_name.data, password=form.password.data)
        db.session.add(member)
        db.session.commit()
        return redirect(url_for('member_list'))
    else:
        return render_template('register.html', form=form)

@app.route('/members')
def member_list():
    members = Member.query.all()
    return render_template('member_list.html', members=members)

@app.route('/members/<int:id>/edit', methods=['GET', 'POST'])
def member_edit(id):
    # 編集ページ表示用
    match request.method:
        case 'GET':
            member = Member.query.get(id)
            return render_template('member_edit.html', member=member)
        case 'POST':
            member = Member.query.get(id)  # 更新するデータをDBから取得
            member.name = request.form.get('name')
            member.email = request.form.get('email')
            member.is_remote = request.form.get('is_remote', default=False, type=bool)
            member.department = request.form.get('department')
            member.year = request.form.get('year', default=0, type=int)

            db.session.merge(member)
            db.session.commit()
            return redirect(url_for('member_list'))

@app.route('/members/<int:id>/delete', methods=['POST'])  
def member_delete(id):
    member = Member.query.get(id)   
    db.session.delete(member)  
    db.session.commit()  
    return redirect(url_for('member_list'))
