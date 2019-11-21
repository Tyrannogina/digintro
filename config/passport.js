const passport = require('passport');
const { Strategy: LocalStrategy } = require('passport-local');
const User = require('../models/User')

passport.serializeUser((user, done) => {
  done(null, user.userID);
});

passport.deserializeUser((userID, done) => {
  User.findByPk(userID).then(user => {
    done(null, user);
  }).catch(err => done(err));
});

passport.use('local-signup', new LocalStrategy({
    usernameField : 'emailAddress',
    passwordField : 'password',
    passReqToCallback : true // allows us to pass back the entire request to the callback
  },
  (req, emailAddress, password, firstName, lastName, done) => {
    // find a user whose email is the same as the forms email
    // we are checking to see if the user trying to login already exists
    connection.query(`SELECT * FROM users WHERE emailAddress LIKE '${emailAddress}';`, (err,rows) => {
      console.log(rows);
      console.log("above row object");
      if (err)
        return done(err);
      if (rows.length) {
        return done(null, false, req.flash('signupMessage', 'That email is already taken.'));
      } else {
        const newUserMysql = {
          emailAddress,
          password,
          firstName,
          lastName
        }

        const insertQuery = `INSERT INTO users ( firstName, lastName, emailAddress, password )
          VALUES ('${firstName}', '${lastName}', '${emailAddress}', '${password}');`;
        console.log(insertQuery);
        connection.query(insertQuery, (err,rows) => {
          newUserMysql.id = rows.insertId;
          return done(null, newUserMysql);
        });
      }
    });
  }
));

/**
 * Sign in using Email and Password.
 *//*
passport.use(new LocalStrategy({ usernameField: 'emailAddress' }, (emailAddress, password, done) => {
  console.log(emailAddress, password)
  /*User.findOne({ email: email.toLowerCase() }, (err, user) => {
    if (err) { return done(err); }
    if (!user) {
      return done(null, false, { msg: `Email ${email} not found.` });
    }
    if (!user.password) {
      return done(null, false, { msg: 'Your account was registered using a sign-in provider. To enable password login, sign in using a provider, and then set a password under your user profile.' });
    }
    user.comparePassword(password, (err, isMatch) => {
      if (err) { return done(err); }
      if (isMatch) {
        return done(null, user);
      }
      return done(null, false, { msg: 'Invalid email or password.' });
    });
  });
}));*/

passport.use('local-login', new LocalStrategy({
    usernameField : 'emailAddress',
    passwordField : 'password',
  },
  (req, emailAddress, password, done) => {
    User.findOne({
      where: {
        'emailAddress': emailAddress
      }
    }).then((user) => {
      if (user == null) {
        return done(null, false, 'User not found.') ;
      }

      if (password == user.password) {
        return done(null, user, 'Password not found.');
      }
      return done(null, false);
    }).catch(err => done(err))
  }
));

/**
 * Login Required middleware.
 */
exports.isAuthenticated = (req, res, next) => {
  if (req.isAuthenticated()) {
    return next();
  }
  res.redirect('/login');
};
