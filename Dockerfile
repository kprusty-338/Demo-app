# Simple single-stage Dockerfile for full-stack app
FROM node:20-alpine

# Install dependencies for frontend build
WORKDIR /tmp/frontend
COPY frontend/package*.json ./
RUN npm install

# Build frontend
COPY frontend/ ./
RUN npm run build

# Setup backend
WORKDIR /app
COPY backend/package*.json ./
RUN npm install --production

COPY backend/ ./backend
RUN mv /tmp/frontend/dist ./public

# Backend entry (serve static + API)
WORKDIR /app/backend
EXPOSE 3000
CMD ["node", "src/index.js"]
