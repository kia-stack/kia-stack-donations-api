const { connection } = require('./databaseConfig');
const { generateRandomString } = require('./utils');

function addCause(req, res) {
  const { name } = req.body;
  const apiKey = generateRandomString(16);

  const query = `INSERT INTO Causes (name, apiKey) VALUES (?, ?)`;
  connection.query(query, [name, apiKey], (error, results, fields) => {
    if (error) {
      console.error('Error adding cause:', error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(201).json({ message: 'Cause added successfully' });
  });
}

function fetchCauses(req, res) {
  const query = 'SELECT * FROM Causes';
  connection.query(query, (error, results, fields) => {
    if (error) {
      console.error('Error fetching causes:', error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(200).json(results);
  });
}

function addDonation(req, res) {
  const { cause_id, name, email, amount } = req.body;
  const query = `INSERT INTO Donations (cause_id, name, email, amount) VALUES (?, ?, ?, ?)`;
  connection.query(query, [cause_id, name, email, amount], (error, results, fields) => {
    if (error) {
      console.error('Error adding donation:', error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(201).json({ message: 'Donation added successfully' });
  });
}

function fetchDonations(req, res) {
  const query = 'SELECT * FROM Donations';
  connection.query(query, (error, results, fields) => {
    if (error) {
      console.error('Error fetching donations:', error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(200).json(results);
  });
}

function fetchCauseDetails(req, res) {
  const { id } = req.query;
  const { authorization } = req.headers;

  if (!authorization) {
    return res.status(403).json({ error: 'Authorization header is missing' });
  }

  const accessToken = authorization.split('Bearer ')[1];

  const tokenQuery = `SELECT apiKey FROM Causes WHERE apiKey = ? AND cause_id = ?`;
  connection.query(tokenQuery, [accessToken, id], (tokenError, tokenResults) => {
    if (tokenError) {
      console.error('Error validating access token:', tokenError);
      return res.status(500).json({ error: 'Internal server error' });
    }

    if (tokenResults.length === 0) {
      return res.status(403).json({ error: 'Invalid access token/ cause not found' });
    }

    const causeQuery = `
      SELECT 
        SUM(amount) AS raised,
        Causes.isDisabled AS disabled
      FROM 
        Donations 
      INNER JOIN 
        Causes 
      ON 
        Donations.cause_id = Causes.cause_id 
      WHERE 
        Donations.cause_id = ?`;

    connection.query(causeQuery, [id], (error, results) => {
      if (error) {
        console.error('Error fetching cause details:', error);
        return res.status(500).json({ error: 'Internal server error' });
      }

      const { raised, disabled } = results[0];
      const response = {
        raised: raised || 0,
        disabled: disabled === 1
      };

      res.status(200).json(response);
    });
  });
}

function disableCause(req, res) {
  const { id } = req.body;
  const updateQuery = `UPDATE Causes SET isDisabled = 1 WHERE cause_id = ?`;
  connection.query(updateQuery, [id], (error, results) => {
    if (error) {
      console.error('Error updating cause:', error);
      return res.status(500).json({ error: 'Internal server error' });
    }

    if (results.affectedRows === 0) {
      return res.status(404).json({ error: 'Cause not found' });
    }

    res.status(200).json({ message: 'Cause disabled successfully' });
  });
}

function enableCause(req, res) {
  const { id } = req.body;
  const updateQuery = `UPDATE Causes SET isDisabled = 0 WHERE cause_id = ?`;
  connection.query(updateQuery, [id], (error, results) => {
    if (error) {
      console.error('Error updating cause:', error);
      return res.status(500).json({ error: 'Internal server error' });
    }

    if (results.affectedRows === 0) {
      return res.status(404).json({ error: 'Cause not found' });
    }

    res.status(200).json({ message: 'Cause enabled successfully' });
  });
}

function adminLogin(req, res) {
  const { username, password } = req.body;
  const query = `SELECT * FROM Admins WHERE username = ? AND password = ?`;
  connection.query(query, [username, password], (error, results, fields) => {
    if (error) {
      console.error('Error logging in admin:', error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (results.length > 0) {
      res.status(200).json({ message: 'Admin login successful' });
    } else {
      res.status(401).json({ error: 'Invalid username or password' });
    }
  });
}

module.exports = { addCause, fetchCauses, addDonation, fetchDonations, fetchCauseDetails, disableCause, enableCause, adminLogin };
