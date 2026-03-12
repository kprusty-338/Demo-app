# Fixed simple Dockerfile for full-stack app (absolute WORKDIR paths, correct backend copy/build)
FROM node:20-alpine AS builder

WORKDIR /workspace/frontend
COPY frontend/package*.json ./
RUN npm ci
COPY frontend/ ./
RUN npm run build

FROM node:20-alpine

WORKDIR /app
COPY backend/package*.json ./
RUN npm ci --only=production
COPY backend/ ./ 
COPY --from=builder /workspace/frontend/dist ./public

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost:3000/health || exit 1

CMD ["npm", "start"]
