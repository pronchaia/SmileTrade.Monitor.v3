var router = require('express').Router();
var TYPES = require('tedious').TYPES;

var fs = require('fs');

router.get('/systracer-table/', function (req, res) {
    var sql = fs.readFileSync('./sql/systracer-table.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

module.exports = router;