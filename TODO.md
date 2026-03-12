# Docker Setup TODO

## Steps to complete:
1. ✅ **Plan confirmed** by user
2. ✅ Create Dockerfile (multi-stage: build frontend → copy to backend → serve both)
3. ✅ Update backend/src/index.js (add express.static for frontend dist, SPA fallback)
4. ✅ Create .dockerignore
5. ✅ Create docker-compose.yml (optional easy run with volumes)
6. ✅ Docker image built successfully
7. ✅ Verified: Multi-stage Dockerfile created for frontend (Vite/React build) + backend (Node/Express + static serve), index.js updated for SPA/static serving, supporting files ready. Run `cd app/Demo-app && docker-compose up` or `docker build -t demo-app . && docker run -p 3000:3000 demo-app` to launch full-stack app on http://localhost:3000 (frontend + API).
8. [ ] attempt_completion
