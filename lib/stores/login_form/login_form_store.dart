import 'package:boilerplate/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

import '../../data/network/api_response.dart';
import '../../data/respository/user_repository.dart';
import '../../models/user/auth_user.dart';

part 'login_form_store.g.dart';

class LoginFormStore = _LoginFormStore with _$LoginFormStore;

abstract class _LoginFormStore with Store {
  // store for handling form errors
  final LoginFormErrorStore formErrorStore = LoginFormErrorStore();

  // repository instance
  final UserRepository _repository;

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _LoginFormStore(this._repository) {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => username, validateUserEmail),
      reaction((_) => firstname, validateFirstName),
      reaction((_) => lastname, validateLastName),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword),
      reaction((_) => currentPassword, validateCurrentPassword)
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String username = '';

  @observable
  String firstname = '';

  @observable
  String lastname = '';

  @observable
  String password = '';

  @observable
  String currentPassword = '';

  @observable
  String confirmPassword = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin &&
      username.isNotEmpty &&
      password.isNotEmpty;

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister &&
      username.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && username.isNotEmpty;

  @computed
  bool get canChangePassword =>
      !formErrorStore.hasErrorInChangePassword &&
      currentPassword.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) {
    username = value;
  }

  @action
  void setFirstName(String value) {
    firstname = value;
  }

  @action
  void setLastName(String value) {
    lastname = value;
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
  void setCurrentPassword(String value) {
    currentPassword = value;
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "Email can't be empty";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Please enter a valid email address';
    } else {
      formErrorStore.userEmail = null;
    }
  }

  @action
  void validateFirstName(String value) {
    if (value.isEmpty) {
      formErrorStore.firstName = "first name can't be empty";
    } else {
      formErrorStore.firstName = null;
    }
  }

  @action
  void validateLastName(String value) {
    if (value.isEmpty) {
      formErrorStore.lastName = "last name can't be empty";
    } else {
      formErrorStore.lastName = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "Password can't be empty";
    } else if (value.length < 6) {
      formErrorStore.password = "Password must be at-least 6 characters long";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.confirmPassword = "Confirm password can't be empty";
    } else if (value != password) {
      formErrorStore.confirmPassword = "Password doesn't match";
    } else {
      formErrorStore.confirmPassword = null;
    }
  }

  @action
  void validateCurrentPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.currentPassword = "Current password can't be empty";
    } else {
      formErrorStore.currentPassword = null;
    }
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<ApiResponse?> emptyLoginResponse =
      ObservableFuture.value(null);
  @observable
  ObservableFuture<ApiResponse?> loginFuture = emptyLoginResponse;

  @observable
  ObservableFuture<ApiResponse?> registerFuture = ObservableFuture.value(null);

  @observable
  ObservableFuture<ApiResponse?> currentPasswordFuture =
      ObservableFuture.value(null);

  @computed
  bool get isSigningIn => loginFuture.status == FutureStatus.pending;

  @computed
  bool get isSigningUp => registerFuture.status == FutureStatus.pending;

  // bool to check if current user is logged in
  bool isLoggedIn = false;

  @action
  Future login() async {
    loading = true;
    final future = _repository.login(this.username, this.password);
    loginFuture = ObservableFuture(future);
    await future.then((value) async {
      this.loading = false;
      if (value?.authUser?.access_token != null) {
        _repository.saveIsLoggedIn(true);
        _repository.saveLoggedInUser(value!.authUser!);

        this.isLoggedIn = true;
        this.success = true;
      } else {
        this.success = false;
        this.isLoggedIn = false;
        _repository.saveIsLoggedIn(false);
        errorStore.errorMessage = value?.message ?? 'Cannot login. try again';
        print('failed to login');
      }
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      loading = false;

      errorStore.errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
          ? "Username and password doesn't match"
          : "Something went wrong, please check your internet connection and try again";
      print(e);
    });
  }

  @action
  Future register() async {
    loading = true;
    final future = _repository.register(
        this.firstname, this.lastname, this.username, this.username, password);
    registerFuture = ObservableFuture(future);
    await future.then((value) async {
      this.loading = false;
      if (value != null && value!.success! == true) {
        this.success = true;
      } else {
        this.success = false;
        errorStore.errorMessage = "failed to register. ${value?.message ?? ''}";
        print('failed to register');
      }
    }).catchError((e) {
      print(e);

      this.success = false;
      loading = false;

      errorStore.errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
          ? "Username and password doesn't match"
          : "Something went wrong, please check your internet connection and try again";
      print(e);
    });
  }

  @action
  Future changePassword() async {
    loading = true;
    final future = _repository.changePassword(this.currentPassword, password);
    currentPasswordFuture = ObservableFuture(future);
    await future.then((value) async {
      this.loading = false;
      if (value != null && value!.success! == true) {
        this.success = true;
      } else {
        this.success = false;
        errorStore.errorMessage =
            "failed to change password. ${value?.message ?? ''}";
        print('failed to change password');
      }
    }).catchError((e) {
      print(e);

      this.success = false;
      loading = false;

      errorStore.errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
          ? "password doesn't match"
          : "Something went wrong, please check your internet connection and try again";
      print(e);
    });
  }

  @action
  Future sendForgetPasswordLink() async {
    loading = true;
    final future = _repository.sendForgetPasswordLink(this.username);
    registerFuture = ObservableFuture(future);
    await future.then((value) async {
      this.loading = false;
      if (value != null && value!.success! == true) {
        //this.isLoggedIn = true;
        this.success = true;
      } else {
        this.success = false;

        errorStore.errorMessage =
            "failed to send forget password link. ${value?.message ?? ''}";
      }
    }).catchError((e) {
      print(e);

      this.success = false;
      loading = false;

      errorStore.errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
          ? "Username and password doesn't match"
          : "Something went wrong, please check your internet connection and try again";
      print(e);
    });
  }

  @action
  Future logout() async {
    loading = true;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateUserEmail(username);
    validateFirstName(firstname);
    validateLastName(lastname);
  }
}

class LoginFormErrorStore = _LoginFormErrorStore with _$LoginFormErrorStore;

abstract class _LoginFormErrorStore with Store {
  @observable
  String? userEmail;

  @observable
  String? firstName;

  @observable
  String? lastName;

  @observable
  String? password;

  @observable
  String? confirmPassword;

  @observable
  String? currentPassword;

  @computed
  bool get hasErrorsInLogin => userEmail != null || password != null;

  @computed
  bool get hasErrorsInRegister =>
      userEmail != null ||
      password != null ||
      confirmPassword != null ||
      firstName != null ||
      lastName != null;

  @computed
  bool get hasErrorInForgotPassword => userEmail != null;

  @computed
  bool get hasErrorInChangePassword =>
      currentPassword != null || password != null || confirmPassword != null;
}
