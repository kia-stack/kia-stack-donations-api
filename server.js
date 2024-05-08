const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { connectToDatabase } = require('./databaseConfig');
const { startServer } = require('./routes');

const app = express();

app.use(bodyParser.json());
app.use(cors());

connectToDatabase();

startServer(app);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
