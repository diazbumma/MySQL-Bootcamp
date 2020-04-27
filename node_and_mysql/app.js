let faker = require('faker');
let mysql = require('mysql');

let connection = mysql.createConnection({
  host      : 'localhost',
  user      : 'root',
  password  : 'develpass',
  database  : 'join_us'
});

/* Faker example
function generateAddress() {
  console.log(faker.address.streetAddress());
  console.log(faker.address.city());
  console.log(faker.address.state());
}

generateAddress();
generateAddress();
*/

/* MySQL node js lib example
let q = 'SELECT COUNT(*) AS count FROM users';

connection.query(q, function(error, results, fields){
  if (error) throw error;
  console.log(results);
});
*/

let q = 'INSERT INTO users VALUES ?';
/*
let person = {
  email: faker.internet.email(),
  created_at: faker.date.past()
};
*/

let data = [];

for (let i = 0; i < 500; i++) {
  data.push([
    faker.internet.email(),
    faker.date.past()
  ]);
}

//console.log(data);

connection.query(q, [data], function(error, results, fields){
  if (error) throw error;
  console.log(results);
});

connection.end();
