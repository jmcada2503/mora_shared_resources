#!/bin/bash

# Configuración de los parámetros para S3 y SQS
BUCKET_NAME="undi-documents"
LOCALSTACK_URL="http://localhost:4566"

# Función para crear el bucket en S3
create_s3_bucket() {
  echo "Creando el bucket de S3: $BUCKET_NAME"
  awslocal --endpoint-url=$LOCALSTACK_URL s3api create-bucket --bucket $BUCKET_NAME
  if [ $? -eq 0 ]; then
    echo "Bucket $BUCKET_NAME creado exitosamente."
  else
    echo "Error al crear el bucket $BUCKET_NAME."
  fi
}


# Ejecutar las funciones
create_s3_bucket
#create_sqs_queue
awslocal sqs create-queue --queue-name coreapi-queue
awslocal sqs create-queue --queue-name coreapi-load-queue

echo "Todos los recursos han sido creados."
