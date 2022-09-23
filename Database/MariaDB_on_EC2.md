# Creating EC2 Instance and Installing , Connecting , Configuring and Manipulating  MariaDB Server

# Launch EC2 Instance.

# AMI: Amazon Linux 2
# Instance Type: t2.micro
# Security Group
#   - SSH           -----> 22    -----> Anywhere
#   - MYSQL/Aurora  -----> 3306  -----> Anywhere

# Connect to EC2 instance with SSH.

sudo yum update -y                     # Update yum package management and install MariaDB server.
sudo yum install mariadb-server -y



