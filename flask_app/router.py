from flask_app import app

from flask import render_template, jsonify

@app.route('/')
def index():
    return render_template('index.html')

@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html', title='404'), 404
