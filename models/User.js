const Sequelize = require('sequelize');
const Role = require('./Role')

const connection = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD,
{
  host: process.env.DB_HOST,
  dialect: 'mariadb'
})

const User = connection.define('users',{
  userID:{
    type: Sequelize.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  userUUID: Sequelize.TEXT,
  firstName: Sequelize.TEXT,
  lastName: Sequelize.TEXT,
  emailAddress: Sequelize.TEXT,
  password: Sequelize.TEXT,
  roleID: Sequelize.INTEGER,
  createdAt: Sequelize.DATE,
  deletedAt: Sequelize.DATE,
});

User.belongsTo(Role, {foreignKey: 'roleID'})

// Syncing all our model to our DB
connection.sync().then(()=>{
  console.log("Connected to DB");
})

module.exports = User; // Exporting our user model
