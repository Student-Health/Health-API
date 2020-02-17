var mysql = require('mysql');
var connection = mysql.createPool({
    host:'localhost',
    port: '3306',
    user:'root',
    password: '',
    database:'covid19db'

});
module.exports = connection;