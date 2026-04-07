// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $QsoLogsTable extends QsoLogs with TableInfo<$QsoLogsTable, QsoLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QsoLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _callsignMeta =
      const VerificationMeta('callsign');
  @override
  late final GeneratedColumn<String> callsign = GeneratedColumn<String>(
      'callsign', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
      'mode', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
      'frequency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rstSentMeta =
      const VerificationMeta('rstSent');
  @override
  late final GeneratedColumn<int> rstSent = GeneratedColumn<int>(
      'rst_sent', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _rstReceivedMeta =
      const VerificationMeta('rstReceived');
  @override
  late final GeneratedColumn<int> rstReceived = GeneratedColumn<int>(
      'rst_received', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _qthMeta = const VerificationMeta('qth');
  @override
  late final GeneratedColumn<String> qth = GeneratedColumn<String>(
      'qth', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _gridSquareMeta =
      const VerificationMeta('gridSquare');
  @override
  late final GeneratedColumn<String> gridSquare = GeneratedColumn<String>(
      'grid_square', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        callsign,
        mode,
        frequency,
        rstSent,
        rstReceived,
        name,
        qth,
        notes,
        timestamp,
        gridSquare
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'qso_logs';
  @override
  VerificationContext validateIntegrity(Insertable<QsoLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('callsign')) {
      context.handle(_callsignMeta,
          callsign.isAcceptableOrUnknown(data['callsign']!, _callsignMeta));
    } else if (isInserting) {
      context.missing(_callsignMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
          _modeMeta, mode.isAcceptableOrUnknown(data['mode']!, _modeMeta));
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('rst_sent')) {
      context.handle(_rstSentMeta,
          rstSent.isAcceptableOrUnknown(data['rst_sent']!, _rstSentMeta));
    }
    if (data.containsKey('rst_received')) {
      context.handle(
          _rstReceivedMeta,
          rstReceived.isAcceptableOrUnknown(
              data['rst_received']!, _rstReceivedMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('qth')) {
      context.handle(
          _qthMeta, qth.isAcceptableOrUnknown(data['qth']!, _qthMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('grid_square')) {
      context.handle(
          _gridSquareMeta,
          gridSquare.isAcceptableOrUnknown(
              data['grid_square']!, _gridSquareMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QsoLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QsoLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      callsign: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}callsign'])!,
      mode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mode'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}frequency'])!,
      rstSent: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rst_sent']),
      rstReceived: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rst_received']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      qth: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}qth']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      gridSquare: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grid_square']),
    );
  }

  @override
  $QsoLogsTable createAlias(String alias) {
    return $QsoLogsTable(attachedDatabase, alias);
  }
}

class QsoLog extends DataClass implements Insertable<QsoLog> {
  final int id;
  final String callsign;
  final String mode;
  final String frequency;
  final int? rstSent;
  final int? rstReceived;
  final String? name;
  final String? qth;
  final String? notes;
  final DateTime timestamp;
  final String? gridSquare;
  const QsoLog(
      {required this.id,
      required this.callsign,
      required this.mode,
      required this.frequency,
      this.rstSent,
      this.rstReceived,
      this.name,
      this.qth,
      this.notes,
      required this.timestamp,
      this.gridSquare});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['callsign'] = Variable<String>(callsign);
    map['mode'] = Variable<String>(mode);
    map['frequency'] = Variable<String>(frequency);
    if (!nullToAbsent || rstSent != null) {
      map['rst_sent'] = Variable<int>(rstSent);
    }
    if (!nullToAbsent || rstReceived != null) {
      map['rst_received'] = Variable<int>(rstReceived);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || qth != null) {
      map['qth'] = Variable<String>(qth);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || gridSquare != null) {
      map['grid_square'] = Variable<String>(gridSquare);
    }
    return map;
  }

  QsoLogsCompanion toCompanion(bool nullToAbsent) {
    return QsoLogsCompanion(
      id: Value(id),
      callsign: Value(callsign),
      mode: Value(mode),
      frequency: Value(frequency),
      rstSent: rstSent == null && nullToAbsent
          ? const Value.absent()
          : Value(rstSent),
      rstReceived: rstReceived == null && nullToAbsent
          ? const Value.absent()
          : Value(rstReceived),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      qth: qth == null && nullToAbsent ? const Value.absent() : Value(qth),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      timestamp: Value(timestamp),
      gridSquare: gridSquare == null && nullToAbsent
          ? const Value.absent()
          : Value(gridSquare),
    );
  }

  factory QsoLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QsoLog(
      id: serializer.fromJson<int>(json['id']),
      callsign: serializer.fromJson<String>(json['callsign']),
      mode: serializer.fromJson<String>(json['mode']),
      frequency: serializer.fromJson<String>(json['frequency']),
      rstSent: serializer.fromJson<int?>(json['rstSent']),
      rstReceived: serializer.fromJson<int?>(json['rstReceived']),
      name: serializer.fromJson<String?>(json['name']),
      qth: serializer.fromJson<String?>(json['qth']),
      notes: serializer.fromJson<String?>(json['notes']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      gridSquare: serializer.fromJson<String?>(json['gridSquare']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'callsign': serializer.toJson<String>(callsign),
      'mode': serializer.toJson<String>(mode),
      'frequency': serializer.toJson<String>(frequency),
      'rstSent': serializer.toJson<int?>(rstSent),
      'rstReceived': serializer.toJson<int?>(rstReceived),
      'name': serializer.toJson<String?>(name),
      'qth': serializer.toJson<String?>(qth),
      'notes': serializer.toJson<String?>(notes),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'gridSquare': serializer.toJson<String?>(gridSquare),
    };
  }

  QsoLog copyWith(
          {int? id,
          String? callsign,
          String? mode,
          String? frequency,
          Value<int?> rstSent = const Value.absent(),
          Value<int?> rstReceived = const Value.absent(),
          Value<String?> name = const Value.absent(),
          Value<String?> qth = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? timestamp,
          Value<String?> gridSquare = const Value.absent()}) =>
      QsoLog(
        id: id ?? this.id,
        callsign: callsign ?? this.callsign,
        mode: mode ?? this.mode,
        frequency: frequency ?? this.frequency,
        rstSent: rstSent.present ? rstSent.value : this.rstSent,
        rstReceived: rstReceived.present ? rstReceived.value : this.rstReceived,
        name: name.present ? name.value : this.name,
        qth: qth.present ? qth.value : this.qth,
        notes: notes.present ? notes.value : this.notes,
        timestamp: timestamp ?? this.timestamp,
        gridSquare: gridSquare.present ? gridSquare.value : this.gridSquare,
      );
  QsoLog copyWithCompanion(QsoLogsCompanion data) {
    return QsoLog(
      id: data.id.present ? data.id.value : this.id,
      callsign: data.callsign.present ? data.callsign.value : this.callsign,
      mode: data.mode.present ? data.mode.value : this.mode,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      rstSent: data.rstSent.present ? data.rstSent.value : this.rstSent,
      rstReceived:
          data.rstReceived.present ? data.rstReceived.value : this.rstReceived,
      name: data.name.present ? data.name.value : this.name,
      qth: data.qth.present ? data.qth.value : this.qth,
      notes: data.notes.present ? data.notes.value : this.notes,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      gridSquare:
          data.gridSquare.present ? data.gridSquare.value : this.gridSquare,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QsoLog(')
          ..write('id: $id, ')
          ..write('callsign: $callsign, ')
          ..write('mode: $mode, ')
          ..write('frequency: $frequency, ')
          ..write('rstSent: $rstSent, ')
          ..write('rstReceived: $rstReceived, ')
          ..write('name: $name, ')
          ..write('qth: $qth, ')
          ..write('notes: $notes, ')
          ..write('timestamp: $timestamp, ')
          ..write('gridSquare: $gridSquare')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, callsign, mode, frequency, rstSent,
      rstReceived, name, qth, notes, timestamp, gridSquare);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QsoLog &&
          other.id == this.id &&
          other.callsign == this.callsign &&
          other.mode == this.mode &&
          other.frequency == this.frequency &&
          other.rstSent == this.rstSent &&
          other.rstReceived == this.rstReceived &&
          other.name == this.name &&
          other.qth == this.qth &&
          other.notes == this.notes &&
          other.timestamp == this.timestamp &&
          other.gridSquare == this.gridSquare);
}

class QsoLogsCompanion extends UpdateCompanion<QsoLog> {
  final Value<int> id;
  final Value<String> callsign;
  final Value<String> mode;
  final Value<String> frequency;
  final Value<int?> rstSent;
  final Value<int?> rstReceived;
  final Value<String?> name;
  final Value<String?> qth;
  final Value<String?> notes;
  final Value<DateTime> timestamp;
  final Value<String?> gridSquare;
  const QsoLogsCompanion({
    this.id = const Value.absent(),
    this.callsign = const Value.absent(),
    this.mode = const Value.absent(),
    this.frequency = const Value.absent(),
    this.rstSent = const Value.absent(),
    this.rstReceived = const Value.absent(),
    this.name = const Value.absent(),
    this.qth = const Value.absent(),
    this.notes = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.gridSquare = const Value.absent(),
  });
  QsoLogsCompanion.insert({
    this.id = const Value.absent(),
    required String callsign,
    required String mode,
    required String frequency,
    this.rstSent = const Value.absent(),
    this.rstReceived = const Value.absent(),
    this.name = const Value.absent(),
    this.qth = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime timestamp,
    this.gridSquare = const Value.absent(),
  })  : callsign = Value(callsign),
        mode = Value(mode),
        frequency = Value(frequency),
        timestamp = Value(timestamp);
  static Insertable<QsoLog> custom({
    Expression<int>? id,
    Expression<String>? callsign,
    Expression<String>? mode,
    Expression<String>? frequency,
    Expression<int>? rstSent,
    Expression<int>? rstReceived,
    Expression<String>? name,
    Expression<String>? qth,
    Expression<String>? notes,
    Expression<DateTime>? timestamp,
    Expression<String>? gridSquare,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (callsign != null) 'callsign': callsign,
      if (mode != null) 'mode': mode,
      if (frequency != null) 'frequency': frequency,
      if (rstSent != null) 'rst_sent': rstSent,
      if (rstReceived != null) 'rst_received': rstReceived,
      if (name != null) 'name': name,
      if (qth != null) 'qth': qth,
      if (notes != null) 'notes': notes,
      if (timestamp != null) 'timestamp': timestamp,
      if (gridSquare != null) 'grid_square': gridSquare,
    });
  }

  QsoLogsCompanion copyWith(
      {Value<int>? id,
      Value<String>? callsign,
      Value<String>? mode,
      Value<String>? frequency,
      Value<int?>? rstSent,
      Value<int?>? rstReceived,
      Value<String?>? name,
      Value<String?>? qth,
      Value<String?>? notes,
      Value<DateTime>? timestamp,
      Value<String?>? gridSquare}) {
    return QsoLogsCompanion(
      id: id ?? this.id,
      callsign: callsign ?? this.callsign,
      mode: mode ?? this.mode,
      frequency: frequency ?? this.frequency,
      rstSent: rstSent ?? this.rstSent,
      rstReceived: rstReceived ?? this.rstReceived,
      name: name ?? this.name,
      qth: qth ?? this.qth,
      notes: notes ?? this.notes,
      timestamp: timestamp ?? this.timestamp,
      gridSquare: gridSquare ?? this.gridSquare,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (callsign.present) {
      map['callsign'] = Variable<String>(callsign.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (rstSent.present) {
      map['rst_sent'] = Variable<int>(rstSent.value);
    }
    if (rstReceived.present) {
      map['rst_received'] = Variable<int>(rstReceived.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (qth.present) {
      map['qth'] = Variable<String>(qth.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (gridSquare.present) {
      map['grid_square'] = Variable<String>(gridSquare.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QsoLogsCompanion(')
          ..write('id: $id, ')
          ..write('callsign: $callsign, ')
          ..write('mode: $mode, ')
          ..write('frequency: $frequency, ')
          ..write('rstSent: $rstSent, ')
          ..write('rstReceived: $rstReceived, ')
          ..write('name: $name, ')
          ..write('qth: $qth, ')
          ..write('notes: $notes, ')
          ..write('timestamp: $timestamp, ')
          ..write('gridSquare: $gridSquare')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _callsignMeta =
      const VerificationMeta('callsign');
  @override
  late final GeneratedColumn<String> callsign = GeneratedColumn<String>(
      'callsign', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _qthMeta = const VerificationMeta('qth');
  @override
  late final GeneratedColumn<String> qth = GeneratedColumn<String>(
      'qth', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _gridSquareMeta =
      const VerificationMeta('gridSquare');
  @override
  late final GeneratedColumn<String> gridSquare = GeneratedColumn<String>(
      'grid_square', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastContactMeta =
      const VerificationMeta('lastContact');
  @override
  late final GeneratedColumn<DateTime> lastContact = GeneratedColumn<DateTime>(
      'last_contact', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, callsign, name, qth, gridSquare, notes, lastContact];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<Contact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('callsign')) {
      context.handle(_callsignMeta,
          callsign.isAcceptableOrUnknown(data['callsign']!, _callsignMeta));
    } else if (isInserting) {
      context.missing(_callsignMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('qth')) {
      context.handle(
          _qthMeta, qth.isAcceptableOrUnknown(data['qth']!, _qthMeta));
    }
    if (data.containsKey('grid_square')) {
      context.handle(
          _gridSquareMeta,
          gridSquare.isAcceptableOrUnknown(
              data['grid_square']!, _gridSquareMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('last_contact')) {
      context.handle(
          _lastContactMeta,
          lastContact.isAcceptableOrUnknown(
              data['last_contact']!, _lastContactMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contact(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      callsign: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}callsign'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      qth: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}qth']),
      gridSquare: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grid_square']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      lastContact: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_contact']),
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class Contact extends DataClass implements Insertable<Contact> {
  final int id;
  final String callsign;
  final String? name;
  final String? qth;
  final String? gridSquare;
  final String? notes;
  final DateTime? lastContact;
  const Contact(
      {required this.id,
      required this.callsign,
      this.name,
      this.qth,
      this.gridSquare,
      this.notes,
      this.lastContact});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['callsign'] = Variable<String>(callsign);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || qth != null) {
      map['qth'] = Variable<String>(qth);
    }
    if (!nullToAbsent || gridSquare != null) {
      map['grid_square'] = Variable<String>(gridSquare);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || lastContact != null) {
      map['last_contact'] = Variable<DateTime>(lastContact);
    }
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      callsign: Value(callsign),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      qth: qth == null && nullToAbsent ? const Value.absent() : Value(qth),
      gridSquare: gridSquare == null && nullToAbsent
          ? const Value.absent()
          : Value(gridSquare),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      lastContact: lastContact == null && nullToAbsent
          ? const Value.absent()
          : Value(lastContact),
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      id: serializer.fromJson<int>(json['id']),
      callsign: serializer.fromJson<String>(json['callsign']),
      name: serializer.fromJson<String?>(json['name']),
      qth: serializer.fromJson<String?>(json['qth']),
      gridSquare: serializer.fromJson<String?>(json['gridSquare']),
      notes: serializer.fromJson<String?>(json['notes']),
      lastContact: serializer.fromJson<DateTime?>(json['lastContact']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'callsign': serializer.toJson<String>(callsign),
      'name': serializer.toJson<String?>(name),
      'qth': serializer.toJson<String?>(qth),
      'gridSquare': serializer.toJson<String?>(gridSquare),
      'notes': serializer.toJson<String?>(notes),
      'lastContact': serializer.toJson<DateTime?>(lastContact),
    };
  }

  Contact copyWith(
          {int? id,
          String? callsign,
          Value<String?> name = const Value.absent(),
          Value<String?> qth = const Value.absent(),
          Value<String?> gridSquare = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<DateTime?> lastContact = const Value.absent()}) =>
      Contact(
        id: id ?? this.id,
        callsign: callsign ?? this.callsign,
        name: name.present ? name.value : this.name,
        qth: qth.present ? qth.value : this.qth,
        gridSquare: gridSquare.present ? gridSquare.value : this.gridSquare,
        notes: notes.present ? notes.value : this.notes,
        lastContact: lastContact.present ? lastContact.value : this.lastContact,
      );
  Contact copyWithCompanion(ContactsCompanion data) {
    return Contact(
      id: data.id.present ? data.id.value : this.id,
      callsign: data.callsign.present ? data.callsign.value : this.callsign,
      name: data.name.present ? data.name.value : this.name,
      qth: data.qth.present ? data.qth.value : this.qth,
      gridSquare:
          data.gridSquare.present ? data.gridSquare.value : this.gridSquare,
      notes: data.notes.present ? data.notes.value : this.notes,
      lastContact:
          data.lastContact.present ? data.lastContact.value : this.lastContact,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('id: $id, ')
          ..write('callsign: $callsign, ')
          ..write('name: $name, ')
          ..write('qth: $qth, ')
          ..write('gridSquare: $gridSquare, ')
          ..write('notes: $notes, ')
          ..write('lastContact: $lastContact')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, callsign, name, qth, gridSquare, notes, lastContact);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.id == this.id &&
          other.callsign == this.callsign &&
          other.name == this.name &&
          other.qth == this.qth &&
          other.gridSquare == this.gridSquare &&
          other.notes == this.notes &&
          other.lastContact == this.lastContact);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<int> id;
  final Value<String> callsign;
  final Value<String?> name;
  final Value<String?> qth;
  final Value<String?> gridSquare;
  final Value<String?> notes;
  final Value<DateTime?> lastContact;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.callsign = const Value.absent(),
    this.name = const Value.absent(),
    this.qth = const Value.absent(),
    this.gridSquare = const Value.absent(),
    this.notes = const Value.absent(),
    this.lastContact = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    required String callsign,
    this.name = const Value.absent(),
    this.qth = const Value.absent(),
    this.gridSquare = const Value.absent(),
    this.notes = const Value.absent(),
    this.lastContact = const Value.absent(),
  }) : callsign = Value(callsign);
  static Insertable<Contact> custom({
    Expression<int>? id,
    Expression<String>? callsign,
    Expression<String>? name,
    Expression<String>? qth,
    Expression<String>? gridSquare,
    Expression<String>? notes,
    Expression<DateTime>? lastContact,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (callsign != null) 'callsign': callsign,
      if (name != null) 'name': name,
      if (qth != null) 'qth': qth,
      if (gridSquare != null) 'grid_square': gridSquare,
      if (notes != null) 'notes': notes,
      if (lastContact != null) 'last_contact': lastContact,
    });
  }

  ContactsCompanion copyWith(
      {Value<int>? id,
      Value<String>? callsign,
      Value<String?>? name,
      Value<String?>? qth,
      Value<String?>? gridSquare,
      Value<String?>? notes,
      Value<DateTime?>? lastContact}) {
    return ContactsCompanion(
      id: id ?? this.id,
      callsign: callsign ?? this.callsign,
      name: name ?? this.name,
      qth: qth ?? this.qth,
      gridSquare: gridSquare ?? this.gridSquare,
      notes: notes ?? this.notes,
      lastContact: lastContact ?? this.lastContact,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (callsign.present) {
      map['callsign'] = Variable<String>(callsign.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (qth.present) {
      map['qth'] = Variable<String>(qth.value);
    }
    if (gridSquare.present) {
      map['grid_square'] = Variable<String>(gridSquare.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (lastContact.present) {
      map['last_contact'] = Variable<DateTime>(lastContact.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('callsign: $callsign, ')
          ..write('name: $name, ')
          ..write('qth: $qth, ')
          ..write('gridSquare: $gridSquare, ')
          ..write('notes: $notes, ')
          ..write('lastContact: $lastContact')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<Setting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String value;
  const Setting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  Setting copyWith({String? key, String? value}) => Setting(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting && other.key == this.key && other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<Setting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $QsoLogsTable qsoLogs = $QsoLogsTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [qsoLogs, contacts, settings];
}

typedef $$QsoLogsTableCreateCompanionBuilder = QsoLogsCompanion Function({
  Value<int> id,
  required String callsign,
  required String mode,
  required String frequency,
  Value<int?> rstSent,
  Value<int?> rstReceived,
  Value<String?> name,
  Value<String?> qth,
  Value<String?> notes,
  required DateTime timestamp,
  Value<String?> gridSquare,
});
typedef $$QsoLogsTableUpdateCompanionBuilder = QsoLogsCompanion Function({
  Value<int> id,
  Value<String> callsign,
  Value<String> mode,
  Value<String> frequency,
  Value<int?> rstSent,
  Value<int?> rstReceived,
  Value<String?> name,
  Value<String?> qth,
  Value<String?> notes,
  Value<DateTime> timestamp,
  Value<String?> gridSquare,
});

class $$QsoLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QsoLogsTable,
    QsoLog,
    $$QsoLogsTableFilterComposer,
    $$QsoLogsTableOrderingComposer,
    $$QsoLogsTableCreateCompanionBuilder,
    $$QsoLogsTableUpdateCompanionBuilder> {
  $$QsoLogsTableTableManager(_$AppDatabase db, $QsoLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$QsoLogsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$QsoLogsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> callsign = const Value.absent(),
            Value<String> mode = const Value.absent(),
            Value<String> frequency = const Value.absent(),
            Value<int?> rstSent = const Value.absent(),
            Value<int?> rstReceived = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> qth = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<String?> gridSquare = const Value.absent(),
          }) =>
              QsoLogsCompanion(
            id: id,
            callsign: callsign,
            mode: mode,
            frequency: frequency,
            rstSent: rstSent,
            rstReceived: rstReceived,
            name: name,
            qth: qth,
            notes: notes,
            timestamp: timestamp,
            gridSquare: gridSquare,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String callsign,
            required String mode,
            required String frequency,
            Value<int?> rstSent = const Value.absent(),
            Value<int?> rstReceived = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> qth = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime timestamp,
            Value<String?> gridSquare = const Value.absent(),
          }) =>
              QsoLogsCompanion.insert(
            id: id,
            callsign: callsign,
            mode: mode,
            frequency: frequency,
            rstSent: rstSent,
            rstReceived: rstReceived,
            name: name,
            qth: qth,
            notes: notes,
            timestamp: timestamp,
            gridSquare: gridSquare,
          ),
        ));
}

class $$QsoLogsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $QsoLogsTable> {
  $$QsoLogsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get callsign => $state.composableBuilder(
      column: $state.table.callsign,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get mode => $state.composableBuilder(
      column: $state.table.mode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get frequency => $state.composableBuilder(
      column: $state.table.frequency,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get rstSent => $state.composableBuilder(
      column: $state.table.rstSent,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get rstReceived => $state.composableBuilder(
      column: $state.table.rstReceived,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get qth => $state.composableBuilder(
      column: $state.table.qth,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get timestamp => $state.composableBuilder(
      column: $state.table.timestamp,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get gridSquare => $state.composableBuilder(
      column: $state.table.gridSquare,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$QsoLogsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $QsoLogsTable> {
  $$QsoLogsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get callsign => $state.composableBuilder(
      column: $state.table.callsign,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mode => $state.composableBuilder(
      column: $state.table.mode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get frequency => $state.composableBuilder(
      column: $state.table.frequency,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get rstSent => $state.composableBuilder(
      column: $state.table.rstSent,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get rstReceived => $state.composableBuilder(
      column: $state.table.rstReceived,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get qth => $state.composableBuilder(
      column: $state.table.qth,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get timestamp => $state.composableBuilder(
      column: $state.table.timestamp,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get gridSquare => $state.composableBuilder(
      column: $state.table.gridSquare,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ContactsTableCreateCompanionBuilder = ContactsCompanion Function({
  Value<int> id,
  required String callsign,
  Value<String?> name,
  Value<String?> qth,
  Value<String?> gridSquare,
  Value<String?> notes,
  Value<DateTime?> lastContact,
});
typedef $$ContactsTableUpdateCompanionBuilder = ContactsCompanion Function({
  Value<int> id,
  Value<String> callsign,
  Value<String?> name,
  Value<String?> qth,
  Value<String?> gridSquare,
  Value<String?> notes,
  Value<DateTime?> lastContact,
});

class $$ContactsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContactsTable,
    Contact,
    $$ContactsTableFilterComposer,
    $$ContactsTableOrderingComposer,
    $$ContactsTableCreateCompanionBuilder,
    $$ContactsTableUpdateCompanionBuilder> {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ContactsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ContactsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> callsign = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> qth = const Value.absent(),
            Value<String?> gridSquare = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime?> lastContact = const Value.absent(),
          }) =>
              ContactsCompanion(
            id: id,
            callsign: callsign,
            name: name,
            qth: qth,
            gridSquare: gridSquare,
            notes: notes,
            lastContact: lastContact,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String callsign,
            Value<String?> name = const Value.absent(),
            Value<String?> qth = const Value.absent(),
            Value<String?> gridSquare = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime?> lastContact = const Value.absent(),
          }) =>
              ContactsCompanion.insert(
            id: id,
            callsign: callsign,
            name: name,
            qth: qth,
            gridSquare: gridSquare,
            notes: notes,
            lastContact: lastContact,
          ),
        ));
}

class $$ContactsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get callsign => $state.composableBuilder(
      column: $state.table.callsign,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get qth => $state.composableBuilder(
      column: $state.table.qth,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get gridSquare => $state.composableBuilder(
      column: $state.table.gridSquare,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get lastContact => $state.composableBuilder(
      column: $state.table.lastContact,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ContactsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get callsign => $state.composableBuilder(
      column: $state.table.callsign,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get qth => $state.composableBuilder(
      column: $state.table.qth,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get gridSquare => $state.composableBuilder(
      column: $state.table.gridSquare,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get lastContact => $state.composableBuilder(
      column: $state.table.lastContact,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$SettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder> {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SettingsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SettingsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
        ));
}

class $$SettingsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer(super.$state);
  ColumnFilters<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SettingsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$QsoLogsTableTableManager get qsoLogs =>
      $$QsoLogsTableTableManager(_db, _db.qsoLogs);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
