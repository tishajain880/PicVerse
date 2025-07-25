from flask import Flask, render_template, request, redirect, url_for, session,flash
from PicVerse import app,mail
from sqlconnect import conn,cursor
import secrets
import os

@app.route('/createPost', methods=['GET', 'POST'])
def createPost():
    if 'loginUsername' in session:
        userDbData = getUserData(session['loginUsername'])
        userUserId = userDbData[0]
        userPfpPath = userDbData[7]

        if request.method == 'POST':
            postMedia = request.files.get('postMedia')
            postCaption = request.form['postCaption']

            if postMedia:
                allowed_extensions = {'.jpg', '.jpeg', '.png', '.mkv', '.mp4'}
                allowed_image = {'.jpg', '.jpeg', '.png'}
                allowed_video = {'.mkv', '.mp4'}
                filename = postMedia.filename.lower()

                if not any(filename.endswith(ext) for ext in allowed_extensions):
                    fileError = 'Only these file extensions are allowed: ' + ', '.join(allowed_extensions)
                    return render_template('createPost.html', fileError=fileError, userPfpPath=userPfpPath)

                unique_filename = secrets.token_urlsafe(60) + '.' + filename.split('.')[-1]

                for extension in allowed_extensions:
                    if filename.endswith(extension):
                        if extension in allowed_image:
                            storage_folder = './static/storage/posts/photos'
                            media_type = 'photo'
                        else:
                            storage_folder = './static/storage/posts/videos'
                            media_type = 'video'
                        break

                media_path = os.path.join(storage_folder, unique_filename)

                try:
                    postMedia.save(media_path)
                except Exception as e:
                    print('Error saving file:', str(e))
                    fileError = 'File Upload Failed! Try Again.'
                    return render_template('createPost.html', fileError=fileError, userPfpPath=userPfpPath)

                media_path = '.' + media_path  # for relative path
                addPostToDb(userUserId, postCaption, media_path, media_type)
                return render_template('createPost.html', fileError='Post Uploaded!', userPfpPath=userPfpPath)

        return render_template('createPost.html', userPfpPath=userPfpPath)

    return redirect(url_for('login'))

def getUserData(username):
    cursor.execute("SELECT * FROM users WHERE user_name = %s", (username,))
    result = cursor.fetchone()
    return result


def addPostToDb(uid,caption,url,type):
    cursor.execute("INSERT INTO posts(user_id, caption, media_url, media_type,timestamp) VALUES (%s, %s, %s, %s, NOW())",(uid, caption, url, type,))
    conn.commit()

def addLessonToDb(uid,caption,url,type):
    cursor.execute("INSERT INTO lessons(user_id, caption, media_url, media_type,timestamp,approval_status) VALUES (%s, %s, %s, %s, NOW(),'pending')",(uid, caption, url, type,))
    conn.commit()

def addSheetMusicToDb(uid,caption,url,type):
    cursor.execute("INSERT INTO sheet_music(user_id, caption, media_url, media_type,timestamp,approval_status) VALUES (%s, %s, %s, %s, NOW(),'approved')",(uid, caption, url, type,))
    conn.commit()