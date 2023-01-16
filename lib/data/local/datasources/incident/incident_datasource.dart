import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/models/incident/incident.dart';
import 'package:boilerplate/models/incident/incident_list.dart';

import 'package:sembast/sembast.dart';

class IncidentDataSource {
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _incidentsStore =
      intMapStoreFactory.store(DBConstants.Categories_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
//  Future<Database> get _db async => await AppDatabase.instance.database;

  // database instance
  final Database _db;

  // Constructor
  IncidentDataSource(this._db);

  // DB functions:--------------------------------------------------------------
  Future<int> insert(Incident incident) async {
    return await _incidentsStore.add(_db, incident.toMap());
  }

  Future<int> count() async {
    return await _incidentsStore.count(_db);
  }

  Future<List<Incident>> getAllSortedByFilter({List<Filter>? filters}) async {
    //creating finder
    final finder = Finder(
        filter: filters != null ? Filter.and(filters) : null,
        sortOrders: [SortOrder(DBConstants.FIELD_ID)]);

    final recordSnapshots = await _incidentsStore.find(
      _db,
      finder: finder,
    );

    // Making a List<Category> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final incident = Incident.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      incident.id = snapshot.key.toString();
      return incident;
    }).toList();
  }

  Future<IncidentList> getPostsFromDb() async {
    print('Loading from database');

    // category list
    var incidentsList;

    // fetching data
    final recordSnapshots = await _incidentsStore.find(
      _db,
    );

    // Making a List<Category> out of List<RecordSnapshot>
    if (recordSnapshots.length > 0) {
      incidentsList = IncidentList(
          incidents: recordSnapshots.map((snapshot) {
        final category = Incident.fromMap(snapshot.value);
        // An ID is a key of a record from the database.
        category.id = snapshot.key.toString();
        return category;
      }).toList());
    }

    return incidentsList;
  }

  Future<int> update(Incident incident) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(incident.id));
    return await _incidentsStore.update(
      _db,
      incident.toMap(),
      finder: finder,
    );
  }

  Future<int> delete(Incident incident) async {
    final finder = Finder(filter: Filter.byKey(incident.id));
    return await _incidentsStore.delete(
      _db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _incidentsStore.drop(
      _db,
    );
  }
}
