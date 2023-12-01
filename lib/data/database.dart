import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

///
/// SQL table description
/// [id] - id
/// [name] - String house name
/// [floorsCounter] - int floor counter
///
@DataClassName('HouseDescription')
class HouseDescriptions extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().named('name')();

  IntColumn get floorsCounter => integer().named('floors')();
}

///
/// database initialization
/// don't use schemaVersion , db constant
///
@DriftDatabase(tables: [HouseDescriptions])
class AppDatabase extends _$AppDatabase {

  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

///
/// open database connection
///
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    /// the database file db.sqlite , in the documents folder
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}



