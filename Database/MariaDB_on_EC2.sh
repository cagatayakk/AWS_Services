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
sudo systemctl enable mariadb          # Enable MariaDB service, so that MariaDB service will be activated on restarts.


sudo mysql_secure_installation         # Setup secure installation of MariaDB.
mysql -u root                          # Show that you can not log into mysql terminal without password anymore.
mysql -u root -p                       # Connect to the MariaDB Server and open MySQL CLI with root user and password 
USE mysql;
SELECT Host, User, Password FROM user; # List the users defined in the server and show that it has now password and its encrypted.
CREATE DATABASE demodb;                # Create new database named 'demodb'.
SHOW DATABASES;                        # Show newly created database.
CREATE USER demouser IDENTIFIED BY 'demo1234';     # Create a user
GRANT ALL ON demodb.* TO demouser IDENTIFIED BY 'demo1234' WITH GRANT OPTION;    # Grant permissions to the user
FLUSH PRIVILEGES;                      # Update privileges.
EXIT;




mysql -u demouser -p                 # Login back as demouser using the password defined.
SHOW DATABASES;
USE clarusdb;                          # Select the database clarusdb.

# Create a table named offices.
CREATE TABLE `offices` (
  `office_id` int(11) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  PRIMARY KEY (`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;        

# Insert some data into the table named offices.
INSERT INTO `offices` VALUES (1,'03 Reinke Trail','Cincinnati','OH');
INSERT INTO `offices` VALUES (2,'5507 Becker Terrace','New York City','NY');
INSERT INTO `offices` VALUES (3,'54 Northland Court','Richmond','VA');
INSERT INTO `offices` VALUES (4,'08 South Crossing','Cincinnati','OH');
INSERT INTO `offices` VALUES (5,'553 Maple Drive','Minneapolis','MN');
INSERT INTO `offices` VALUES (6,'23 North Plaza','Aurora','CO');
INSERT INTO `offices` VALUES (7,'9658 Wayridge Court','Boise','ID');
INSERT INTO `offices` VALUES (8,'9 Grayhawk Trail','New York City','NY');
INSERT INTO `offices` VALUES (9,'16862 Westend Hill','Knoxville','TN');
INSERT INTO `offices` VALUES (10,'4 Bluestem Parkway','Savannah','GA');

# Create a table named employees.
CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `job_title` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `reports_to` int(11) DEFAULT NULL,
  `office_id` int(11) NOT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `fk_employees_offices_idx` (`office_id`),
  CONSTRAINT `fk_employees_offices` FOREIGN KEY (`office_id`) REFERENCES `offices` (`office_id`) ON UPDATE CASCADE) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# Insert some data into the table named employees.
INSERT INTO `employees` VALUES (37270,'Yovonnda','Magrannell','Executive Secretary',63996,NULL,10);
INSERT INTO `employees` VALUES (33391,'Darcy','Nortunen','Account Executive',62871,37270,1);
INSERT INTO `employees` VALUES (37851,'Sayer','Matterson','Statistician III',98926,37270,1);
INSERT INTO `employees` VALUES (40448,'Mindy','Crissil','Staff Scientist',94860,37270,1);
INSERT INTO `employees` VALUES (56274,'Keriann','Alloisi','VP Marketing',110150,37270,1);
INSERT INTO `employees` VALUES (63196,'Alaster','Scutchin','Assistant Professor',32179,37270,2);
INSERT INTO `employees` VALUES (67009,'North','de Clerc','VP Product Management',114257,37270,2);
INSERT INTO `employees` VALUES (67370,'Elladine','Rising','Social Worker',96767,37270,2);
INSERT INTO `employees` VALUES (68249,'Nisse','Voysey','Financial Advisor',52832,37270,2);
INSERT INTO `employees` VALUES (72540,'Guthrey','Iacopetti','Office Assistant I',117690,37270,3);
INSERT INTO `employees` VALUES (72913,'Kass','Hefferan','Computer Systems Analyst IV',96401,37270,3);
INSERT INTO `employees` VALUES (75900,'Virge','Goodrum','Information Systems Manager',54578,37270,3);
INSERT INTO `employees` VALUES (76196,'Mirilla','Janowski','Cost Accountant',119241,37270,3);
INSERT INTO `employees` VALUES (80529,'Lynde','Aronson','Junior Executive',77182,37270,4);
INSERT INTO `employees` VALUES (80679,'Mildrid','Sokale','Geologist II',67987,37270,4);
INSERT INTO `employees` VALUES (84791,'Hazel','Tarbert','General Manager',93760,37270,4);
INSERT INTO `employees` VALUES (95213,'Cole','Kesterton','Pharmacist',86119,37270,4);
INSERT INTO `employees` VALUES (96513,'Theresa','Binney','Food Chemist',47354,37270,5);
INSERT INTO `employees` VALUES (98374,'Estrellita','Daleman','Staff Accountant IV',70187,37270,5);
INSERT INTO `employees` VALUES (115357,'Ivy','Fearey','Structural Engineer',92710,37270,5);



SHOW TABLES;                   # Show newly created tables.
SELECT * FROM employees;       # List all records within employees table.
SELECT * FROM offices;         # List all records within offices table.
EXIT;



#Creating a Client Instance and Connecting to MariaDB Server Instance Remotely
# Launch EC2 Instance (Ubuntu 20.04) and name it as MariaDB-Client on Ubuntu.

# AMI: Ubuntu 20.04
# Instance Type: t2.micro
# Security Group
#   - SSH           -----> 22    -----> Anywhere

# Connect to EC2 instance with SSH.


sudo apt update && sudo apt upgrade -y      # Update instance.
sudo apt-get install mariadb-client -y      # Install the mariadb-client.
mysql -h ec2-3-94-163-77.compute-1.amazonaws.com -u demouser -p     # Write your PublicIDAdress(ec2-3-94-163-77.compute-1.amazonaws.com)


SHOW DATABASES;
USE clarusdb;
SHOW TABLES;
SELECT * FROM employees;
SELECT * FROM offices;
SELECT first_name, last_name, salary, city, state FROM employees INNER JOIN offices ON employees.office_id=offices.office_id WHERE employees.salary > 100000;


EXIT;        # Close the mysql terminal.

# DO NOT FORGET TO TERMINATE THE INSTANCES YOU CREATED!!!!!!!!!!




















