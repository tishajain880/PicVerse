from flask import Flask, render_template, request, redirect, url_for, session
import random
from sqlconnect import conn,cursor
from PicVerse import app
import checkBan

@app.route('/')
def index():
    if 'loginUsername' in session:
        userDbData = getUserData(session['loginUsername'])
        userUserId = userDbData[0]
        userUserName = userDbData[1]
        userRealName = userDbData[3]
        userPfpPath = userDbData[7]
        banStatus = checkBan.checkBan(userUserName)
        if banStatus:
            return redirect(url_for('banned'))
    else:
        return redirect(url_for('login'))
    return render_template('index.html',userPfpPath=userPfpPath,userUserId=userUserId)

def getUserData(username):
    cursor.execute("SELECT * FROM users WHERE user_name = %s", (username,))
    result = cursor.fetchone()
    return result