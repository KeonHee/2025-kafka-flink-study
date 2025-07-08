#!/bin/bash

TOPIC_NAME="bulk-topic"
PARTITIONS=6
REPLICATION_FACTOR=3
RETENTION_MS=604800000  # 7일

echo "📌 Creating topic '${TOPIC_NAME}'..."

docker exec kafka1 kafka-topics \
  --create \
  --topic $TOPIC_NAME \
  --bootstrap-server kafka1:29092 \
  --partitions $PARTITIONS \
  --replication-factor $REPLICATION_FACTOR \
  --config retention.ms=$RETENTION_MS

echo "✅ Topic '${TOPIC_NAME}' created."
