from flask_app import app

import flask_app.config as conf

from flask import jsonify

@app.route('/get')
def index():
    return()

@app.route('/post/<playerid>/<score>')
def ingest():
    headers_raw = conf.knight_db.put(f'CALL appendStream({playerid},{score});')
