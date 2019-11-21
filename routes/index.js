const express = require('express');
const router = express.Router();
const passport = require('passport');
const url = require('url');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'ejs' });
});

router.get('/login', function(req, res) {
  res.render('login', { title: 'ejs'});
    // If this function gets called, authentication was successful.
    // `req.user` contains the authenticated user.
    //res.redirect('/users/' + req.user.userUUID);
});
router.get('/workshop', function(req, res, next) {
  res.render('workshop', { title: 'ejs' });
});
router.get('/workshops', function(req, res, next) {
  res.render('workshops', { title: 'ejs' });
});

module.exports = router;
