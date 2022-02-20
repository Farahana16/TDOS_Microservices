var express = require('express');
var app = express();
var mysql = require('mysql');

//dab connection
var con = mysql.createConnection({
  host: "eu-cdbr-west-02.cleardb.net",
  user: "b103e963bf8806",
  password: "1a371198",
  database: "heroku_7fab5d5a1f5a6b9"
});

//mysql://b090fb7f4bf538:194dc125@us-cdbr-east-05.cleardb.net/heroku_bd549570b7b7d02?reconnect=true

//first page of system
var bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: false }));

app.get('/', function (req, res) {
    res.sendFile('index.html', { root:__dirname });
});

//for read css
app.use(express.static(__dirname));

//for login
app.post('/submit-data', function (req, res) {
    var username = req.body.username;
    var pass = req.body.pass;

    var sql = 'SELECT * FROM customer WHERE custUsername = ? OR custPwd = ?';
    con.query(sql, [username, pass], function (err, result) {
    if (err) throw err;
        res.sendFile('sucessfullylogin.html', { root:__dirname });
    });

});


//for signup
app.post('/signup', function (req, res) {
    var username = req.body.username;
    var phoneNumber= req.body.phoneNumber;
    var email = req.body.email;
    var pass = req.body.pass;

    con.connect(function(err) {
        if (err) throw err;
        console.log("Connected!");
        var sql = "INSERT into customer(custPwd, custPhoneNum, custEmail, custUsername) values('"+pass+"','"+phoneNumber+"','"+email+"','"+username+"')";
      //insert into customers(custPwd, custPhoneNum, custEmail, custUsername)values(?,?,?,?)
        con.query(sql, function (err, result) {
          if (err) throw err;
          res.sendFile('index.html', { root:__dirname });
        });
      });
});

//retrieve data
app.post('/view', function (req, res) {

  con.connect(function(err) {
      if (err) throw err;
      console.log("Connected!");
      var sql = "select * from customers";
      con.query(sql, function (err, result) {
        if (err) throw err;
        //res.sendFile('index.html', { root:__dirname });
        res.send(result);
        console.log("Succesfull!");
      });
    });
});

//port or server
var server = app.listen(8085, function () {
    console.log('Node server is running..');
});
