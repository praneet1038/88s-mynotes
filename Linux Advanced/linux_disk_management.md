
### Linux disk management
File system hierarchy 

How to add extra disk to a running EC2 instance?

Create EBS volume
Attach EBS volume to EC2 instance
Create partitions in the EBS volume
Mount the volume to a directory  - temporary
To mount permanently - use UUID 
Note the UUID of the block or new volume attached
add to fstab
mount -a
Automate this with ansible


Extend current EBS disk to 30 GB
modify in the AWS Instance

## Grow partition 
`growpart /dev/nvem1n1 1`
Mount grown partition 
`xfs_growfs /data`

`df -hT /data`

### Memory management commands

## Check hard disk for directories mounted, usage , (h is human readable format) 
`df -hT` 

## Ram usage
`free -m`
`free -h`
Mi is MB
Swap is virtual RAM

## current running processes consuming memory cpu
`top`

## htop (human readable format) has to be installed
`dnf install htop -y`
`htop`

## top 10 processes consuming memory
`ps aux --sort -rss | head -10`

## folder consumption within another directory
`df -hT`
`du -sh *`

### CPU Utilization (Explain)

