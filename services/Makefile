# File paths
MYSQL_COMPOSE=./services/docker-compose/mysql/docker-compose.yml
MYSQL_ENV=./services/docker-compose/mysql/.env

KAFKA_COMPOSE=./services/docker-compose/kafka/docker-compose.yml
KAFKA_ENV=./services/docker-compose/kafka/.env

MONGO_COMPOSE=./services/docker-compose/mongodb/docker-compose.yml
MONGO_ENV=./services/docker-compose/mongodb/.env

REDIS_COMPOSE=./services/docker-compose/redis/docker-compose.yml
REDIS_ENV=./services/docker-compose/redis/.env

POSTGRES_COMPOSE=./services/docker-compose/postgresql/docker-compose.yml
POSTGRES_ENV=./services/docker-compose/postgresql/.env

JENKINS_COMPOSE=./services/docker-compose/jenkins/docker-compose.yml
JENKINS_ENV=./services/docker-compose/jenkins/.env

# MySQL
mysql_up:
	bash services/scripts/up.sh ${MYSQL_COMPOSE} ${MYSQL_ENV}

mysql_stop:
	bash services/scripts/stop.sh ${MYSQL_COMPOSE} ${MYSQL_ENV}

# Kafka
kafka_up:
	bash services/scripts/up.sh ${KAFKA_COMPOSE} ${KAFKA_ENV}

kafka_stop:
	bash services/scripts/stop.sh ${KAFKA_COMPOSE} ${KAFKA_ENV}

# MongoDB
mongo_up:
	bash services/scripts/up.sh ${MONGO_COMPOSE} ${MONGO_ENV}

mongo_stop:
	bash services/scripts/stop.sh ${MONGO_COMPOSE} ${MONGO_ENV}

# Redis
redis_up:
	bash services/scripts/up.sh ${REDIS_COMPOSE} ${REDIS_ENV}

redis_stop:
	bash services/scripts/stop.sh ${REDIS_COMPOSE} ${REDIS_ENV}

# PostgreSQL
postgres_up:
	bash services/scripts/up.sh ${POSTGRES_COMPOSE} ${POSTGRES_ENV}

postgres_stop:
	bash services/scripts/stop.sh ${POSTGRES_COMPOSE} ${POSTGRES_ENV}

#  Jenkins
jenkins_up:
	bash services/scripts/up.sh ${JENKINS_COMPOSE} ${JENKINS_ENV}

jenkins_stop:
	bash services/scripts/stop.sh ${JENKINS_COMPOSE} ${JENKINS_ENV}