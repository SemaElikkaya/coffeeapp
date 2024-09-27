const app = require('./app');
const port = process.env.PORT || 3000;

app.use((req, res, next) => {
  resetInactivityTimer();
  next();
});

let inactivityTimeout;
const INACTIVITY_LIMIT = 10 * 60 * 1000;

function resetInactivityTimer() {
  if (inactivityTimeout) {
    clearTimeout(inactivityTimeout);
  }
  inactivityTimeout = setTimeout(() => {
    console.log('Server is shutting down due to inactivity.');
    process.exit(0);
  }, INACTIVITY_LIMIT);
}

resetInactivityTimer();

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});