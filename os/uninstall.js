const express = require('express');
const helmet = require('helmet');
const path = require('path');
const app = express();

app.use(helmet());

app.get('/os/uninstall', (req, res) => {
  res.contentType('text/plain');
  res.sendFile(path.join(__dirname, 'uninstall.sh'));
});

module.exports = app;
