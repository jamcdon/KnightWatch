from flask_app import app

import flask_app.config as conf

from flask import jsonify, request

@app.route('/',methods=['GET'])
def index():
    results = conf.knight_db.fetch('CALL frontEndCall()')
    print(jsonify(results))
    return(jsonify(results))

@app.route('/post/<playerid>/<score>', methods=['POST'])
def ingest(playerid, score):
    conf.knight_db.put(f'CALL appendStream({playerid},{score})')

@app.route('/node', methods=['POST'])
def nodeIngest():
    playerid = request.args.get('p')
    score = request.args.get('s')
    conf.knight_db.put(f'CALL appendStream({playerid},{score})')

@app.route('/update', methods=['POST'])
def updateExport():
    conf.knight_db.put(f'CALL updateExport(1)')
    conf.knight_db.put(f'CALL updateExport(2)')
    conf.knight_db.put(f'CALL updateExport(3)')
    conf.knight_db.put(f'CALL updateExport(4)')
    conf.knight_db.put(f'CALL updateExport(5)')
    conf.knight_db.put(f'CALL updateExport(6)')
    conf.knight_db.put(f'CALL updateExport(7)')
    conf.knight_db.put(f'CALL updateExport(8)')
    conf.knight_db.put(f'CALL updateExport(9)')
    conf.knight_db.put(f'CALL updateExport(10)')
    conf.knight_db.put(f'CALL updateExport(11)')
    conf.knight_db.put(f'CALL updateExport(12)')