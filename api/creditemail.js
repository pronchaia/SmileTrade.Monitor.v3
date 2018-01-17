var router = require('express').Router();
var TYPES = require('tedious').TYPES;

var fs = require('fs');

router.get('/credit-email-inbox/', function (req, res) {
    var sql = fs.readFileSync('./sql/credit-email.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

module.exports = router;