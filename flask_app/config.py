import json
import mysql.connector
from mysql.connector import Error


with open('./flask_app/config.json') as conf_file:
    config = json.load(conf_file)
    db_config = config['databases']



class database:
    def __init__(self, host_name, port_num, db_name, user_name, user_pass):
        self.host = host_name
        self.port = port_num
        self.name = db_name
        self.user = user_name
        self.passwd = user_pass
        try:
            self.makeConn()
        except Error as err:
            print(f'Error: {err}')
        #self.db_conn = connection
    def makeConn(self):
        connection = mysql.connector.connect(
            host = self.host,
            port = self.port,
            database = self.name,
            user = self.user,
            password = self.passwd
        )
        self.db_conn = connection

    def fetch(self,query):
        try:
            cursor = self.db_conn.cursor()
        except:
            self.makeConn()
            cursor = self.db_conn.cursor()
        try:
            cursor.execute(query)
            result = cursor.fetchall()
            return(result)
        except Error as err:
            print(f'Error: {err}')
    def put(self,query):
        try:
            cursor = self.db_conn.cursor()
        except:
            self.makeConn()
            cursor = self.db_conn.cursor()
        connection = self.db_conn.cursor()
            
        try:
            cursor.execute(query)
            #connection.commit()
            self.db_conn.commit()
        except Error as err:
            print(f"Error: '{err}'")


knight_db = database(
    host_name = db_config['knight']['host'],
    port_num = db_config['knight']['port'],
    db_name = db_config['knight']['name'],
    user_name = db_config['knight']['user'],
    user_pass = db_config['knight']['pass']
)