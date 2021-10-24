from flask import Flask, json

app = Flask(__name__)

from flask_app import router
