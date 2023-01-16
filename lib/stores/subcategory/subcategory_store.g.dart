// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategory_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SubCategoryStore on _SubCategoryStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_SubCategoryStore.loading'))
      .value;

  final _$fetchSubCategoriesFutureAtom =
      Atom(name: '_SubCategoryStore.fetchSubCategoriesFuture');

  @override
  ObservableFuture<SubCategoryList?> get fetchSubCategoriesFuture {
    _$fetchSubCategoriesFutureAtom.reportRead();
    return super.fetchSubCategoriesFuture;
  }

  @override
  set fetchSubCategoriesFuture(ObservableFuture<SubCategoryList?> value) {
    _$fetchSubCategoriesFutureAtom
        .reportWrite(value, super.fetchSubCategoriesFuture, () {
      super.fetchSubCategoriesFuture = value;
    });
  }

  final _$subcategoryListAtom = Atom(name: '_SubCategoryStore.subcategoryList');

  @override
  SubCategoryList? get subcategoryList {
    _$subcategoryListAtom.reportRead();
    return super.subcategoryList;
  }

  @override
  set subcategoryList(SubCategoryList? value) {
    _$subcategoryListAtom.reportWrite(value, super.subcategoryList, () {
      super.subcategoryList = value;
    });
  }

  final _$successAtom = Atom(name: '_SubCategoryStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$getSubCategoriesAsyncAction =
      AsyncAction('_SubCategoryStore.getSubCategories');

  @override
  Future<dynamic> getSubCategories(
      {SubCategoryQueryParams? subCategoryQueryParams,
      bool refreshDataBeforeGetting = false}) {
    return _$getSubCategoriesAsyncAction.run(() => super.getSubCategories(
        subCategoryQueryParams: subCategoryQueryParams,
        refreshDataBeforeGetting: refreshDataBeforeGetting));
  }

  @override
  String toString() {
    return '''
fetchSubCategoriesFuture: ${fetchSubCategoriesFuture},
subcategoryList: ${subcategoryList},
success: ${success},
loading: ${loading}
    ''';
  }
}