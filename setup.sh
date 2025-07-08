#!/bin/bash

echo "🛠 Kafka 3-node cluster setup starting..."

# 현재 스크립트 위치로 이동
DIR=$(dirname "$0")
cd "$DIR" || exit 1

# 볼륨 디렉토리 생성
echo "📁 Creating data directories..."
mkdir -p data/zookeeper
mkdir -p data/kafka1
mkdir -p data/kafka2
mkdir -p data/kafka3

# 퍼미션 설정 (선택)
chmod -R 755 data

# 도커 이미지 pull
echo "📦 Pulling Docker images..."
docker compose pull

# 클러스터 시작
echo "🚀 Starting Kafka + Flink cluster..."
docker compose up -d

echo ""
echo "✅ Kafka cluster is up and running!"
echo "📍 Broker 1: localhost:9092"
echo "📍 Broker 2: localhost:9093"
echo "📍 Broker 3: localhost:9094"
