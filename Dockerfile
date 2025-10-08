# Use the Node.js 14 environment
FROM node:14-buster

# Set the working directory
WORKDIR /app

# Copy package files and install all dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy the rest of the application source code
COPY . .

# Expose a default port (Render will override this)
EXPOSE 10000

# This CMD syntax ensures the $PORT variable is correctly used by the shell
CMD sh -c "yarn ember serve --port $PORT --host 0.0.0.0 --live-reload=false"
