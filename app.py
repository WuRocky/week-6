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

# 首頁
@app.route("/")
def index():
  return render_template("index.html")

# 註冊
@app.route("/signup", methods=["POST"])
def signup():
  name=request.form["name"]
  username=request.form["username"]
  password=request.form["password"]
  mycursor = mydb.cursor()
  mycursor.execute("select username from member where username = %s LIMIT 1",(username,))
  reuslt=mycursor.fetchone()
  if reuslt != None:
    return redirect("/error?message=帳號已經被註冊")
  mycursor.execute("insert into member(name, username, password) values(%s, %s, %s)",(name,username,password))
  mydb.commit()
  mycursor.close()
  return redirect("/")

# 登入
@app.route("/signin", methods=["POST"])
def signin():
  username=request.form["signinUsername"]
  password=request.form["signinPassword"]
  mycursor = mydb.cursor()
  mycursor.execute("select id,name,username,password from member where username = %s and password =%s LIMIT 1",(username,password,))
  reuslt=mycursor.fetchone()
  if reuslt == None:
    return redirect("/error?message=帳號或密碼輸入錯誤")
  session["username"]=username
  session["password"]=password
  session["id"]=reuslt[0]
  session["name"]=reuslt[1]
  mydb.commit()
  mycursor.close()
  return redirect("/member")

# 會員頁面
@app.route("/member")
def member():
  if "username" in session:
    mycursor = mydb.cursor()
    sqlMessage = "select a.name , b.content \
    from member as a \
    inner join message as b \
    on a.id = b.member_id"
    data = session["name"]
    mycursor.execute(sqlMessage)
    message=mycursor.fetchall()
    mydb.commit()
    mycursor.close()
    return render_template("member.html",name=data,message=message)
  return redirect("/")

# 聊天對話
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
  mycursor.close()
  return render_template("member.html",name=session["name"],message=message) 

# 錯誤頁面
@app.route("/error")
def error():
  data=request.args.get("message","自訂錯誤訊息")
  return render_template('error.html',message=data)

# 登出
@app.route("/signout")
def signout():
  del session["username"],session["id"],session["name"]
  return redirect("/")

if __name__ == "__main__": 
  app.run(port=3000,debug=True)

mydb.close()



