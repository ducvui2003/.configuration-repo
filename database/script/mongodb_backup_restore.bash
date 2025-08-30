#!/bin/bash

# ----------------------
# SESSION CREDENTIALS
# ----------------------
if [[ -z "${MONGO_USER-}" ]]; then
    read -p "Enter MongoDB username: " MONGO_USER
    read -s -p "Enter MongoDB password: " MONGO_PASSWORD
    echo
    read -p "Enter MongoDB host (default 127.0.0.1): " MONGO_HOST
    MONGO_HOST=${MONGO_HOST:-127.0.0.1}
    read -p "Enter MongoDB port (default 27017): " MONGO_PORT
    MONGO_PORT=${MONGO_PORT:-27017}
fi

# ----------------------
# BACKUP ROOT DIRECTORY
# ----------------------
BACKUP_ROOT="$(dirname "$PWD")/mongodb"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
AUTH_DB=admin

# ----------------------
# FUNCTIONS
# ----------------------
backup_all() {
    read -p "Enter a postfix for this backup folder (optional): " POSTFIX

    BACKUP_DIR="$BACKUP_ROOT/$DATE"
    [[ -n "$POSTFIX" ]] && BACKUP_DIR="${BACKUP_DIR}_$POSTFIX"
    mkdir -p "$BACKUP_DIR"

    echo "Retrieving list of databases..."
    DB_LIST=$(mongosh --quiet --host "$MONGO_HOST" --port "$MONGO_PORT" \
              --username "$MONGO_USER" --password "$MONGO_PASSWORD" \
              --authenticationDatabase "$AUTH_DB" \
              --eval "db.adminCommand('listDatabases').databases.forEach(function(d){print(d.name)})")

    # Ask user about optional system databases
    BACKUP_ADMIN="n"
    BACKUP_TEST="n"
    [[ $DB_LIST == *"admin"* ]] && read -p "Include 'admin' database? (y/N): " BACKUP_ADMIN
    [[ $DB_LIST == *"test"* ]] && read -p "Include 'test' database? (y/N): " BACKUP_TEST

    echo "Backing up databases to $BACKUP_DIR..."
    for db in $DB_LIST; do
        [[ "$db" == "local" ]] && continue  # always skip local
        [[ "$db" == "admin" && "$BACKUP_ADMIN" != "y" ]] && continue
        [[ "$db" == "test" && "$BACKUP_TEST" != "y" ]] && continue

        echo "Dumping $db -> $BACKUP_DIR/$db"
        mongodump -h "$MONGO_HOST" --port "$MONGO_PORT" \
                  --username "$MONGO_USER" --password "$MONGO_PASSWORD" \
                  --authenticationDatabase "$AUTH_DB" \
                  --db "$db" \
                  --out "$BACKUP_DIR"
    done
    echo "Backup complete."
}

backup_select() {
    read -p "Enter a postfix for this backup folder (optional): " POSTFIX

    BACKUP_DIR="$BACKUP_ROOT/$DATE"
    [[ -n "$POSTFIX" ]] && BACKUP_DIR="${BACKUP_DIR}_$POSTFIX"
    mkdir -p "$BACKUP_DIR"

    echo "Enter database names to backup (space-separated):"
    read -r dbs
    for db in $dbs; do
        echo "Dumping $db -> $BACKUP_DIR/$db"
        mongodump -h "$MONGO_HOST" --port "$MONGO_PORT" \
                  --username "$MONGO_USER" --password "$MONGO_PASSWORD" \
                  --authenticationDatabase "$AUTH_DB" \
                  --db "$db" \
                  --out "$BACKUP_DIR"
    done
    echo "Backup complete."
}

restore() {
    echo "Enter the backup folder (full path):"
    read -r folder
    if [[ ! -d "$folder" ]]; then
        echo "Folder not found!"
        return
    fi

    for db_folder in "$folder"/*; do
        db=$(basename "$db_folder")
        echo "Restoring $db from $db_folder..."
        mongorestore -h "$MONGO_HOST" --port "$MONGO_PORT" \
                     --username "$MONGO_USER" --password "$MONGO_PASSWORD" \
                     --authenticationDatabase "$AUTH_DB" \
                     --db "$db" "$db_folder/$db"
    done
    echo "Restore complete."
}

restore_single() {
    echo "Enter the backup folder (full path):"
    read -r folder
    if [[ ! -d "$folder" ]]; then
        echo "Folder not found!"
        return
    fi

    echo "Enter the database name to restore:"
    read -r db

    DB_FOLDER="$folder/$db"
    if [[ ! -d "$DB_FOLDER" ]]; then
        echo "Database folder $DB_FOLDER not found!"
        return
    fi

    echo "Restoring $db from $DB_FOLDER..."
    mongorestore -h "$MONGO_HOST" --port "$MONGO_PORT" \
                 --username "$MONGO_USER" --password "$MONGO_PASSWORD" \
                 --authenticationDatabase "$AUTH_DB" \
                 --db "$db" "$DB_FOLDER/$db"
    echo "Restore of $db complete."
}

# ----------------------
# MAIN MENU LOOP
# ----------------------
while true; do
    echo
    echo "Choose an option:"
    echo "1) Backup all databases"
    echo "2) Backup selected databases"
    echo "3) Restore all databases from backup"
    echo "4) Restore a single database from backup"
    echo "5) Exit"
    read -r choice

    case $choice in
        1) backup_all ;;
        2) backup_select ;;
        3) restore ;;
        4) restore_single ;;
        5) exit 0 ;;
        *) echo "Invalid choice";;
    esac
done
