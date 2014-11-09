import flask
##import jinja2

app = flask.Flask(__name__)

@app.route("/")
def hello():
	return flask.render_template('app.html', title="Example-title", description="Example-description")

@app.route("/staticfile")
def staticfile():
	staticurl=flask.url_for('static', filename='examplepdf.pdf')
	return staticurl

if __name__ == "__main__":
    app.run(debug=True)
