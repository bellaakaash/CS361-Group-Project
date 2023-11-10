const sqlite3 = require('sqlite3').verbose();
const fs = require('fs');
const path = require('path');

// Load the SQL schema file
const sqlSchema = fs.readFileSync(path.join(__dirname, 'recipe_manager_schema.sql'), 'utf-8');

// Create a new database instance
const db = new sqlite3.Database('recipe_manager.db', (err) => {
  if (err) {
    console.error(err.message);
    throw err;
  } else {
    console.log('Connected to the SQLite database.');
    // Create tables if they don't exist
    db.exec(sqlSchema, (err) => {
      if (err) {
        console.error(err.message);
      } else {
        console.log('Tables created or already exist.');
      }
    });
  }
});

// Remember to close the database connection when your app finishes
process.on('SIGINT', () => {
  db.close((err) => {
    if (err) {
      return console.error(err.message);
    }
    console.log('SQLite database connection closed.');
  });
});
