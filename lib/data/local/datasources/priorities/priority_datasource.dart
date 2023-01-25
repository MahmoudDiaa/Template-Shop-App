import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/models/PriorityLevels%20/Priority_level_list.dart';
import 'package:boilerplate/models/PriorityLevels%20/priorrity_level.dart';

import 'package:sembast/sembast.dart';

class PrioritiesDataSource {
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _PrioritiesLevelsStore = intMapStoreFactory.store(DBConstants.STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
//  Future<Database> get _db async => await AppDatabase.instance.database;

  // database instance
  final Database _db;

  // Constructor
  PrioritiesDataSource(this._db);

  // DB functions:--------------------------------------------------------------
  Future<int> insert(PriorityLevel PrioritiesLevel) async {
    return await _PrioritiesLevelsStore.add(_db, PrioritiesLevel.toJson());
  }

  Future<int> count() async {
    return await _PrioritiesLevelsStore.count(_db);
  }

  Future<List<PriorityLevel>> getAllSortedByFilter({List<Filter>? filters}) async {
    //creating finder
    final finder = Finder(
        filter: filters != null ? Filter.and(filters) : null,
        sortOrders: [SortOrder(DBConstants.FIELD_ID)]);

    final recordSnapshots = await _PrioritiesLevelsStore.find(
      _db,
      finder: finder,
    );

    // Making a List<PrioritiesLevel> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final PrioritiesLevel = PriorityLevel.fromJson(snapshot.value);
      // An ID is a key of a record from the database.
      PrioritiesLevel.id = snapshot.key;
      return PrioritiesLevel;
    }).toList();
  }

  Future<PriorityLevelList> getPrioritiesLevelsFromDb() async {

    print('Loading from database');

    // PrioritiesLevel list
    var PrioritiesLevelsList;

    // fetching data
    final recordSnapshots = await _PrioritiesLevelsStore.find(
      _db,
    );

    // Making a List<PrioritiesLevel> out of List<RecordSnapshot>
    if(recordSnapshots.length > 0) {
      PrioritiesLevelsList = PriorityLevelList(
          priorities: recordSnapshots.map((snapshot) {
            final PrioritiesLevel = PriorityLevel.fromJson(snapshot.value);
            // An ID is a key of a record from the database.
            PrioritiesLevel.id = snapshot.key;
            return PrioritiesLevel;
          }).toList());
    }

    return PrioritiesLevelsList;
  }

  Future<int> update(PriorityLevel PrioritiesLevel) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(PrioritiesLevel.id));
    return await _PrioritiesLevelsStore.update(
      _db,
      PrioritiesLevel.toJson(),
      finder: finder,
    );
  }

  Future<int> delete(PriorityLevel PrioritiesLevel) async {
    final finder = Finder(filter: Filter.byKey(PrioritiesLevel.id));
    return await _PrioritiesLevelsStore.delete(
      _db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _PrioritiesLevelsStore.drop(
      _db,
    );
  }

}
