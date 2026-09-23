- Setup up RHEL Linux environment...
- Use Red Hat Universal Base Image (UBI). It is based on RHEL, freely redistributable, and works with Docker without a Red Hat subscription. The full RHEL image and Red Hat support may require a subscription, but UBI is suitable for local development.

run this command if the container should be deleted automatically on exit
`docker run --rm -it --name rhel-dev registry.access.redhat.com/ubi9/ubi bash`  
run this command if the container should persist
`docker run -it --name rhel-dev registry.access.redhat.com/ubi9/ubi bash`  

- Setup up Alpine Linux environment...

### Run a small & fast linux(Alpine) container in docker to test the script
`docker run --rm -it --name alpine-dev alpine:latest sh`

### mount a folder from the host to the container
`docker run --rm -it -v /path/to/host/folder:/path/in/container alpine:latest sh`
`docker run --rm -it --name linux-dev -v "${PWD}:/workspace" -w /workspace ubuntu:24.04 bash`

# Inside the container, you can run the following commands to set up your environment:


# Update package list & Install necessary packages Alpine
`sudo apt update
sudo apt install -y git vim curl wget
echo "Linux setup complete!"`