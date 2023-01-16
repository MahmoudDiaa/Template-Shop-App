import 'package:boilerplate/data/network/apis/subcategories/subcategory_api.dart';
import 'package:sembast/sembast.dart';

import '../../models/subcategory/subcategory.dart';
import '../../models/subcategory/subcategory_list.dart';
import '../local/constants/db_constants.dart';
import '../local/datasources/subcategory/subcategory_datasource.dart';

class SubCategoryRepository {
  // data source object
  final SubCategoryDataSource _subcategoryDataSource;

  // api objects
  final SubCategoryApi _categoryApi;

  SubCategoryRepository(this._subcategoryDataSource, this._categoryApi);

  Future<SubCategoryList> getSubCategories({categoryId}) async {
    // check to see if categories are present in database, then fetch from database
    // else make a network call to get all categories, store them into database for
    // later use
    return await _categoryApi
        .getCategories(categoryId: categoryId)
        .then((categoriesList) {
      categoriesList.subcategories?.forEach((category) {
        _subcategoryDataSource.insert(category);
      });

      return categoriesList;
    }).catchError((error) => throw error);
  }

  Future<List<SubCategory>> findSubCategoryById(int id) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
    filters.add(dataLogTypeFilter);

    //making db call
    return _subcategoryDataSource
        .getAllSortedByFilter(filters: filters)
        .then((categories) => categories)
        .catchError((error) => throw error);
  }

  Future<int> insert(SubCategory category) => _subcategoryDataSource
      .insert(category)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> update(SubCategory category) => _subcategoryDataSource
      .update(category)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> delete(SubCategory category) => _subcategoryDataSource
      .update(category)
      .then((id) => id)
      .catchError((error) => throw error);
}
