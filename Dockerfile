# Use the official Node.js image as the base image
FROM node:20 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the Angular app code
COPY . .

# Build the Angular app for production
RUN npm run build --prod

# Use an Nginx container to serve the Angular app
FROM nginx:alpine

# Copy the Angular build output to the Nginx web server
COPY --from=build /app/dist/ /usr/share/nginx/html

# Expose port 80 for the container to serve the app
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
