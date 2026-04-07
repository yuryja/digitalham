import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class QsoLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get callsign => text().withLength(min: 1, max: 20)();
  TextColumn get mode => text().withLength(min: 2, max: 10)();
  TextColumn get frequency => text()();
  IntColumn get rstSent => integer().nullable()();
  IntColumn get rstReceived => integer().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get qth => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get gridSquare => text().nullable()();
}

class Contacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get callsign => text().withLength(min: 1, max: 20).unique()();
  TextColumn get name => text().nullable()();
  TextColumn get qth => text().nullable()();
  TextColumn get gridSquare => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get lastContact => dateTime().nullable()();
}

class Settings extends Table {
  TextColumn get key => text().unique()();
  TextColumn get value => text()();
}

@DriftDatabase(tables: [QsoLogs, Contacts, Settings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<QsoLog>> getAllQsoLogs() => select(qsoLogs).get();

  Stream<List<QsoLog>> watchAllQsoLogs() => select(qsoLogs).watch();

  Future<int> insertQsoLog(QsoLogsCompanion entry) =>
      into(qsoLogs).insert(entry);

  Future<bool> updateQsoLog(QsoLog entry) => update(qsoLogs).replace(entry);

  Future<int> deleteQsoLog(int id) =>
      (delete(qsoLogs)..where((t) => t.id.equals(id))).go();

  Future<List<Contact>> getAllContacts() => select(contacts).get();

  Stream<List<Contact>> watchAllContacts() => select(contacts).watch();

  Future<int> insertContact(ContactsCompanion entry) =>
      into(contacts).insert(entry);

  Future<bool> updateContact(Contact entry) => update(contacts).replace(entry);

  Future<int> deleteContact(int id) =>
      (delete(contacts)..where((t) => t.id.equals(id))).go();

  Future<String?> getSetting(String key) async {
    final result = await (select(
      settings,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return result?.value;
  }

  Future<void> setSetting(String key, String value) async {
    await into(settings).insertOnConflictUpdate(
      SettingsCompanion(key: Value(key), value: Value(value)),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'digitalham.db'));
    return NativeDatabase.createInBackground(file);
  });
}
