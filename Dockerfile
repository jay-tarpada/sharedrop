# Use the Node.js 14 environment
FROM node:14-buster

# Set the working directory
WORKDIR /app

# Copy package files and install all dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy the rest of the application source code
COPY . .

# Expose the port that the Ember dev server uses
EXPOSE 4200

# Start the development server using yarn,
# making it accessible on the port Render provides.
# We also disable live-reload as it's not needed in production.
CMD ["yarn", "ember", "serve", "--port", "$PORT", "--host", "0.0.0.0", "--live-reload=false"]
