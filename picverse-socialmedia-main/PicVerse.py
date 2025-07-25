from flask import Flask,session
from flask_mail import Mail
from colorama import Fore, Style

def PicVerse():
    app = Flask(__name__)
    app.secret_key = 'PicVerseTyIMScIT'
    
    app.config['MAIL_SERVER'] = 'smtp.gmail.com'
    app.config['MAIL_PORT'] = 587
    app.config['MAIL_USE_TLS'] = True
    app.config['MAIL_USE_SSL'] = False
    app.config['MAIL_USERNAME'] = 'dhruvpa0913@gmail.com' 
    app.config['MAIL_PASSWORD'] = 'bawzltmjcpfkhwtk' 
    app.config['MAIL_DEFAULT_SENDER'] = 'dhruvpa0913@gmail.com' 
   
    mail = Mail(app)
    return app, mail
app, mail = PicVerse()
