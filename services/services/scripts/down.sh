#!/bin/bash

COMPOSE_FILE=$1
ENV_FILE=$2
shift 2

echo "🔴 Stopping services using: $COMPOSE_FILE with env: $ENV_FILE"

if [ "$#" -eq 0 ]; then
  docker-compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" down
else
  docker-compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" stop "$@"
fi
