#!/bin/bash
set -e

echo "Creating collections in $MONGO_INITDB_DATABASE database..."

# Create collections
mongosh --quiet --eval "
  const db = db.getSiblingDB('$MONGO_INITDB_DATABASE');
  
  // List of collections to create
  const collectionsToCreate = ['StudyDefinitions', 'Groups', 'ChangeAudit'];
  
  // Get existing collections
  const existingCollections = db.getCollectionNames();
  
  // Create each collection if it does not exist
  collectionsToCreate.forEach(collectionName => {
    if (!existingCollections.includes(collectionName)) {
      db.createCollection(collectionName);
      print(collectionName + ' collection created');
    } else {
      print(collectionName + ' collection already exists');
    }
  });
" --username $MONGO_INITDB_ROOT_USERNAME --password $MONGO_INITDB_ROOT_PASSWORD --authenticationDatabase admin

echo "Collection setup completed."