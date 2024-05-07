# Use official Node.js image as the base image
FROM node:14

# Set working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application code to the container
COPY . .

# Expose the port that your app runs on
EXPOSE 3000

# Command to run the application
CMD ["node", "index.js"]
