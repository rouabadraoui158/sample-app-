from flask import Flask, render_template, request
import os

app = Flask(__name__)

@app.route('/')
def home():
    client_ip = request.remote_addr
    return f"You are calling me from {client_ip}"

if __name__ == '__main__':
    # Run in single-threaded mode with debug disabled
    app.run(host='0.0.0.0', port=5050, debug=False, threaded=False, processes=1)
