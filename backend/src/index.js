
const express = require('express');
const cors = require('cors');
const path = require('path');
const userRoutes = require('./routes/userRoutes');
const { errorHandler, requestLogger } = require('./middleware');
const { initializeDatabase } = require('./config/database');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors({
  origin: true,
  credentials: true
}));
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));
app.use(requestLogger);

// SPA fallback: catch all non-API routes and serve index.html
app.get(['/', '/login', '/dashboard', '*'], (req, res, next) => {
  if (req.path.match(/^\/api/) || req.path.match(/^\/health/)) {
    return next();
  }
  res.sendFile(path.join(__dirname, 'public/index.html'));
});

// API Routes
app.use('/api/users', userRoutes);

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', message: 'Server is running' });
});

// Error handling middleware
app.use(errorHandler);

// Start server and initialize database
async function startServer() {
  try {
    await initializeDatabase();
    console.log('Database initialized successfully');
    console.log('Full-stack app ready at http://localhost:3000');
    
    app.listen(PORT, () => {
      console.log(`Server running on http://localhost:${PORT}`);
    });
  } catch (error) {
    console.error('Failed to start server:', error);
    process.exit(1);
  }
}

startServer();

module.exports = app;


