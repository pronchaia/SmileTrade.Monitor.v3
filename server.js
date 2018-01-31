const express = require('express');
const tediousExpress = require('express4-tedious');
const config = require('config');
const app = express();
const port = process.env.PORT || 5000;


app.use(function (req, res, next) {
    req.query = tediousExpress(req, config.get('connection'));
    next();
});


app.get('/api/hello', (req, res) => {
    res.send({ express: 'Hello From Express' });
});

app.use('/api', require('./api/dashboard'));
app.use('/api', require('./api/systracer'));
app.use('/api', require('./api/creditemail'));
app.use('/api', require('./api/deal'));


app.listen(port, () => console.log('Listening on port ${port}'));