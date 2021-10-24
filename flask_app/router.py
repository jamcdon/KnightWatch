from flask_app import app

import flask_app.config as conf

from flask import jsonify

@app.route('/get',methods=['GET'])
def index():
    return()

@app.route('/post/<playerid>/<score>', methods=['POST'])
def ingest():
    headers_raw = conf.knight_db.put(f'CALL appendStream({playerid},{score});')
