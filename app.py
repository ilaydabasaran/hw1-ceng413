import os
from flask import Flask, jsonify

app = Flask(__name__)

# Read configuration from environment variable
DATA_DIR = os.getenv("DATA_DIR", "/data")

@app.route("/health", methods=["GET"])
def health():
    return jsonify({
        "status": "healthy",
        "data_dir": DATA_DIR
    }), 200

@app.route("/", methods=["GET"])
def index():
    return jsonify({
        "message": "App is running smoothly inside Docker!",
        "version": "1.0.0"
    }), 200

@app.route("/info", methods=["GET"])
def info():
    return jsonify({
        "service": "CENG413 Docker Homework",
        "configured_data_dir": DATA_DIR,
    }), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)