#!/bin/bash
set -e

echo "Restoring collections in $MONGO_INITDB_DATABASE database..."

# Restore from database dump
mongorestore \
  --username $MONGO_INITDB_ROOT_USERNAME \
  --password $MONGO_INITDB_ROOT_PASSWORD \
  --authenticationDatabase admin \
  --db $MONGO_INITDB_DATABASE \
  /mongodb_dump/$MONGO_INITDB_DATABASE
  
echo "Data restoration completed."