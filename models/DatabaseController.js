"use strict";
var hash = require('./Hash');
var db = require('../dao');

class DatabaseController {
    //#region Users
    isLoggedIn(request, respond) {
        if (request.session.username != null) {
            respond.json(request.session);
        } else {
            respond.json("false");
        }
    }
    LoginUser(request, respond){
        var query = "SELECT * FROM covid19db.users WHERE covid19db.users.AdminNumber = ? AND covid19db.users.PasswordHash=?";
        db.query(query, [request.body.AdminNumber, request.body.PasswordHash], function(error, result) {
            if(error){
                throw error;
            }else{
                if(result[0] != null){
                    console.log(result[0]);
                        request.session.user_id = result[0].id;
                        respond.json(result);
                    }else{
                        //console.log(pwHash.passwordHash);
                        // console.log(result[0].passwordHash);
                        result = "no";
                        respond.json(result);
                    }
            }
        });
    }
    NewUser(request, respond){
        console.log(request);
        //check if user exists before inserting
        var query1 = "SELECT covid19db.users.AdminNumber FROM covid19db.users WHERE covid19db.users.AdminNumber = ?";
        db.query(query1, request.body.AdminNumber, (error, result)=>{
            //if user does not exist.
            if(result.length == 0){
                // var pwinfo = hash.Sha512Hash(request.body.Password, "12345678");
                var query = "INSERT INTO `covid19db`.`users` (`AdminNumber`, `PasswordSalt`, `PasswordHash`, `Firstname`, `MiddleName`, `LastName`, `Gender`) VALUES (?, ?, ?, ?, ?, ?, ?)";
                db.query(query, [request.body.AdminNumber, "somesalt",request.body.Password, request.body.FirstName ,request.body.MiddleName, request.body.LastName, request.body.Gender], function(error, result) {
                    if(error){
                        console.log("An error has occured when attempting to insert new user into db");
                        console.log(error);
                    }else{
                        respond.json(result);
                    }
                });
            }else{
                respond.json("no");
            }
        });
    }
    SignOut(request, respond) {
        request.session.destroy((error) => {
            if (error) return console.log(error);
            else respond.redirect('/index');
        });
    }
    
}
module.exports = DatabaseController;