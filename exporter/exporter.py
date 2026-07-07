import json
from flask import Flask, Response

app = Flask(__name__)

@app.route('/metrics')
def metrics():
    with open("checkov_results.json") as f:
        data = json.load(f)
    failed = len(data["results"]["failed_checks"])
    passed = len(data["results"]["passed_checks"])
    output = f"checkov_failed_checks_total {failed}\ncheckov_passed_checks_total {passed}\n"
    return Response(output, mimetype="text/plain")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)

