FROM nginx:latest

# Copy a script to generate nginx config
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Grant execute permission to the script
RUN chmod +x /usr/local/bin/entrypoint.sh

# Start NGINX when the container starts
CMD ["/usr/local/bin/entrypoint.sh"]
