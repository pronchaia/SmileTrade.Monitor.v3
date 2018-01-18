var router = require('express').Router();
var TYPES = require('tedious').TYPES;

var fs = require('fs');

router.get('/preparationdeal-percentage/', function (req, res) {
    var sql = fs.readFileSync('./sql/dashboard/preparationdeal-percentage.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/consumption-percentage/', function (req, res) {
    var sql = fs.readFileSync('./sql/dashboard/consumption-percentage.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/preparationdeal/', function (req, res) {
    var sql = fs.readFileSync('./sql/preparationdeal.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/preparationdeal-timeline/', function (req, res) {
    var sql = fs.readFileSync('./sql/preparationdeal-timeline.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/preparationdeal-timeline-currently/', function (req, res) {
    var sql = fs.readFileSync('./sql/preparationdeal-timeline-currently.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/preparationdeal-status/', function (req, res) {
    var sql = fs.readFileSync('./sql/dashboard/preparationdeal-status.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/preparationdeal-counterparty/', function (req, res) {
    var sql = fs.readFileSync('./sql/preparationdeal-counterparty.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/lastbacthcreditlog/', function (req, res) {
    var sql = fs.readFileSync('./sql/lastbacthcreditlog.sql').toString();
    req.query(sql)
        .into(res, '{}');
});

router.get('/bacthcreditlog/', function (req, res) {
    var sql = fs.readFileSync('./sql/bacthcreditlog.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/credit_verification_report/', function (req, res) {
    var sql = fs.readFileSync('./sql/credit_verification_report.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/staparty-percentage/', function (req, res) {
    var sql = fs.readFileSync('./sql/dashboard/staparty-percentage.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/deal-today-percentage/', function (req, res) {
    var sql = fs.readFileSync('./sql/dashboard/deal-today-percentage.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/backgroundjob-days/', function (req, res) {
    var sql = fs.readFileSync('./sql/dashboard/backgroundjob-days.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/backgroundjob-sap/', function (req, res) {
    var sql = fs.readFileSync('./sql/dashboard/backgroundjob-sap.sql').toString();
    req.query(sql)
        .into(res, '[]');
});

router.get('/backgroundjob-morning/', function (req, res) {
    var sql = fs.readFileSync('./sql/dashboard/backgroundjob-morning.sql').toString();
    req.query(sql)
        .into(res, '[]');
});


module.exports = router;