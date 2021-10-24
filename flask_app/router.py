from flask_app import app

import flask_app.config as conf

from flask import jsonify

@app.route('/get',methods=['GET'])
def index():
    return()

@app.route('/post/<playerid>/<score>', methods=['POST'],['GET'])
def ingest(playerid, score):
    conf.knight_db.put(f'CALL appendStream({playerid},{score})')
