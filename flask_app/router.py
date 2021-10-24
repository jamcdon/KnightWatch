from flask_app import app

import flask_app.config as conf

from flask import jsonify, request

@app.route('/get',methods=['GET'])
def index():
    results = conf.knight_db.fetch('CALL frontEndCall()')
    print(jsonify(results))
    return(jsonify(results))
@app.route('/get1',methods=['GET'])
def index():
    final = ""
    toreturn = conf.knight_db.fetch('CALL frontEndCall()')
    def my_function(inpt, value):
        tempDict = {}
        tempDict.update({"id": value})
        for j in range(len(inpt)):
            if(j==0):
                tempDict.update({"name": inpt[j]})
            if(j==1):
                tempDict.update({"number": inpt[j]})
            if(j==2):
                tempDict.update({"baseline": inpt[j]})
            if(j==3):
                tempDict.update({"aggregate": inpt[j]})
            if(j==4):
                tempDict.update({"score": inpt[j]})
            if(j==5):
                tempDict.update({"class": ""})

        return tempDict


for i in range(len(toreturn)):
    final += json.dumps(my_function(toreturn[i], i))
    if(i != (len(toreturn)-1)):
        final += ","


print(final)

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