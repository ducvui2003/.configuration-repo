#!/bin/bash

COMPOSE_FILE=$1
ENV_FILE=$2
shift 2

if [ $# -eq 0 ]; then
  echo "🛑 Stopping ALL services in $COMPOSE_FILE"
  docker-compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" stop
else
  echo "🛑 Stopping services: $@"
  docker-compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" stop "$@"
fi
