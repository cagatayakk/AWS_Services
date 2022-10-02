Launch instnce -->

aws ec2 run-instances \
   --image-id $(aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --query \
               'Parameters[0].[Value]' --output text) \
   --count 1 \
   --instance-type t2.micro \
   --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Linux}]' \
   --security-group-ids sg-08838202d4c74facd \
   --key-name First_Key \
   
   

run-instance with Template -->

aws ec2 run-instances \
--launch-template LaunchTemplateId=lt-095cf29dbbc7c584f,Version=9



create-Stack -->

aws cloudformation create-stack \
  --stack-name myteststack \
  --template-url https://cagatayakk.s3.amazonaws.com/CloudFormation_Template.yaml \
  --parameters ParameterKey=InstanceType,ParameterValue=t2.micro ParameterKey=KeyName,ParameterValue=First_Key \
  ParameterKey=Subnet,ParameterValue=\'subnet-01f6fea08ac748c4b,subnet-05857676ea92ba0e1\' \
  ParameterKey=VPC,ParameterValue=vpc-05f72900256df9ba7



delete-Stack -->
aws cloudformation delete-stack --stack-name myteststack
