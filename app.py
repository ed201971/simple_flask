import sys, encodings
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello "+str(sys.argv[1:])

if __name__ == "__main__":
    app.run(debug=True,host='0.0.0.0')
