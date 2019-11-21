var express = require('express');
var router = express.Router();
const passport = require('passport');

router.post('/', passport.authenticate('local-login', {
  successRedirect: '/workshops',
  failureRedirect: '/login',
  failureFlash: true
}));

module.exports = router;
