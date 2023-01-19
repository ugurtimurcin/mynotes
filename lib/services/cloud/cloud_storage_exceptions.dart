class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreateNoteExcepiton extends CloudStorageException {}

class CouldNotGetAllNotesExcepiton extends CloudStorageException {}

class CouldNotUpdateNoteExcepiton extends CloudStorageException {}

class CouldNotDeleteNoteExcepiton extends CloudStorageException {}
