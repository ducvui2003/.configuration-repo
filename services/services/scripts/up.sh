#!/bin/bash

COMPOSE_FILE=$1
ENV_FILE=$2
shift 2

for arg in "$@"; do
  echo "$arg"
done

echo "🟢 Using compose file: $COMPOSE_FILE and env: $ENV_FILE"
docker-compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" up -d "$@"
