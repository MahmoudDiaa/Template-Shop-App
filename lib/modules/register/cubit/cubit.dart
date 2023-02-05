import 'package:bmw/modules/register/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/login_model.dart';
import '../../../network/end_points.dart';
import '../../../network/remote/dio_helper.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterCubitStates> {
  ShopRegisterCubit() : super(ShopRegisterCubitInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void userRegister(
      {required String email,
      required String password,
      required String phone,
      required String name}) {
    emit(ShopRegisterCubitLoadingState());
    DioHelper.postData(path: REGISTER, data: {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
    }).then((value) {

      loginModel = ShopLoginModel.formJson(value.data);
      emit(ShopRegisterCubitSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterCubitErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = false;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ShopRegisterCubitVisibilityState());
  }
}
