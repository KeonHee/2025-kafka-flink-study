# 🧱 Kafka 3-Broker Cluster with Docker Compose

이 프로젝트는 Kafka 3개 브로커 클러스터를 Docker Compose로 구성하고,
데이터를 대량으로 생산하여 추후 Flink 등의 실시간 처리 시스템에서 사용할 수 있도록 준비하는 환경입니다.

---

## 📦 구성 요소

| 컴포넌트  | 설명 |
|-----------|------|
| Zookeeper | Kafka 클러스터 관리 |
| Kafka 3개 | 3개 브로커로 구성된 클러스터 |
| Kafdrop   | Kafka UI (topic 및 메시지 확인용) |
| bulk-topic | 대량 데이터 저장용 topic (retention 설정 포함) |
| Flink JobManager | 스트림 처리 실행 제어 UI 및 Job 등록 |
| Flink TaskManager | 병렬 처리를 위한 실행 워커 |
---

## 📁 디렉토리 구조
```
kafka-cluster/
├── docker-compose.yml        # 전체 서비스 구성
├── setup.sh                  # 초기 실행 스크립트
├── create_bulk_topic.sh      # bulk-topic 생성용
├── bulk_producer.py          # 대량 데이터 생성 producer
└── data/                     # Kafka/Zookeeper 데이터 볼륨
    ├── kafka1/
    ├── kafka2/
    ├── kafka3/
    └── zookeeper/
```

---

## 🚀 설치 및 실행

### 1. 초기 설정 및 클러스터 시작

```bash
chmod +x setup.sh
./setup.sh
````

### 2. Kafka Topic 생성 (bulk-topic)

```bash
chmod +x create_bulk_topic.sh
./create_bulk_topic.sh
```

### 3. Kafka에 대량 메시지 전송

```bash
pip install confluent-kafka
python bulk_producer.py
```

> 기본적으로 100,000개의 JSON 메시지가 `bulk-topic`에 전송됩니다.

---

## 📍 Kafdrop UI 접속
Kafka 상태 및 메시지를 브라우저에서 확인할 수 있습니다.
```
http://localhost:9000
```

---

## 🖥 Flink Web UI 접속

여기서 Flink Job JAR 파일을 업로드하거나 실행 상태를 모니터링할 수 있습니다.
```
http://localhost:8081
```

---

## ⚙️ Topic 설정 (bulk-topic)

| 설정 항목          | 값              |
| -------------- | -------------- |
| Name           | bulk-topic     |
| Partitions     | 6              |
| Replication    | 3              |
| Retention (ms) | 604800000 (7일) |

---

## 📌 Producer 구성 요약

`bulk_producer.py`는 다음 설정으로 구성되어 있습니다:

* `acks=1` (빠른 전송)
* `batch.num.messages=1000`
* `compression.type=snappy`
* `linger.ms=10ms` (일정 시간 모아서 전송)

이 설정은 **고속 처리와 중간 정도의 안정성** 사이의 균형을 고려한 값입니다.

---

## ✅ 사용 목적

* Kafka 클러스터 학습 및 실험
* 대량 메시지 처리 테스트 환경
* Flink 등 실시간 처리 연동 준비
