import json

import boto3
snsClient = boto3.client('sns')

def lambda_handler(event, context):
    print('This is deployed by javahome terraform!!!!!!!')
