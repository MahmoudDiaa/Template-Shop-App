import 'package:boilerplate/data/local/constants/db_constants.dart';

import 'package:sembast/sembast.dart';

import '../../../../models/subcategory/subcategory.dart';
import '../../../../models/subcategory/subcategory_list.dart';


class SubCategoryDataSource {
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _subcategoriesStore = intMapStoreFactory.store(DBConstants.SubCategories_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
//  Future<Database> get _db async => await AppDatabase.instance.database;

  // database instance
  final Database _db;

  // Constructor
  SubCategoryDataSource(this._db);

  // DB functions:--------------------------------------------------------------
  Future<int> insert(SubCategory subcategory) async {
    return await _subcategoriesStore.add(_db, subcategory.toMap());
  }

  Future<int> count() async {
    return await _subcategoriesStore.count(_db);
  }

  Future<List<SubCategory>> getAllSortedByFilter({List<Filter>? filters}) async {
    //creating finder
    final finder = Finder(
        filter: filters != null ? Filter.and(filters) : null,
        sortOrders: [SortOrder(DBConstants.FIELD_ID)]);

    final recordSnapshots = await _subcategoriesStore.find(
      _db,
      finder: finder,
    );

    // Making a List<Category> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final subcategory = SubCategory.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      subcategory.id = snapshot.key;
      return subcategory;
    }).toList();
  }

  Future<SubCategoryList> getPostsFromDb() async {

    print('Loading from database');

    // category list
    var subcategoriesList;

    // fetching data
    final recordSnapshots = await _subcategoriesStore.find(
      _db,
    );

    // Making a List<Category> out of List<RecordSnapshot>
    if(recordSnapshots.length > 0) {
      subcategoriesList = SubCategoryList(
          subcategories: recordSnapshots.map((snapshot) {
            final category = SubCategory.fromMap(snapshot.value);
            // An ID is a key of a record from the database.
            category.id = snapshot.key;
            return category;
          }).toList());
    }

    return subcategoriesList;
  }

  Future<int> update(SubCategory category) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(category.id));
    return await _subcategoriesStore.update(
      _db,
      category.toMap(),
      finder: finder,
    );
  }

  Future<int> delete(SubCategory category) async {
    final finder = Finder(filter: Filter.byKey(category.id));
    return await _subcategoriesStore.delete(
      _db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _subcategoriesStore.drop(
      _db,
    );
  }

}
