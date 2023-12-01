import 'package:flutter/cupertino.dart';

import 'main.dart';

///
/// store list of houses loaded from SQLite database
/// element (String name, int floors count
///
class AppModel with ChangeNotifier {
  final _houses = <(String, int)>[];

  (String, int) fetchElement(int i) {
    /// return error value if index incorrect
    if (i >= _houses.length) return ('error', 0);
    return _houses[i];
  }

  int get length => _houses.length;

  void updateList({required int floorsCount, required String name}) {
    _houses.insert(0, (name, floorsCount));
    notifyListeners();
  }

  Future<void> insert({required int floorsCount, required String name}) async {
    await databaseHelper.insetItem(name: name, floorsCount: floorsCount);
    _houses.insert(0, (name, floorsCount));
    notifyListeners();
  }
}