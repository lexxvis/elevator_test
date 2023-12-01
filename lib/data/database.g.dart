// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $HouseDescriptionsTable extends HouseDescriptions
    with TableInfo<$HouseDescriptionsTable, HouseDescription> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HouseDescriptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _floorsCounterMeta =
      const VerificationMeta('floorsCounter');
  @override
  late final GeneratedColumn<int> floorsCounter = GeneratedColumn<int>(
      'floors', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, floorsCounter];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'house_descriptions';
  @override
  VerificationContext validateIntegrity(Insertable<HouseDescription> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('floors')) {
      context.handle(
          _floorsCounterMeta,
          floorsCounter.isAcceptableOrUnknown(
              data['floors']!, _floorsCounterMeta));
    } else if (isInserting) {
      context.missing(_floorsCounterMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HouseDescription map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HouseDescription(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      floorsCounter: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}floors'])!,
    );
  }

  @override
  $HouseDescriptionsTable createAlias(String alias) {
    return $HouseDescriptionsTable(attachedDatabase, alias);
  }
}

class HouseDescription extends DataClass
    implements Insertable<HouseDescription> {
  final int id;
  final String name;
  final int floorsCounter;
  const HouseDescription(
      {required this.id, required this.name, required this.floorsCounter});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['floors'] = Variable<int>(floorsCounter);
    return map;
  }

  HouseDescriptionsCompanion toCompanion(bool nullToAbsent) {
    return HouseDescriptionsCompanion(
      id: Value(id),
      name: Value(name),
      floorsCounter: Value(floorsCounter),
    );
  }

  factory HouseDescription.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HouseDescription(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      floorsCounter: serializer.fromJson<int>(json['floorsCounter']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'floorsCounter': serializer.toJson<int>(floorsCounter),
    };
  }

  HouseDescription copyWith({int? id, String? name, int? floorsCounter}) =>
      HouseDescription(
        id: id ?? this.id,
        name: name ?? this.name,
        floorsCounter: floorsCounter ?? this.floorsCounter,
      );
  @override
  String toString() {
    return (StringBuffer('HouseDescription(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('floorsCounter: $floorsCounter')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, floorsCounter);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HouseDescription &&
          other.id == this.id &&
          other.name == this.name &&
          other.floorsCounter == this.floorsCounter);
}

class HouseDescriptionsCompanion extends UpdateCompanion<HouseDescription> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> floorsCounter;
  const HouseDescriptionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.floorsCounter = const Value.absent(),
  });
  HouseDescriptionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int floorsCounter,
  })  : name = Value(name),
        floorsCounter = Value(floorsCounter);
  static Insertable<HouseDescription> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? floorsCounter,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (floorsCounter != null) 'floors': floorsCounter,
    });
  }

  HouseDescriptionsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? floorsCounter}) {
    return HouseDescriptionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      floorsCounter: floorsCounter ?? this.floorsCounter,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (floorsCounter.present) {
      map['floors'] = Variable<int>(floorsCounter.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HouseDescriptionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('floorsCounter: $floorsCounter')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $HouseDescriptionsTable houseDescriptions =
      $HouseDescriptionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [houseDescriptions];
}
