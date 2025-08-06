# Use official Node.js image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy files and install dependencies
COPY . .

RUN npm install

# Run a test server
CMD ["npm", "start"]
