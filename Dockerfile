# Use Node official image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy only package files first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy rest of the app
COPY . .

# ✅ Fix permissions for react-scripts
RUN chmod +x node_modules/.bin/react-scripts

# Build React app
RUN npm run build

# Install serve to serve build folder
RUN npm install -g serve

# Expose default React port
EXPOSE 3000

# Run the production build using serve
CMD ["serve", "-s", "build"]

