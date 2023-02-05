import 'package:bloc/bloc.dart';
import 'package:bmw/layout/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/constants.dart';
import '../../model/categories_model.dart';
import '../../model/changeFavouriteMode;.dart';
import '../../model/favorite_model_entity.dart';
import '../../model/home_model.dart';
import '../../model/login_model.dart';
import '../../modules/categories/cateigories_screen.dart';
import '../../modules/favourite/favourite_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../network/end_points.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_helper.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    var token = CacheHelper.getData(key: 'token');
    DioHelper.getData(path: HOME, query: null, token: token, lang: 'en')
        .then((value) {
      homeModel = HomeModel.formJson(value.data);

      for (var element in homeModel!.data!.products!) {
        favorites.addAll({element.id!: element.inFavourites!});
      }

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print('error $error');
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(path: GET_CATEGORIES, query: null, lang: 'en')
        .then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print('home data ${categoriesModel!.data}');
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print('error $error');
      emit(ShopErrorCategoriesDataState(error.toString()));
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void postFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;

    emit(ShopSuccessFavoritesDataState());
    DioHelper.postData(
            path: FAVORITES,
            data: {'product_id': productId},
            token: token,
            lang: 'en')
        .then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if (!changeFavoriteModel!.status!) {
        favorites[productId] = !favorites[productId]!;
        emit(ShopErrorFavoritesDataState(changeFavoriteModel!.message!));
      } else {
        getFavoritesData();
      }
      print(value.data);
      emit(ShopSuccessFavoritesDataState());
    }).catchError((error) {
      print(error.toString());
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorFavoritesDataState(error.toString()));
    });
  }

  FavoriteModelEntity? favoriteModel;

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesDataState());
    DioHelper.getData(path: FAVORITES, query: null, lang: 'en', token: token)
        .then((value) {
      favoriteModel = FavoriteModelEntity().fromJson(value.data);
      print('fav data ${favoriteModel!.data}');
      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((error) {
      print('error $error');
      emit(ShopErrorGetFavoritesDataState(error.toString()));
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(path: PROFILE, query: null, lang: 'en', token: token)
        .then((value) {
      userModel = ShopLoginModel.formJson(value.data);
      print('userModel data ${userModel!.data}');
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      print('error $error');
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }

  void getUserUpdateData(
      {required String email, required String phone, required String name}) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
        path: UPDATE_PROFILE,
        query: null,
        lang: 'en',
        token: token,
        data: {
          'email': email,
          'phone': phone,
          'name': name,
        }).then((value) {
      userModel = ShopLoginModel.formJson(value.data);
      print('getUserUpdateData data ${userModel!.data}');
      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((error) {
      print('error $error');
      emit(ShopErrorUpdateUserDataState(error.toString()));
    });
  }


}
