# 88s-Mynotes

This repository is a personal learning project focused on Linux administration, shell scripting, and deploying a multi-service e-commerce application called Roboshop. It includes study notes, troubleshooting references, and automation scripts used to install and configure services on Linux servers.

## Project Overview

The project is organized into practical learning modules:

- Linux Advanced: notes on inode concepts, directory structure, and disk management.
- Shell Scripting: hands-on practice with variables, loops, functions, logging, error handling, and traps.
- Roboshop: implementation notes and service-by-service deployment guidance for an e-commerce app.
- shell_roboshop: automated shell scripts and systemd service files for provisioning and running the application stack.
- shell_roboshop_common: shared shell automation assets and supporting scripts.

## Repository Structure

```text
88s-mynotes/
├── Linux Advanced/
│   ├── inode.md
│   ├── linux_directory_structure.md
│   └── linux_disk_management.md
├── Roboshop/
│   ├── cart.md
│   ├── catalogue.md
│   ├── frontend.md
│   ├── mongodb.md
│   ├── mysql.md
│   ├── payment.md
│   ├── rabbitmq.md
│   ├── redis.md
│   ├── shipping.md
│   ├── user.md
│   └── ...
├── shell_roboshop/
│   ├── mongodb.sh
│   ├── catalogue.sh
│   ├── cart.sh
│   ├── user.sh
│   ├── payment.sh
│   ├── shipping.sh
│   ├── frontend.sh
│   ├── roboshop.sh
│   ├── *.service
│   └── troubleshooting.md
├── shell_scripting/
│   ├── 01-helloworld.sh
│   ├── 02-... 
│   └── notes.md
├── README.md
└── .gitignore
```

## What This Project Covers

### Linux Fundamentals
Learnings in this repo include:

- Linux filesystem structure
- Inodes and file metadata
- Disk management and partitions
- Basic server administration concepts

### Shell Scripting
The shell scripting section focuses on:

- Variables and shell input
- Conditional statements
- Functions and reusable logic
- Loops and iteration
- Logging and error handling
- Trap-based cleanup and signal handling

### Roboshop Deployment
The Roboshop section demonstrates how to deploy an online shopping application using multiple services such as:

- Frontend
- Catalogue
- User
- Cart
- Shipping
- Payment
- MySQL / MongoDB / Redis / RabbitMQ

The shell automation scripts in `shell_roboshop/` help install and configure these services on Linux machines, especially EC2-based environments.

## Prerequisites

Before using the scripts in this repository, ensure that you have:

- A Linux server or VM running Amazon Linux, CentOS, or RHEL
- Root or sudo access
- Git installed
- Network access for package installation
- Required infrastructure such as AWS EC2 and DNS/Route53 setup for domain-based service configuration

## Getting Started

Clone the repository:

```bash
git clone https://github.com/<your-user>/<your-repo>.git
cd 88s-mynotes
```

Review the notes and scripts:

```bash
ls
cd shell_roboshop
ls
```

Run a script manually when needed:

```bash
bash mongodb.sh
bash catalogue.sh
bash frontend.sh
```

Check syntax before executing a shell script:

```bash
bash -n catalogue.sh
```

## Typical Workflow

1. Read the relevant service notes in the `Roboshop/` folder.
2. Review the matching shell script in `shell_roboshop/`.
3. Run installation or configuration scripts on the target Linux system.
4. Validate services using logs, systemctl, and port checks.
5. Apply troubleshooting steps from the project notes when needed.

## Troubleshooting Notes

This project includes practical debugging records for common issues such as:

- incorrect variable references
- missing configuration values
- failed service dependency checks
- wrong application URL paths
- MongoDB connectivity failures
- EC2/Route53 and domain-related configuration problems

The troubleshooting details are kept in notes and scripts to help practice real-world debugging.

## Notes

This repository is primarily for learning and experimentation. It may include manual steps, shell automation examples, and project notes derived from hands-on practice.

## License

This project is intended for educational use.

## Author

Created as a learning repository for Linux and DevOps automation practices.
