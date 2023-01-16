import 'package:boilerplate/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

import '../../data/network/api_response.dart';
import '../../data/respository/user_repository.dart';

part 'forget_password_form_store.g.dart';

class ForgetPasswordFormStore = _ForgetPasswordFormStore
    with _$ForgetPasswordFormStore;

abstract class _ForgetPasswordFormStore with Store {
  // store for handling form errors
  final ForgetPasswordFormErrorStore forgetPasswordFormErrorStore =
      ForgetPasswordFormErrorStore();

  // repository instance
  final UserRepository _repository;

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _ForgetPasswordFormStore(this._repository) {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => email, validateUserEmail),
      reaction((_) => code, validateCode),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword),
    ];
  }

  // store variables:-----------------------------------------------------------

  @observable
  String email = '';

  @observable
  String code = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  bool codeSent = false;

  @observable
  bool sendingCode = false;

  @observable
  bool changingPassword = false;

  @observable
  bool passwordChanged = false;

  @computed
  bool get canSendForgetPasswordCode =>
      !forgetPasswordFormErrorStore.hasErrorsInEmail && email.isNotEmpty;

  @computed
  bool get canChangePassword =>
      !forgetPasswordFormErrorStore.hasErrorsInPasswsord &&
      !forgetPasswordFormErrorStore.hasErrorsInCode &&
      code.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setCode(String value) {
    code = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      forgetPasswordFormErrorStore.userEmailError = "Email can't be empty";
    } else if (!isEmail(value)) {
      forgetPasswordFormErrorStore.userEmailError =
          'Please enter a valid email address';
    } else {
      forgetPasswordFormErrorStore.userEmailError = null;
    }
  }

  @action
  void validateCode(String value) {
    if (value.isEmpty) {
      forgetPasswordFormErrorStore.userEmailError = "Email can't be empty";
    } else if (!isEmail(value)) {
      forgetPasswordFormErrorStore.userEmailError =
          'Please enter a valid email address';
    } else {
      forgetPasswordFormErrorStore.userEmailError = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      forgetPasswordFormErrorStore.passwordError = "Password can't be empty";
    } else if (value.length < 6) {
      forgetPasswordFormErrorStore.passwordError =
          "Password must be at-least 6 characters long";
    } else {
      forgetPasswordFormErrorStore.passwordError = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      forgetPasswordFormErrorStore.confirmPasswordError =
          "Confirm password can't be empty";
    } else if (value != password) {
      forgetPasswordFormErrorStore.confirmPasswordError =
          "Password doesn't match";
    } else {
      forgetPasswordFormErrorStore.confirmPasswordError = null;
    }
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<ApiResponse?> emptyForgetPasswordResponse =
      ObservableFuture.value(null);
  @observable
  ObservableFuture<ApiResponse?> SendForgetPasswordCodeFuture =
      emptyForgetPasswordResponse;

  @observable
  ObservableFuture<ApiResponse?> resetPasswordFuture =
      emptyForgetPasswordResponse;

  @computed
  bool get isSendingCodeIn =>
      SendForgetPasswordCodeFuture.status == FutureStatus.pending;

  @computed
  bool get isChangingPassword =>
      resetPasswordFuture.status == FutureStatus.pending;

  // bool to check if current user is logged in
  //bool isCodeSent = false;
  //bool isPasswordChanged = false;

  @action
  Future<ApiResponse?> sendForgetPasswordCode() async {
    sendingCode = true;
    final future = _repository.sendForgetPasswordLink(this.email);
    SendForgetPasswordCodeFuture = ObservableFuture(future);

    await future.then((value) async {
      this.sendingCode = false;
      if (value != null && value!.success! == true) {
        this.codeSent = true;
      } else {
        this.codeSent = false;

        errorStore.errorMessage =
            "failed to send forget password code. ${value?.message ?? ''}";
      }
    }).catchError((e) {
      print(e);

      this.codeSent = false;
      sendingCode = false;

      errorStore.errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
          ? "There is an error"
          : "Something went wrong, please check your internet connection and try again";
      print(e);
    });
    return future;
  }

  @action
  Future<ApiResponse?> resetPassword() async {
    changingPassword = true;
    final future =
        _repository.resetPassword(this.code, this.email, this.password);
    resetPasswordFuture = ObservableFuture(future);

    await future.then((value) async {
      this.changingPassword = false;
      if (value != null && value!.success! == true) {
        this.passwordChanged = true;
      } else {
        this.passwordChanged = false;

        errorStore.errorMessage =
            "failed to reset password. ${value?.message ?? ''}";
      }
    }).catchError((e) {
      print(e);

      this.passwordChanged = false;
      changingPassword = false;

      errorStore.errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
          ? "There is an error"
          : "Something went wrong, please check your internet connection and try again";
      print(e);
    });
    return future;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

// void validateAll() {
//   validatePassword(password);
// }
}

class ForgetPasswordFormErrorStore = _ForgetPasswordFormErrorStore
    with _$ForgetPasswordFormErrorStore;

abstract class _ForgetPasswordFormErrorStore with Store {
  @observable
  String? userEmailError;

  @observable
  String? codeError;

  @observable
  String? passwordError;

  @observable
  String? confirmPasswordError;

  bool get hasErrorsInEmail => userEmailError != null;

  bool get hasErrorsInCode => codeError != null;

  bool get hasErrorsInPasswsord =>
      passwordError != null || confirmPasswordError != null;
}
