"use strict";
const express = require('express');
const session = require('express-session');
const appRoute = require("./routes/appRoutes");
const bodyParser = require("body-parser");
const redis = require('redis');
const redisStore = require('connect-redis')(session);
const client  = redis.createClient();
var app = express();
var host = "127.0.0.1";
var port = 8080;
// var startPage = "index.html";
app.use(session({
    secret: 'ssshhhhh',
    store: new redisStore({ host: 'localhost', port: 6379, client: client,ttl : 260}),
    saveUninitialized: false,
    resave: false
}));
app.use(express.static("./public"));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
appRoute.appRoute(app);

client.on('error', function(err) {
    console.log('Redis error: ' + err);
});

client.on("ready",function () {
    console.log("Redis is ready");
});
// function gotoIndex(req, res) {
//     console.log(req.params);
//     res.sendFile(__dirname + "/" + startPage);
// }

// app.get("/" + startPage, gotoIndex);

// app.route("/");

var server = app.listen(port, host, function() {
    var host = server.address().address;
    var port = server.address().port;

    console.log("Example app listening at http://%s:%s", host, port);
});
