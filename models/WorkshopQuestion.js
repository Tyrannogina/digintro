const Sequelize = require('sequelize');
const Workshop = require('./Workshop')

const connection = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD,
{
  host: process.env.DB_HOST,
  dialect: 'mariadb'
})

const WorkshopQuestion = connection.define('workshops',{
  workshopQuestionID:{
    type: Sequelize.INTEGER, // All dataTypes format available here http://bit.ly/2ofwgAm
    primaryKey: true,
    autoIncrement: true
  },
  workshopID: Sequelize.INTEGER,
  description: Sequelize.TEXT
});

WorkshopQuestion.belongsTo(Workshop, {foreignKey: 'workshopID'});

// Syncing all our model to our DB
connection.sync().then(()=>{
  console.log("Connected to DB");
})

module.exports = WorkshopQuestion; // Exporting our user model
