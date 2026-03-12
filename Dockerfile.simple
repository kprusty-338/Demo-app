# Simplest possible Dockerfile for the full-stack app
FROM node:20-alpine

WORKDIR /app

# Copy all project files
COPY . .

# Install frontend deps and build
RUN cd frontend && npm install && npm run build

# Install backend deps
RUN cd backend && npm install

# Move frontend build to backend public
RUN mkdir -p backend/public && cp -r frontend/dist/* backend/public/ || true

# Serve from backend
WORKDIR /app/backend
EXPOSE 3000

CMD ["npm", "start"]
