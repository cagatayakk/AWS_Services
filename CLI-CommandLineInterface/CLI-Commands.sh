# AWS CLI

# References
# https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html
# https://awscli.amazonaws.com/v2/documentation/api/latest/index.html
# https://aws.amazon.com/blogs/compute/query-for-the-latest-amazon-linux-ami-ids-using-aws-systems-manager-parameter-store/



# Installation

# Linux:
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip  #install "unzip" if not installed
sudo ./aws/install


# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html


# Win:
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html


# Mac:
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
# https://graspingtech.com/install-and-configure-aws-cli/



# Update AWS CLI Version 1 on Amazon Linux (comes default) to Version 2

# Remove AWS CLI Version 1
sudo yum update -y 
sudo yum remove awscli -y # pip uninstall awscli/pip3 uninstall awscli might also work depending on the image

# Install AWS CLI Version 2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip  #install "unzip" if not installed
sudo ./aws/install
aws --version  : aws.cli/2.8.0 oldugunu gör

# Update the path accordingly if needed
export PATH=$PATH:/usr/local/bin/aws

# Upgrade
sudo pip install awscli --upgrade


# Configuration

aws configure

cat .aws/config
cat .aws/credentials

aws configure --profile user1  #Farkli aws hesaplarina giriyorsak yeni profil olusturabiliriz. Mesela sirket ve sahsi hesabimiz icin

aws s3 ls --profile mehmet  # mehmet adli kullanici icin islemi yapar (default profile'den)
export AWS_PROFILE=mehmet
export AWS_PROFILE=default

aws configure list-profiles

aws sts get-caller-identity # Hangi userda , account'da oldugumu görürüm

# IAM
aws iam list-users

aws iam create-user --user-name deneme

aws iam delete-user --user-name deneme


# S3
aws s3 ls

aws s3 mb s3://guile-cli-bucket

aws s3 cp in-class.yaml s3://guile-cli-bucket

aws s3 ls s3://guile-cli-bucket

aws s3 rm s3://guile-cli-bucket/in-class.yaml

aws s3 rb s3://guile-cli-bucket

aws s3 rb s3://guile-cli-bucket --force  # dolu Bucket'i direk  siler


# EC2
aws ec2 describe-instances

aws ec2 run-instances \
   --image-id ami-05fa00d4c63e32376 \
   --count 1 \
   --instance-type t2.micro \
   --key-name First_Key # put your key name

aws ec2 describe-instances \
   --filters "Name = key-name, Values = First_Key" --output table # put your key name

aws ec2 describe-instances --query "Reservations[].Instances[].PublicIpAddress[]"

aws ec2 describe-instances \
   --filters "Name = key-name, Values = First_Key" --query "Reservations[].Instances[].PublicIpAddress[]" # put your key name

aws ec2 describe-instances \
   --filters "Name = instance-type, Values = t2.micro" --query "Reservations[].Instances[].InstanceId[]"

aws ec2 stop-instances --instance-ids INSTANCE_ID_HERE # put your instance id

aws ec2 start-instances --instance-ids INSTANCE_ID_HERE # put your instance id

aws ec2 terminate-instances --instance-ids INSTANCE_ID_HERE # put your instance id

# Working with the latest Amazon Linux AMI

aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --region us-east-1

aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --query 'Parameters[0].[Value]' --output text

aws ec2 run-instances \
   --image-id $(aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --query \
               'Parameters[0].[Value]' --output text) \
   --count 1 \
   --instance-type t2.micro \
   --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Linux}]' \
   --security-group-ids sg-08838202d4c74facd \
   --key-name First_Key \

run-instance with Template :

aws ec2 run-instances \
--launch-template LaunchTemplateId=lt-095cf29dbbc7c584f,Version=9
