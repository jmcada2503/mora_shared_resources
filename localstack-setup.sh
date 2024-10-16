#!/bin/sh
echo "Initializing localstack s3"

awslocal sqs create-queue --queue-name coreapi-queue
awslocal sqs create-queue --queue-name coreapi-load-queue