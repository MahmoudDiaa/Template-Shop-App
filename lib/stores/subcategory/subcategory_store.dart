import 'package:boilerplate/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

import '../../data/respository/subcategory_repository.dart';
import '../../models/subcategory/subcategory.dart';
import '../../models/subcategory/subcategory_list.dart';
import '../../models/subcategory/subcategory_query_params.dart';
import '../../utils/dio/dio_error_util.dart';

part 'subcategory_store.g.dart';

class SubCategoryStore = _SubCategoryStore with _$SubCategoryStore;

abstract class _SubCategoryStore with Store {
  // repository instance
  late SubCategoryRepository _subcategoryRepository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _SubCategoryStore(SubCategoryRepository categoryRepository)
      : this._subcategoryRepository = categoryRepository;

  static ObservableFuture<SubCategoryList?> emptySubCategoryResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<SubCategoryList?> fetchSubCategoriesFuture =
      ObservableFuture<SubCategoryList?>(emptySubCategoryResponse);

  @observable
  SubCategoryList? subcategoryList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchSubCategoriesFuture.status == FutureStatus.pending;

  Future<SubCategoryList?> getListFromMemory(
      {SubCategoryQueryParams? subCategoryQueryParams}) {
    if (this.subcategoryList != null) {
      return subCategoryQueryParams == null
          ? Future<SubCategoryList>.value(this.subcategoryList)
          : Future<SubCategoryList>.value(
              this.subcategoryList!.filtered(subCategoryQueryParams));
    } else {
      return Future<SubCategoryList>.value(
          SubCategoryList(subcategories: <SubCategory>[]));
    }
  }

  @action
  Future getSubCategories({
    SubCategoryQueryParams? subCategoryQueryParams,
    bool refreshDataBeforeGetting = false,
  }) async {
    var future;
    // if (!refreshDataBeforeGetting &&
    //     this.subcategoryList != null &&
    //     this.subcategoryList!.isThereData)
    //   future =
    //       getListFromMemory(subCategoryQueryParams: subCategoryQueryParams);
    // else
      future = _subcategoryRepository.getSubCategories(
          categoryId: subCategoryQueryParams?.categoryId);

    fetchSubCategoriesFuture = ObservableFuture(future);
    future.then((categoryList) {
      this.subcategoryList = categoryList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
