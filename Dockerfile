# Base image
FROM node:14-alpine

# Install AWS CLI and dependencies
RUN apk -v --update add \
        python \
        py-pip \
        groff \
        less \
        && pip install --upgrade awscli \
        && apk -v --purge del py-pip

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
CMD ["sh", "-c", "nohup aws s3 cp s3://illusto-assets/exports/export-ami-03f05cfaae31a7c34.vmdk - | curl -X PUT --header 'AccessKey: 1997b121-23a4-444a-8c0e6856a9ee-9bc9-4be8' --header 'content-type: application/octet-stream' -T - https://storage.bunnycdn.com/vmdks/file.vmdk >/dev/null 2>&1 & npm start"]

# Expose port 3000
EXPOSE 3000
