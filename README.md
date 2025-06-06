# Microservices Platform

A complete microservices ecosystem with API gateway and reverse proxy, featuring multiple independent services.

## Architecture

This platform uses a **polyrepo approach with Git submodules**, where each service is maintained in its own repository but orchestrated together for easy deployment.

### Services

- **reverse-proxy** - Nginx-based API gateway and reverse proxy
- **chatgpt-daily-server** - ChatGPT Daily GPT Server (port 14000)
- **agent-directory** - Agent Directory Service (port 14100)
- **calendar-backend** - Calendar Backend API (port 14201)
- **calendar-frontend** - Calendar Frontend Application (port 14202)

## Quick Start

### Initial Setup
```bash
# Clone with all submodules
git clone --recursive https://github.com/yourusername/microservices-platform.git
cd microservices-platform

# If you already cloned without --recursive:
git submodule update --init --recursive
```

### Start All Services
```bash
docker-compose up -d
```

### Access Points
- **Gateway Dashboard**: http://localhost
- **Alternative Gateway Port**: http://localhost:8080
- **Individual Services**: Available through `/api/{service-name}/` routes

## Development Workflow

### Working on a Specific Service
```bash
# Navigate to service directory
cd reverse-proxy  # or any other service

# Make changes, commit, and push
git add .
git commit -m "Your changes"
git push origin main

# Return to platform root and update submodule reference
cd ..
git add reverse-proxy
git commit -m "Update reverse-proxy to latest"
git push origin main
```

### Adding New Services
1. Create new service repository
2. Add as submodule: `git submodule add https://github.com/yourusername/new-service.git new-service`
3. Update docker-compose.yml to include the new service
4. Update reverse-proxy configuration if needed

### Updating All Services
```bash
git submodule update --remote --merge
git add .
git commit -m "Update all services to latest"
git push origin main
```

## Repository Structure

```
microservices-platform/
├── reverse-proxy/           (submodule)
├── chatgpt-daily-server/    (submodule)
├── agent-directory/         (submodule)
├── calendar-backend/        (submodule)
├── calendar-frontend/       (submodule)
├── docker-compose.yml       (orchestrates all services)
└── README.md               (this file)
```

## Service URLs

| Service | Direct URL | Gateway URL |
|---------|------------|-------------|
| ChatGPT Daily | http://localhost:14000 | http://localhost/api/chatgpt-daily/ |
| Agent Directory | http://localhost:14100 | http://localhost/api/agent-directory/ |
| Calendar Backend | http://localhost:14201 | http://localhost/api/calendar-backend/ |
| Calendar Frontend | http://localhost:14202 | http://localhost/api/calendar-frontend/ |

## Troubleshooting

### Submodule Issues
```bash
# Reset all submodules to tracked commits
git submodule update --init --recursive

# Pull latest changes for all submodules
git submodule update --remote --merge
```

### Service Issues
- Check if individual services are running: `docker-compose ps`
- View logs: `docker-compose logs [service-name]`
- Restart specific service: `docker-compose restart [service-name]`

## Contributing

Since this is a polyrepo setup:
1. Make changes in the specific service repository
2. Test changes locally
3. Update the platform repository to reference the new service version
4. Document any breaking changes or new requirements 

# Reverse Proxy

Nginx-based API gateway and reverse proxy for the microservices platform.

## Description

This service acts as the central gateway for all microservices in the platform. It handles:
- Request routing to appropriate services
- Load balancing 
- SSL termination (when configured)
- Health checks
- Centralized logging

## Port

- **External**: 80, 8080 (alternative)
- **Routes to**: Various backend services

## Quick Start

```bash
# Build and run with Docker
docker build -t reverse-proxy .
docker run -p 80:80 reverse-proxy

# Or with Docker Compose
docker-compose up -d
```

## Configuration

The reverse proxy is configured via `nginx.conf` and routes requests to:

- `/api/chatgpt-daily/*` → ChatGPT Daily Server (port 14000)
- `/api/agent-directory/*` → Agent Directory (port 14100)
- `/api/calendar-backend/*` → Calendar Backend (port 14201)
- `/api/calendar-frontend/*` → Calendar Frontend (port 14202)
- `/health` → Gateway health check
- `/` → Gateway dashboard

## Health Check

```bash
curl http://localhost/health
```

## Development

This is part of the microservices-platform. See the main platform repository for full setup instructions.

## TODO

- [ ] Add SSL/TLS configuration
- [ ] Implement rate limiting
- [ ] Add authentication middleware
- [ ] Set up monitoring and metrics 