import 'dart:io';

import 'package:intl/intl.dart';

class ExportedQsoLog {
  final int id;
  final String callsign;
  final String mode;
  final String frequency;
  final int? rstSent;
  final int? rstReceived;
  final String? name;
  final String? qth;
  final String? gridSquare;
  final String? notes;
  final DateTime timestamp;

  ExportedQsoLog({
    required this.id,
    required this.callsign,
    required this.mode,
    required this.frequency,
    this.rstSent,
    this.rstReceived,
    this.name,
    this.qth,
    this.gridSquare,
    this.notes,
    required this.timestamp,
  });
}

class ExportService {
  static String exportToAdif(List<ExportedQsoLog> logs) {
    final buffer = StringBuffer();
    buffer.writeln('ADIF Export from DigitalHam');
    buffer.writeln('<EOH>');

    for (final qso in logs) {
      final date = DateFormat('yyyyMMdd').format(qso.timestamp);
      final time = DateFormat('HHmm').format(qso.timestamp);
      final freq = _formatFrequency(qso.frequency);

      buffer.write('<QSO:');
      buffer.write('DATE:$date;');
      buffer.write('TIME:$time;');
      buffer.write('CALL:${qso.callsign};');
      buffer.write('MODE:${qso.mode};');
      if (qso.rstSent != null) {
        buffer.write('RST_SENT:${qso.rstSent};');
      }
      if (qso.rstReceived != null) {
        buffer.write('RST_RCVD:${qso.rstReceived};');
      }
      if (qso.name != null && qso.name!.isNotEmpty) {
        buffer.write('NAME:${qso.name};');
      }
      if (qso.qth != null && qso.qth!.isNotEmpty) {
        buffer.write('QTH:${qso.qth};');
      }
      if (qso.gridSquare != null && qso.gridSquare!.isNotEmpty) {
        buffer.write('GRIDSQUARE:${qso.gridSquare};');
      }
      buffer.write('FREQ:$freq;');
      if (qso.notes != null && qso.notes!.isNotEmpty) {
        buffer.write('COMMENT:${qso.notes};');
      }
      buffer.writeln('>');
    }

    return buffer.toString();
  }

  static String exportToCsv(List<ExportedQsoLog> logs) {
    final buffer = StringBuffer();
    buffer.writeln(
      'Date,Time,Callsign,Mode,Frequency,RST_Sent,RST_Received,Name,QTH,GridSquare,Notes',
    );

    for (final qso in logs) {
      final date = DateFormat('yyyy-MM-dd').format(qso.timestamp);
      final time = DateFormat('HH:mm').format(qso.timestamp);
      buffer.writeln(
        '$date,$time,'
        '${_escapeCsv(qso.callsign)},'
        '${_escapeCsv(qso.mode)},'
        '${_escapeCsv(qso.frequency)},'
        '${qso.rstSent ?? ""},'
        '${qso.rstReceived ?? ""},'
        '${_escapeCsv(qso.name ?? "")},'
        '${_escapeCsv(qso.qth ?? "")},'
        '${_escapeCsv(qso.gridSquare ?? "")},'
        '${_escapeCsv(qso.notes ?? "")}',
      );
    }

    return buffer.toString();
  }

  static List<ExportedQsoLog> importFromCsv(
    String csvContent, {
    String? mode,
    String? frequency,
  }) {
    final lines = csvContent.split('\n');
    if (lines.isEmpty) return [];

    final logs = <ExportedQsoLog>[];
    for (var i = 1; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;

      final fields = _parseCsvLine(line);
      if (fields.length < 4) continue;

      try {
        final date = fields[0];
        final time = fields[1];
        final callsign = fields[2];
        final modeField = fields.length > 3 && fields[3].isNotEmpty
            ? fields[3]
            : mode ?? 'FT8';
        final freqField = fields.length > 4 && fields[4].isNotEmpty
            ? fields[4]
            : frequency ?? '14.074';

        final timestamp = DateTime.parse('$date $time');

        logs.add(
          ExportedQsoLog(
            id: 0,
            callsign: callsign,
            mode: modeField,
            frequency: freqField,
            rstSent: int.tryParse(fields.length > 5 ? fields[5] : ''),
            rstReceived: int.tryParse(fields.length > 6 ? fields[6] : ''),
            name: fields.length > 7 ? fields[7] : null,
            qth: fields.length > 8 ? fields[8] : null,
            gridSquare: fields.length > 9 ? fields[9] : null,
            notes: fields.length > 10 ? fields[10] : null,
            timestamp: timestamp,
          ),
        );
      } catch (e) {
        continue;
      }
    }
    return logs;
  }

