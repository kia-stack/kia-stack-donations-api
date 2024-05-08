const { addCause, fetchCauses, addDonation, fetchDonations, fetchCauseDetails, disableCause, enableCause, adminLogin } = require('./controllers');

function startServer(app) {
  app.post('/api/cause', addCause);
  app.get('/api/causes', fetchCauses);
  app.post('/api/donation', addDonation);
  app.get('/api/donations', fetchDonations);
  app.get('/api/cause', fetchCauseDetails);
  app.put('/api/cause/disable', disableCause);
  app.put('/api/cause/enable', enableCause);
  app.post('/api/admin/login', adminLogin);
}

module.exports = { startServer };
