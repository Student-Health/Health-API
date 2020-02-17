"use strict"
const database = require('../models/DatabaseController');
var db = new database();
function appRoute(app){
    app.route('/login')
        .post(db.LoginUser);
    app.route('/newUser')
        .post(db.NewUser)
    //app.route('/')
    
}
module.exports = {appRoute};