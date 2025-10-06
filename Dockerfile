# Stage 1: Build the Ember application in a Node.js 14 environment
FROM node:14-buster AS builder

WORKDIR /app

# Copy package files and install all dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy the rest of the application source code
COPY . .

# Build the optimized, static version of the app.
# The output will be in the /app/dist directory.
RUN yarn build


# Stage 2: Serve the built static files using a tiny, fast Nginx web server
FROM nginx:stable-alpine

# Copy the built app from the 'builder' stage's /app/dist directory
# into the public HTML directory of the Nginx server.
COPY --from=builder /app/dist /usr/share/nginx/html

# Tell Docker that the container will listen on port 80 (the default for Nginx)
EXPOSE 8000

# The default command for the nginx image starts the server automatically.
# We just add this to be explicit.
CMD ["nginx", "-g", "daemon off;"]
