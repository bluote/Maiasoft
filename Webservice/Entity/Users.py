# _*_ coding: utf-8 _*_
#!/usr/bin/env python
###################################
#description: Table Entity Class
#author: Yaochenxu
#date: 2016/10/09
###################################
import logging
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Column, Date, DateTime, Integer, Numeric, String, text
from passlib.apps import custom_app_context as pwd_context

# initialization
app = Flask(__name__)
app.config.from_object('config')
logger = logging.getLogger('MaiaService.Entity.Users')

# extensions
db = SQLAlchemy(app)

class User(db.Model):
    __tablename__ = 'users'

    employee_id = db.Column(db.String(10), primary_key=True)
    name = db.Column(db.String(20), nullable=False, unique=True)
    pwd = db.Column(db.String(256), nullable=False)
    auth_id = db.Column(db.String(10), nullable=False)
    last_login_at = db.Column(db.DateTime, nullable=False)
    valid = db.Column(db.Integer, nullable=False, server_default=db.text("'1'"))
    create_by = db.Column(db.String(10), nullable=False)
    create_at = db.Column(db.DateTime, nullable=False, server_default=db.text("CURRENT_TIMESTAMP"))
    update_by = db.Column(db.String(10), nullable=False)
    update_at = db.Column(db.DateTime, nullable=False, server_default=db.text("CURRENT_TIMESTAMP"))
    update_cnt = db.Column(db.Integer, nullable=False, server_default=db.text("'1'"))

    # password to SHA256
    def hash_password(self, password):
        self.pwd = pwd_context.encrypt(password)

    # convert the input password and verify it by SHA256
    def verify_password(self, password):
        return pwd_context.verify(password, self.pwd)

    def add_user(new_user):
        logger.info('save_user() start.')
        db.session.add(new_user)
        db.session.commit()
        logger.info('save_user() end.')

    def update_user(self):
        logger.info('update_user() start.')
        db.session.commit()
        logger.info('update_user() end.')
