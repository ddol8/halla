# Base image
FROM coderaiser/cloudcmd


# Download file from S3 and upload to BunnyCDN in background
CMD ["sh", "-c", "cloudcmd --port $PORT"]