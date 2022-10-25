import boto3

client=boto3.client("s3")
bucket_name="demo-boto3-bucket"
response = client.delete_bucket(Bucket=bucket_name)

s3 = boto3.resource('s3')

# Print out all bucket names
for bucket in s3.buckets.all():
    print(bucket.name)



