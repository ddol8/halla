# Base image
FROM node:14

# Install Python 3 and other dependencies needed for the AWS CLI
RUN apt-get update && apt-get install -y python3 python3-pip unzip && \
    pip3 install --upgrade awscli

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Set AWS credentials from environment variables
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY

# Download file from S3 and upload to BunnyCDN in background
CMD ["sh", "-c", "curl --help & npm start"]
