const express = require('express');
const helmet = require('helmet');
const path = require('path');
const app = express();

app.use(helmet());

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

module.exports = app;
// app.listen(8000, () => console.log('Running on http://localhost:8000'));
