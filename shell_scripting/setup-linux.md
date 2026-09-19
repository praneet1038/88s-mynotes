- Setting up Linux environment...

### Run a small & fast linux(Alpine) container in docker to test the script
`docker run --rm -it --name alpine-dev alpine:latest sh`

### mount a folder from the host to the container
`docker run --rm -it -v /path/to/host/folder:/path/in/container alpine:latest sh`
`docker run --rm -it --name linux-dev -v "${PWD}:/workspace" -w /workspace ubuntu:24.04 bash`

# Inside the container, you can run the following commands to set up your environment:


# Update package list & Install necessary packages
`sudo apt update
sudo apt install -y git vim curl wget
echo "Linux setup complete!"`