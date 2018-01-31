var router = require('express').Router();
var TYPES = require('tedious').TYPES;

var fs = require('fs');

router.get('/preparationdeal/', function (req, res) {
    var sql = fs.readFileSync('./sql/preparationdeal.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/preparationdeal/:dealid', function (req, res) {
    var dealid = decodeURI(req.params.dealid);
    try {
        var sql = fs.readFileSync('./sql/deal/preparationdeal-byid.sql').toString();
        req.query(sql)
            .param('dealid', dealid, TYPES.VarChar)
            .into(res, '[]');
    } catch (err) {
        console.log(err);
    }

});

router.get('/preparationdeal-credit-audit/:dealid', function (req, res) {
    var dealid = decodeURI(req.params.dealid);
    var sql = fs.readFileSync('./sql/deal/preparationdeal-deal-credit-audit.sql').toString();
    req.query(sql)
        .param('dealid', dealid, TYPES.VarChar)
        .into(res, '[]');
});

router.get('/preparationdeal-auto-text/', function (req, res) {
    var sql = fs.readFileSync('./sql/deal/preparationdeal.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/preparationdeal-consumption/:dealid', function (req, res) {
    var dealid = decodeURI(req.params.dealid);
    var sql = fs.readFileSync('./sql/deal/preparationdeal-consumption.sql').toString();
    req.query(sql)
        .param('dealid', dealid, TYPES.VarChar)
        .into(res, '[]');
});


module.exports = router;