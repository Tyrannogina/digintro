var express = require('express');
var router = express.Router();
var passport = require('passport');
var url = require('url');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'ejs' });
});

router.get('/login',  function(req, res) {
  console.log(req);
    // If this function gets called, authentication was successful.
    // `req.user` contains the authenticated user.
    //res.redirect('/users/' + req.user.userUUID);
});

module.exports = router;
