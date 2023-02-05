
import '../../../model/login_model.dart';

abstract class ShopRegisterCubitStates {}

class ShopRegisterCubitInitialState extends ShopRegisterCubitStates {}

class ShopRegisterCubitSuccessState extends ShopRegisterCubitStates {
  final ShopLoginModel loginModel;

  ShopRegisterCubitSuccessState(this.loginModel);

}

class ShopRegisterCubitLoadingState extends ShopRegisterCubitStates {
}


class ShopRegisterCubitErrorState extends ShopRegisterCubitStates {
  final error;

  ShopRegisterCubitErrorState(this.error);
}


class ShopRegisterCubitVisibilityState extends ShopRegisterCubitStates {}
