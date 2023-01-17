const dbName = 'notes.db';
const String idColumn = 'id';

//User table
const String userTableName = 'user';
const String emailColumn = 'email';

//notes table
const String noteTableName = 'note';
const String userIdColumn = 'user_id';
const String textColumn = 'text';
const String isSyncedWithCloudColumn = 'is_synced_with_cloud';

//DB queries
const String createUserTableQuery = '''CREATE TABLE IF NOT EXISTS "user" (
	"id"	INTEGER NOT NULL,
	"email"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);''';

const String createNotesTableQuery = '''CREATE TABLE IF NOT EXISTS "note" (
	"id"	INTEGER NOT NULL,
	"user_id"	INTEGER NOT NULL,
	"text"	TEXT,
	"is_synced_with_cloud"	INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "user"("id")
);''';
