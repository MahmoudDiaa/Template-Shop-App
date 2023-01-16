import 'package:boilerplate/data/network/apis/categories/category_api.dart';
import 'package:boilerplate/models/category/category_list.dart';
import 'package:sembast/sembast.dart';

import '../../models/category/category.dart';
import '../local/constants/db_constants.dart';
import '../local/datasources/category/category_datasource.dart';

class CategoryRepository{
  // data source object
  final CategoryDataSource _categoryDataSource;

  // api objects
  final CategoryApi _categoryApi;

  CategoryRepository(this._categoryDataSource, this._categoryApi);

  Future<CategoryList> getCategories() async {
    // check to see if categories are present in database, then fetch from database
    // else make a network call to get all categories, store them into database for
    // later use
    return await _categoryApi.getCategories().then((categoriesList) {
      categoriesList.categories?.forEach((category) {
        _categoryDataSource.insert(category);
      });

      return categoriesList;
    }).catchError((error) => throw error);
  }

  Future<List<Category>> findCategoryById(int id) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
    filters.add(dataLogTypeFilter);

    //making db call
    return _categoryDataSource
        .getAllSortedByFilter(filters: filters)
        .then((categories) => categories)
        .catchError((error) => throw error);
  }

  Future<int> insert(Category category) => _categoryDataSource
      .insert(category)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> update(Category category) => _categoryDataSource
      .update(category)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> delete(Category category) => _categoryDataSource
      .update(category)
      .then((id) => id)
      .catchError((error) => throw error);

}