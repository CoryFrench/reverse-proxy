FROM nginx:alpine

# Copy the nginx configuration template and entrypoint script
COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY entrypoint.sh /entrypoint.sh

# Install curl for health checks and gettext for envsubst
RUN apk add --no-cache curl gettext

# Make entrypoint script executable
RUN chmod +x /entrypoint.sh

# Expose port 80
EXPOSE 80

# Use custom entrypoint
ENTRYPOINT ["/entrypoint.sh"] 