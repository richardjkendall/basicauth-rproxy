# basicauth-rproxy
Apache httpd configured as a reverse proxy.  It protects the upstream service using basic auhthentication.  The usernames and passwords for are stored in a DynamoDB table.

This is packaged as a Docker container and it is available here https://hub.docker.com/r/richardjkendall/basicauth-rproxy-perpath

This is based on the pam-dynamo module (which provides a PAM interface to usernames/passwords stored in DynamoDB).  The base image of this is here https://hub.docker.com/r/richardjkendall/ubuntu-pam-dynamo

This version protects the root of the backend with basic authentication.  If you need to be able to protect only specific paths then you should use this version https://github.com/richardjkendall/basicauth-rproxy-perpath

## Configuration
The container uses a number of environment variables to pass in configuration.  They are defined below:

|Variable|Purpose|Example|
|---|---|---|
|UPSTREAM|The backend service that requests should be sent to.  Should only be the DNS name/IP address and port + a trailing slash, no scheme.  Only supports HTTP backends|server:port/
|REGION|The AWS region containing the DynamoDB table with the usernames and passwords.  Can be any valid AWS region.|ap-southeast-2|
|TABLE|The name of the DynamoDB table containing the usernames and passwords.|basicAuthUsers|
|REALM|The name of the realm being used for this deployment|test|
|CACHE_FOLDER|The path of the folder being used to store the user cache|/tmp/cache|
|CACHE_DURATION|The duration of the caching in seconds|120|

### DynamoDB table
The expected structure and content of the DynamoDB table is here https://github.com/richardjkendall/pam-dynamo

