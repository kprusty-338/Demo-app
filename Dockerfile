# Ultra-simple single-stage Dockerfile
FROM node:20-alpine

WORKDIR /app

# Copy & install backend first (for caching)
COPY backend/package*.json ./backend/
RUN cd backend && npm ci --only=production

# Copy backend source
COPY backend/ ./backend/

# Copy frontend, build into backend/public
COPY frontend/package*.json ./frontend/
RUN cd frontend && npm ci && npm run build
RUN mkdir -p backend/public && cp -r frontend/dist/* backend/public/ || true

# Install backend path module if needed (already there)
EXPOSE 3000

WORKDIR /app/backend
CMD ["npm", "start"]
