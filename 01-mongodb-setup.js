// MongoDB setup script

print("Creating collections in " + process.env.MONGO_INITDB_DATABASE + " database...");

// Connect to the database
db = db.getSiblingDB(process.env.MONGO_INITDB_DATABASE);

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

print("Collection setup completed.");