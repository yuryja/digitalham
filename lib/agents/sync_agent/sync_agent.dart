import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class BackupInfo {
  final String path;
  final DateTime timestamp;
  final int sizeBytes;

  BackupInfo({
    required this.path,
    required this.timestamp,
    required this.sizeBytes,
  });
}

class SyncAgent {
  Future<Directory> get _backupDir async {
    final appDir = await getApplicationDocumentsDirectory();
    final backupDir = Directory('${appDir.path}/backups');
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    return backupDir;
  }

  Future<String> createBackup({
    required String content,
    required String format,
  }) async {
    final backupFolder = await _backupDir;
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final filename = 'digitalham_backup_$timestamp.$format';
    final filePath = '${backupFolder.path}/$filename';

    final file = File(filePath);
    await file.writeAsString(content);

    return filePath;
  }

  Future<List<BackupInfo>> listBackups() async {
    final backupFolder = await _backupDir;
    final files = await backupFolder.list().toList();

    final backups = <BackupInfo>[];
    for (final file in files) {
      if (file is File) {
        final stat = await file.stat();
        if (file.path.endsWith('.adif') ||
            file.path.endsWith('.csv') ||
            file.path.endsWith('.json')) {
          backups.add(
            BackupInfo(
              path: file.path,
              timestamp: stat.modified,
              sizeBytes: stat.size,
            ),
          );
        }
      }
    }

    backups.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return backups;
  }

  Future<String?> readBackup(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.readAsString();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteBackup(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> clearAllBackups() async {
    final backupFolder = await _backupDir;
    final files = await backupFolder.list().toList();

    for (final file in files) {
      if (file is File) {
        await file.delete();
      }
    }
  }

  Future<int> getBackupSize() async {
    final backups = await listBackups();
    int total = 0;
    for (final backup in backups) {
      total += backup.sizeBytes;
    }
    return total;
  }

  Future<String> getBackupDirectory() async {
    final backupFolder = await _backupDir;
    return backupFolder.path;
  }
}
