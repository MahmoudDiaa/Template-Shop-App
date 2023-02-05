import 'package:bmw/modules/search/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/constants.dart';
import '../../../model/search_products_model_entity.dart';
import '../../../network/end_points.dart';
import '../../../network/remote/dio_helper.dart';


class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(ShopSearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchProductsModelEntity? searchProductsModel;

  void postSearchData(String searchData) {
    emit(ShopLoadingSearchDataState());
    DioHelper.postData(
        path: PRODUCT_SEARCH,
        data: {'text': searchData},
        token: token,
        lang: 'en')
        .then((value) {
      searchProductsModel = SearchProductsModelEntity().fromJson(value.data);
      emit(ShopSuccessSearchDataState(searchProductsModel!));
      print(value.data);
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorSearchDataState(error.toString()));
    });
  }


}
