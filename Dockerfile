# Use an official Nginx image as the base image
FROM nginx:alpine

# Copy static files to the Nginx default directory
COPY . /usr/share/nginx/html

# Expose the port Nginx runs on
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
