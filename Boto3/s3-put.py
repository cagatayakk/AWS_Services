import boto3

# Use Amazon S3
s3 = boto3.resource('s3')

# Upload a new file
data = open('s3-list.py', 'rb')
s3.Bucket('demo-boto3-bucket').put_object(Key='s3-list.py', Body=data)

my_bucket= s3.Bucket("demo-boto3-bucket")

for object in my_bucket.objects.all():
    print(object.key)