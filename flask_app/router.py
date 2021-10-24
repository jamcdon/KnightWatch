from flask_app import app

import flask_app.config as conf

from flask import jsonify, request

@app.route('/get',methods=['GET'])
def index():
    return()

@app.route('/post/<playerid>/<score>', methods=['POST'])
def ingest(playerid, score):
    conf.knight_db.put(f'CALL appendStream({playerid},{score})')

@app.route('/node')
def nodeIngest():
    playerid = request.args.get('p')
    score = request.args.get('s')
    conf.knight_db.put(f'CALL appendStream({playerid},{score})')