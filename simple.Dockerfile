# Minimal Dockerfile for full-stack app (Nginx for frontend + Node backend in one container)
FROM node:20-slim as backend
WORKDIR /app
COPY backend/package*.json .
RUN npm ci --production
COPY backend/ .
EXPOSE 3001
CMD ["npm", "start"]

FROM nginx:alpine
COPY --from=backend /app /app/backend
COPY frontend/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
