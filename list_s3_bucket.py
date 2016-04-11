#!/usr/bin/env python

import boto3

s3 = boto3.resource('s3')
bucket = s3.Bucket('mybucket')
for obj in bucket.objects.all():
    print(obj.key)