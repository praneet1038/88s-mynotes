# Install aws-cli on rhel container running locally in docker 
- Setup up RHEL Linux environment...
- Use Red Hat Universal Base Image (UBI). It is based on RHEL, freely redistributable, and works with Docker without a Red Hat subscription. The full RHEL image and Red Hat support may require a subscription, but UBI is suitable for local development.

- run this command if the container should be deleted automatically on exit
`docker run --rm -it --name rhel-dev registry.access.redhat.com/ubi9/ubi bash`  
- run this command if the container should persist
`docker run -it --name rhel-dev registry.access.redhat.com/ubi9/ubi bash`  
This should redirect the prompt to the container 
- install dependencies curl, unzip if not installed
`dnf install -y unzip curl`
- run this command to install aws cli  ([source](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html))
`curl -fsSL https://awscli.amazonaws.com/v2/install.sh | bash`
- Authenticate aws account
`aws configure`
Enter access key id, secret access key & default region (us-east-1). Rest is empty
- Test successful account configuration. Returns s3 bucket list or empty without errors. 
`aws s3 ls`
