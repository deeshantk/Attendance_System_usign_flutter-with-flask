from flask import Flask,request,jsonify
from flask_sqlalchemy import SQLAlchemy
import pandas as pd

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'path' #Give the path for database
db = SQLAlchemy(app)

def to_dict(row):
    if row is None:
        return None

    rtn_dict = dict()
    keys = row.__table__.columns.keys()
    for key in keys:
        rtn_dict[key] = getattr(row, key)
    return rtn_dict

# this class is for creating tables in db
class user(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80))
    email = db.Column(db.String(120))
    password = db.Column(db.String(80))
    atten = db.Column(db.String(1))

@app.route('/cam', methods=['GET', 'POST'])
def camera():
    d = {}
    if request.method == 'POST':
        uname = request.form['uname']
        if user.query.filter_by(username=uname) != None:
            if user.query.filter_by(username=uname).atten == 0:
                user.query.filter_by(username=uname).update(dict(atten=1))
                db.session.commit()
                d['status'] = 'Attendance marked :)'
            else:
                d['status'] = 'Attendance already marked'
        return jsonify(d)


@app.route("/login",methods=["GET", "POST"])
def login():
    d = {}
    if request.method == "POST":
        uname = request.form["uname"]
        passw = request.form["passw"]
        
        login = user.query.filter_by(username=uname, password=passw).first()

        if login is not None:
            # account found
            if 'admin' !=  uname:
                use = user.query.filter_by(username=uname).first()
                d["status"] = use.atten
                return jsonify(d)
            else:
                usernow = []
                Email = []
                Attendance = []
                data = user.query.all()
                for datas in data:
                    usernow.append(datas.username)
                    Email.append(datas.email)
                    if datas.atten == '0':
                        Attendance.append('Not Present or late')
                    else:
                        Attendance.append('Present')
                dict = {'Username': usernow,'Email': Email, 'Attendance': Attendance}
                
                df = pd.DataFrame(dict)
                df.to_csv('Records_of_attendence.csv')

                return jsonify({'status': 'All data has been shown'})
        else:
            # account not exist
            d["status"] = '22'
            return jsonify(d)
            


@app.route("/register", methods=["GET", "POST"])
def register():
    d = {}
    if request.method == "POST":
        uname = request.form['uname']
        mail = request.form['mail']
        passw = request.form['passw']
        username = user.query.filter_by(username=uname).first()
        if username is None:
            register = user(username = uname, email = mail, password = passw, atten='0')
            db.session.add(register)
            db.session.commit()
            d["status"] = '11'
            return jsonify(d)
        else:
            # already exist
            d["status"] = '22'
            return jsonify(d)

if __name__ == "__main__":
    db.create_all()
    app.run(host='192.168.43.189')
