"use strict";
var crypto = require('crypto');
/**
 * Creates Hash from provided salt and password.
 * Used to verify login and to create password
 */
exports.Sha512Hash = function(password, salt){
        var hash = crypto.createHmac('sha256', salt);
        hash.update(password);
        var value = hash.digest('hex');
        return {
            salt:salt,
            passwordHash:value
        };
    }
 /**
 * generates random string for salting.
 * Argument defines length of salt
 */
// exports.generateSalt= function(len){
//     return crypto.randomBytes(Math.ceil(len/2))
//         .toString('hex')
//         .slice(0, len)
// };