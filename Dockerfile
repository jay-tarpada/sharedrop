# Use the Node.js 14 environment
FROM node:14-buster

# Set the working directory
WORKDIR /app

# Copy package files and install all dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy the rest of the application source code
COPY . .

# Expose the port that the Ember dev server uses (default is 4200)
EXPOSE 4200

# Start the development server, making it accessible
# from outside the container on the port Render provides.
CMD ember serve --port $PORT --host 0.0.0.0
