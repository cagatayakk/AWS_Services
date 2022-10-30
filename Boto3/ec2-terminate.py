import boto3
ec2 = boto3.resource('ec2')
ec2.Instance('i-019625b91bdd3029d').terminate()