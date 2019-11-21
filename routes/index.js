const express = require('express');
const router = express.Router();
const passport = require('passport');
const url = require('url');
const Workshop = require('../models/Workshop');
const WorkshopQuestion = require('../models/WorkshopQuestion');

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

router.get('/signup', function(req, res) {
  res.render('signup', { title: 'ejs'});
});
router.get('/workshop', function(req, res, next) {
  const workshop = WorkshopQuestion.findOne({ include: [Workshop]})
console.log(workshop);
  res.render('workshop', { title: 'ejs' });
});

router.get('/workshops', function(req, res, next) {
  res.render('workshops', { title: 'ejs' });
});

module.exports = router;
