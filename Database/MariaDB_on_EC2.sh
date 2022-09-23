# Creating EC2 Instance and Installing , Connecting , Configuring and Manipulating  MariaDB Server

# Launch EC2 Instance.

# AMI: Amazon Linux 2
# Instance Type: t2.micro
# Security Group
#   - SSH           -----> 22    -----> Anywhere
#   - MYSQL/Aurora  -----> 3306  -----> Anywhere

# Connect to EC2 instance with SSH.

sudo yum update -y                     # Update yum package management .
sudo yum install mariadb-server -y     # Install MariaDB server.
sudo systemctl start mariadb           # Start MariaDB service.
sudo systemctl status mariadb          # Check status of MariaDB service.
sudo systemctl enable mariadb          # # Enable MariaDB service, so that MariaDB service will be activated on restarts.


sudo mysql_secure_installation         # Setup secure installation of MariaDB.
mysql -u root                          # Show that you can not log into mysql terminal without password anymore.
mysql -u root -p                       # Connect to the MariaDB Server and open MySQL CLI with root user and password 
USE mysql;
SELECT Host, User, Password FROM user; # List the users defined in the server and show that it has now password and its encrypted.
CREATE DATABASE demodb;                # Create new database named 'demodb'.
SHOW DATABASES;                        # Show newly created database.
CREATE USER demouser IDENTIFIED BY 'demo1234';     # Create a user
GRANT ALL ON clarusdb.* TO clarususer IDENTIFIED BY 'clarus1234' WITH GRANT OPTION;    # Grant permissions to the user
FLUSH PRIVILEGES;                      # Update privileges.
EXIT;














