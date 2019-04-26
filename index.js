const express = require('express');
const helmet = require('helmet');
const path = require('path');
const app = express();
// const os = require('./os/index');
// app.use(os);
// add some security-related headers to the response
app.use(helmet());

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

app.get('/app.css', (req, res) => {
  res.sendFile(path.join(__dirname, 'app.css'));
});

app.get('/font.css', (req, res) => {
  res.sendFile(path.join(__dirname, 'font.css'));
});

app.get('/vendor.css', (req, res) => {
  res.sendFile(path.join(__dirname, 'vendor.css'));
});

module.exports = app;
// app.listen(8000, () => console.log('Running on http://localhost:8000'));
