from flask import Flask
import jinja2
app = Flask(__name__)

@app.route("/")
def hello():
        templateLoader = jinja2.FileSystemLoader( searchpath="/" )
        templateEnv = jinja2.Environment( loader=templateLoader )
        TEMPLATE_FILE = "/my_application/app.tpl"
        template = templateEnv.get_template( TEMPLATE_FILE )
        templateVars = { "title" : "The Test Example","description" : "A simple inquiry of function." }
        outputText = template.render( templateVars )
        return outputText

if __name__ == "__main__":
    app.run()