  static Future<void> saveToFile(String content, String filePath) async {
    final file = File(filePath);
    await file.writeAsString(content);
  }

  static Future<String> readFromFile(String filePath) async {
    final file = File(filePath);
    return file.readAsString();
  }

  static String _formatFrequency(String freq) {
    final value = double.tryParse(freq);
    if (value == null) return freq;
    return (value / 1000).toStringAsFixed(3);
  }

  static String _escapeCsv(String value) {
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }

  static List<String> _parseCsvLine(String line) {
    final fields = <String>[];
    var current = StringBuffer();
    var inQuotes = false;

    for (var i = 0; i < line.length; i++) {
      final char = line[i];
      if (inQuotes) {
        if (char == '"' && i + 1 < line.length && line[i + 1] == '"') {
          current.write('"');
          i++;
        } else if (char == '"') {
          inQuotes = false;
        } else {
          current.write(char);
        }
      } else {
        if (char == '"') {
          inQuotes = true;
        } else if (char == ',') {
          fields.add(current.toString());
          current = StringBuffer();
        } else {
          current.write(char);
        }
      }
    }
    fields.add(current.toString());
    return fields;
  }
}

class ImportResult {
  final List<ExportedQsoLog> logs;
  final List<String> errors;

  ImportResult({required this.logs, this.errors = const []});
}

class ImportService {
  static Future<ImportResult> importFromAdif(String content) async {
    final logs = <ExportedQsoLog>[];
    final errors = <String>[];

    final lines = content.split('\n');
    var inHeader = true;
    var currentQso = <String, String>{};

    for (final line in lines) {
      if (line.toUpperCase().contains('<EOH>')) {
        inHeader = false;
        continue;
      }
      if (inHeader) continue;

      if (line.trim().isEmpty) {
        if (currentQso.isNotEmpty) {
          try {
            final qso = _parseAdifQso(currentQso);
            if (qso != null) logs.add(qso);
          } catch (e) {
            errors.add('Failed to parse QSO: $e');
          }
          currentQso = {};
        }
        continue;
      }

      final match = RegExp(r'<(\w+)(?::(\d+))?>([^<]*)').firstMatch(line);
      if (match != null) {
        final field = match.group(1)!.toUpperCase();
        final value = match.group(3)!.trim();
        currentQso[field] = value;
      }
    }

    return ImportResult(logs: logs, errors: errors);
  }

  static ExportedQsoLog? _parseAdifQso(Map<String, String> fields) {
    if (!fields.containsKey('CALL') ||
        !fields.containsKey('DATE') ||
        !fields.containsKey('TIME')) {
      return null;
    }

    final date = fields['DATE']!;
    final time = fields['TIME']!.padLeft(4, '0');

    final timestamp = DateTime(
      int.parse(date.substring(0, 4)),
      int.parse(date.substring(4, 6)),
      int.parse(date.substring(6, 8)),
      int.parse(time.substring(0, 2)),
      int.parse(time.substring(2, 4)),
    );

    final freq = fields['FREQ'] ?? fields['FREQ_RX'] ?? '14.074';
    final freqValue = double.tryParse(freq);
    final freqString = freqValue != null
        ? (freqValue * 1000).toStringAsFixed(0)
        : freq;

    return ExportedQsoLog(
      id: 0,
      callsign: fields['CALL']!.toUpperCase(),
      mode: fields['MODE'] ?? 'FT8',
      frequency: freqString,
      rstSent: int.tryParse(fields['RST_SENT'] ?? ''),
      rstReceived: int.tryParse(fields['RST_RCVD'] ?? ''),
      name: fields['NAME'],
      qth: fields['QTH'],
      gridSquare: fields['GRIDSQUARE'],
      notes: fields['COMMENT'] ?? fields['NOTES'],
      timestamp: timestamp,
    );
  }
}
