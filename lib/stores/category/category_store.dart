import 'package:boilerplate/data/respository/category_repository.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

import '../../models/category/category.dart';
import '../../models/category/category_list.dart';
import '../../utils/dio/dio_error_util.dart';

part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  // repository instance
  late CategoryRepository _categoryRepository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _CategoryStore(CategoryRepository categoryRepository)
      : this._categoryRepository = categoryRepository;

  static ObservableFuture<CategoryList?> emptyCategoryResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<CategoryList?> fetchCategoriesFuture =
      ObservableFuture<CategoryList?>(emptyCategoryResponse);

  @observable
  CategoryList? categoryList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchCategoriesFuture.status == FutureStatus.pending;

  Future<CategoryList?> getListFromMemory() {
    if (this.categoryList != null) {
      return Future<CategoryList>.value(this.categoryList);
    } else {
      return Future<CategoryList>.value(CategoryList(categories: <Category>[]));
    }
  }

  @action
  Future getCategories({
    bool refreshDataBeforeGetting = false,
  }) async {
    var future;

    if (!refreshDataBeforeGetting &&
        this.categoryList != null &&
        this.categoryList!.isThereData)
      future = getListFromMemory();
    else
      future = _categoryRepository.getCategories();

    fetchCategoriesFuture = ObservableFuture(future);
    future.then((categoryList) {
      this.categoryList = categoryList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
