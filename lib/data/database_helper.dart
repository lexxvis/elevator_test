import 'database.dart';

///
/// database helper class
/// insertItem method - insert record [name, floor count]
/// getAllItems return all records from database in stream
///
class DatabaseHelper {
  final database = AppDatabase();

  Future<void> insetItem(
      {required String name, required int floorsCount}) async {
    await database.into(database.houseDescriptions).insert(
        HouseDescriptionsCompanion.insert(
            name: name, floorsCounter: floorsCount));
  }

  Stream<(String, int)> getAllItems() async* {
    final allItems = await database.select(database.houseDescriptions).get();
    for (final element in allItems) {
      yield (element.name, element.floorsCounter);
    }
  }

}
