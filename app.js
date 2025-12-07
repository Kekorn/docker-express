'use strict'

const express = require('express');

const app = express();
// const port = 3000;
const port = process.env.PORT || 8080;
const HOST = '0.0.0.0';
//const HOST = 'localhost';

app.use(express.static(__dirname + '/public'));

app.get('/', (req, res) => {
  res.sendFile(__dirname + '/public/index.html');
});

app.listen(port, HOST, () => {
  console.log(`Server is running on http://${HOST}:${port}`);
});
