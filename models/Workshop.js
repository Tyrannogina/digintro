const Sequelize = require('sequelize');

const connection = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD,
{
  host: process.env.DB_HOST,
  dialect: 'mariadb'
})

const Workshop = connection.define('workshops',{
  workshopID:{
    type: Sequelize.INTEGER, // All dataTypes format available here http://bit.ly/2ofwgAm
    primaryKey: true,
    autoIncrement: true
  },
  videoLink: Sequelize.TEXT,
  name: Sequelize.TEXT,
  description: Sequelize.TEXT,
  status: Sequelize.TEXT
});

// Syncing all our model to our DB
connection.sync().then(()=>{
  console.log("Connected to DB");
})

module.exports = Workshop; // Exporting our user model
