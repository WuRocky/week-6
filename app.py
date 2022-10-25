import mysql.connector
from mySQL import MySQLPassword
from flask import *
mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password=MySQLPassword(),
  database='website'
)

app=Flask(
  __name__,
  static_folder="public",
  static_url_path="/"
)
app.secret_key="test"


@app.route("/")
def index():
  return render_template("index.html")

@app.route("/member")
def member():
  if "username" in session:
    mycursor = mydb.cursor()
    sqlSelect = "select * from member"
    sqlMessage = "select a.name , b.content \
    from member as a \
    inner join message as b \
    on a.id = b.member_id"
    mycursor.execute(sqlSelect)
    reuslt=mycursor.fetchall()
    for x in reuslt:
      if x[2] == session["username"]:
        data = x[1]
        mycursor.execute(sqlMessage)
        message=mycursor.fetchall()
        mydb.commit()
        return render_template("member.html",name=data,message=message)
  else:
    return redirect("/")

@app.route("/message", methods=["POST"])
def message():
  mycursor = mydb.cursor()
  content = request.form["content"]
  mycursor.execute("insert into message(member_id, content) values(%s, %s)",(session["id"],content))
  sqlMessage = "select a.name , b.content \
  from member as a \
  inner join message as b \
  on a.id = b.member_id"
  mycursor.execute(sqlMessage)
  message=mycursor.fetchall()
  mydb.commit()
  return render_template("member.html",name=session["name"],message=message) 


@app.route("/signup", methods=["POST"])
def signup():
  name=request.form["name"]
  username=request.form["username"]
  password=request.form["password"]
  mycursor = mydb.cursor()
  sqlSelect = "select * from member"
  mycursor.execute(sqlSelect)
  reuslt=mycursor.fetchall()
  for x in reuslt:
    if x[2] == username:
      return redirect("/error?message=帳號已經被註冊")
  mycursor.execute("insert into member(name, username, password) values(%s, %s, %s)",(name,username,password))
  mydb.commit()
  return redirect("/")




@app.route("/signin", methods=["POST"])
def signin():
  username=request.form["signinUsername"]
  password=request.form["signinPassword"]
  mycursor = mydb.cursor()
  sqlSelect = "select * from member"
  mycursor.execute(sqlSelect)
  reuslt=mycursor.fetchall()
  for x in reuslt:
    if x[2] == username and x[3] == password:
      session["username"]=username
      session["id"]=x[0]
      session["name"]=x[1]
      return redirect("/member")
  return redirect("/error?message=帳號或密碼輸入錯誤")



@app.route("/error")
def error():
  data=request.args.get("message","自訂錯誤訊息")
  return render_template('error.html',message=data)




@app.route("/signout")
def signout():
  del session["username"],session["id"],session["name"]
  return redirect("/")


if __name__ == "__main__": 
  app.run(port=3000,debug=True)




