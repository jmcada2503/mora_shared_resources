#!/bin/bash
# Espera hasta que el servicio de SQS esté disponible
LOCALSTACK_URL="http://localhost:4566"

# Función para crear un bucket en S3
create_s3_bucket() {
  BUCKET_NAME=$1
  if [ -z "$BUCKET_NAME" ]; then
    echo "Debe proporcionar un nombre de bucket."
    exit 1
  fi
  echo "Creando el bucket de S3: $BUCKET_NAME"
  awslocal --endpoint-url=$LOCALSTACK_URL s3api create-bucket --bucket $BUCKET_NAME
  if [ $? -eq 0 ]; then
    echo "Bucket $BUCKET_NAME creado exitosamente."
  else
    echo "Error al crear el bucket $BUCKET_NAME."
  fi
}

# Función para crear una cola en SQS
create_sqs_queue() {
  QUEUE_NAME=$1
  if [ -z "$QUEUE_NAME" ]; then
    echo "Debe proporcionar un nombre de cola."
    exit 1
  fi
  echo "Creando la cola de SQS: $QUEUE_NAME"
  awslocal --endpoint-url=$LOCALSTACK_URL sqs create-queue --queue-name $QUEUE_NAME
  if [ $? -eq 0 ]; then
    echo "Cola $QUEUE_NAME creada exitosamente."
  else
    echo "Error al crear la cola $QUEUE_NAME."
  fi
}

# Ejecutar las funciones pasándole los parámetros como argumentos
create_s3_bucket "undi-documents"
create_sqs_queue "calculations-queue"
create_sqs_queue "coreapi-queue"
create_sqs_queue "coreapi-load-queue"

echo "Todos los recursos han sido creados."