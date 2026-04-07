import 'package:flutter_test/flutter_test.dart';
import 'package:digitalham/agents/storage_agent/export_service.dart';

void main() {
  group('ExportService', () {
    ExportedQsoLog createQsoLog({
      required String callsign,
      required String mode,
      required String frequency,
      int? rstSent,
      int? rstReceived,
      String? name,
      String? qth,
      String? gridSquare,
      String? notes,
      required DateTime timestamp,
    }) {
      return ExportedQsoLog(
        id: 0,
        callsign: callsign,
        mode: mode,
        frequency: frequency,
        rstSent: rstSent,
        rstReceived: rstReceived,
        name: name,
        qth: qth,
        gridSquare: gridSquare,
        notes: notes,
        timestamp: timestamp,
      );
    }

    test('exportToCsv formats correctly', () {
      final logs = [
        createQsoLog(
          callsign: 'K1XYZ',
          mode: 'FT8',
          frequency: '14.074',
          rstSent: 59,
          rstReceived: 57,
          timestamp: DateTime(2024, 1, 15, 10, 30),
        ),
      ];

      final csv = ExportService.exportToCsv(logs);

      expect(
        csv,
        contains(
          'Date,Time,Callsign,Mode,Frequency,RST_Sent,RST_Received,Name,QTH,GridSquare,Notes',
        ),
      );
      expect(csv, contains('2024-01-15,10:30,K1XYZ,FT8,14.074,59,57,,,,'));
    });

    test('exportToAdif formats correctly', () {
      final logs = [
        createQsoLog(
          callsign: 'W1AW',
          mode: 'FT4',
          frequency: '7.074',
          rstSent: 55,
          timestamp: DateTime(2024, 1, 15, 14, 0),
        ),
      ];

      final adif = ExportService.exportToAdif(logs);

      expect(adif, contains('<QSO:'));
      expect(adif, contains('CALL:W1AW'));
      expect(adif, contains('MODE:FT4'));
    });

    test('exportToCsv handles empty list', () {
      final csv = ExportService.exportToCsv([]);
      expect(csv, contains('Date,Time,Callsign'));
    });

    test('exportToCsv handles special characters', () {
      final logs = [
        createQsoLog(
          callsign: 'K1XYZ',
          mode: 'FT8',
          frequency: '14.074',
          notes: 'Test, with "quotes"',
          timestamp: DateTime(2024, 1, 15, 10, 30),
        ),
      ];

      final csv = ExportService.exportToCsv(logs);
      expect(csv, contains('"Test, with ""quotes"""'));
    });

    test('exportToCsv handles grid square and QTH', () {
      final logs = [
        createQsoLog(
          callsign: 'EA8URL',
          mode: 'FT8',
          frequency: '14.074',
          gridSquare: 'IL27dx',
          qth: 'Canary Islands',
          timestamp: DateTime(2024, 1, 15, 10, 30),
        ),
      ];

      final csv = ExportService.exportToCsv(logs);

      expect(csv, contains('EA8URL'));
      expect(csv, contains('IL27dx'));
      expect(csv, contains('Canary Islands'));
    });
  });

  group('ImportService', () {
    test('importFromCsv parses correctly', () {
      const csvContent =
          '''Date,Time,Callsign,Mode,Frequency,RST_Sent,RST_Received,Name,QTH,GridSquare,Notes
2024-01-15,10:30,K1XYZ,FT8,14.074,59,57,John,NYC,FN30nr,Test QSO''';

      final logs = ExportService.importFromCsv(
        csvContent,
        mode: 'FT8',
        frequency: '14.074',
      );

      expect(logs.length, 1);
      expect(logs[0].callsign, 'K1XYZ');
      expect(logs[0].mode, 'FT8');
      expect(logs[0].name, 'John');
    });

    test('importFromCsv handles empty content', () {
      final logs = ExportService.importFromCsv('');
      expect(logs, isEmpty);
    });
  });
}
