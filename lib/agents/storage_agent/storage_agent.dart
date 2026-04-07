import 'database.dart';

class StorageAgent {
  final AppDatabase _db;

  StorageAgent() : _db = AppDatabase();

  QsoLogs get qsoLogs => _db.qsoLogs;
  Contacts get contacts => _db.contacts;

  Future<List<QsoLog>> getAllQsoLogs() => _db.getAllQsoLogs();
  Stream<List<QsoLog>> watchQsoLogs() => _db.watchAllQsoLogs();
  Future<int> addQsoLog(QsoLogsCompanion entry) => _db.insertQsoLog(entry);
  Future<bool> updateQsoLog(QsoLog entry) => _db.updateQsoLog(entry);
  Future<int> deleteQsoLog(int id) => _db.deleteQsoLog(id);

  Future<List<Contact>> getAllContacts() => _db.getAllContacts();
  Stream<List<Contact>> watchContacts() => _db.watchAllContacts();
  Future<int> addContact(ContactsCompanion entry) => _db.insertContact(entry);
  Future<bool> updateContact(Contact entry) => _db.updateContact(entry);
  Future<int> deleteContact(int id) => _db.deleteContact(id);

  Future<String?> getSetting(String key) => _db.getSetting(key);
  Future<void> setSetting(String key, String value) =>
      _db.setSetting(key, value);

  Future<void> close() => _db.close();
}
