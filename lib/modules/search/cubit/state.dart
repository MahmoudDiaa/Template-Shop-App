
import '../../../model/search_products_model_entity.dart';

abstract class SearchStates {}

class ShopSearchInitialState extends SearchStates {}

class ShopSuccessSearchDataState extends SearchStates {
  final SearchProductsModelEntity SearchModel;

  ShopSuccessSearchDataState(this.SearchModel);
}

class ShopLoadingSearchDataState extends SearchStates {}

class ShopErrorSearchDataState extends SearchStates {
  final error;

  ShopErrorSearchDataState(this.error);
}
