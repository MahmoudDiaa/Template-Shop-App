// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginFormStore on _LoginFormStore, Store {
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin =>
      (_$canLoginComputed ??= Computed<bool>(() => super.canLogin,
              name: '_LoginFormStore.canLogin'))
          .value;
  Computed<bool>? _$canRegisterComputed;

  @override
  bool get canRegister =>
      (_$canRegisterComputed ??= Computed<bool>(() => super.canRegister,
              name: '_LoginFormStore.canRegister'))
          .value;
  Computed<bool>? _$canForgetPasswordComputed;

  @override
  bool get canForgetPassword => (_$canForgetPasswordComputed ??= Computed<bool>(
          () => super.canForgetPassword,
          name: '_LoginFormStore.canForgetPassword'))
      .value;
  Computed<bool>? _$canChangePasswordComputed;

  @override
  bool get canChangePassword => (_$canChangePasswordComputed ??= Computed<bool>(
          () => super.canChangePassword,
          name: '_LoginFormStore.canChangePassword'))
      .value;
  Computed<bool>? _$isSigningInComputed;

  @override
  bool get isSigningIn =>
      (_$isSigningInComputed ??= Computed<bool>(() => super.isSigningIn,
              name: '_LoginFormStore.isSigningIn'))
          .value;
  Computed<bool>? _$isSigningUpComputed;

  @override
  bool get isSigningUp =>
      (_$isSigningUpComputed ??= Computed<bool>(() => super.isSigningUp,
              name: '_LoginFormStore.isSigningUp'))
          .value;

  final _$usernameAtom = Atom(name: '_LoginFormStore.username');

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  final _$firstnameAtom = Atom(name: '_LoginFormStore.firstname');

  @override
  String get firstname {
    _$firstnameAtom.reportRead();
    return super.firstname;
  }

  @override
  set firstname(String value) {
    _$firstnameAtom.reportWrite(value, super.firstname, () {
      super.firstname = value;
    });
  }

  final _$lastnameAtom = Atom(name: '_LoginFormStore.lastname');

  @override
  String get lastname {
    _$lastnameAtom.reportRead();
    return super.lastname;
  }

  @override
  set lastname(String value) {
    _$lastnameAtom.reportWrite(value, super.lastname, () {
      super.lastname = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginFormStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$currentPasswordAtom = Atom(name: '_LoginFormStore.currentPassword');

  @override
  String get currentPassword {
    _$currentPasswordAtom.reportRead();
    return super.currentPassword;
  }

  @override
  set currentPassword(String value) {
    _$currentPasswordAtom.reportWrite(value, super.currentPassword, () {
      super.currentPassword = value;
    });
  }

  final _$confirmPasswordAtom = Atom(name: '_LoginFormStore.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$successAtom = Atom(name: '_LoginFormStore.success');

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

  final _$loadingAtom = Atom(name: '_LoginFormStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$loginFutureAtom = Atom(name: '_LoginFormStore.loginFuture');

  @override
  ObservableFuture<ApiResponse?> get loginFuture {
    _$loginFutureAtom.reportRead();
    return super.loginFuture;
  }

  @override
  set loginFuture(ObservableFuture<ApiResponse?> value) {
    _$loginFutureAtom.reportWrite(value, super.loginFuture, () {
      super.loginFuture = value;
    });
  }

  final _$registerFutureAtom = Atom(name: '_LoginFormStore.registerFuture');

  @override
  ObservableFuture<ApiResponse?> get registerFuture {
    _$registerFutureAtom.reportRead();
    return super.registerFuture;
  }

  @override
  set registerFuture(ObservableFuture<ApiResponse?> value) {
    _$registerFutureAtom.reportWrite(value, super.registerFuture, () {
      super.registerFuture = value;
    });
  }

  final _$currentPasswordFutureAtom =
      Atom(name: '_LoginFormStore.currentPasswordFuture');

  @override
  ObservableFuture<ApiResponse?> get currentPasswordFuture {
    _$currentPasswordFutureAtom.reportRead();
    return super.currentPasswordFuture;
  }

  @override
  set currentPasswordFuture(ObservableFuture<ApiResponse?> value) {
    _$currentPasswordFutureAtom.reportWrite(value, super.currentPasswordFuture,
        () {
      super.currentPasswordFuture = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_LoginFormStore.login');

  @override
  Future<dynamic> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$registerAsyncAction = AsyncAction('_LoginFormStore.register');

  @override
  Future<dynamic> register() {
    return _$registerAsyncAction.run(() => super.register());
  }

  final _$changePasswordAsyncAction =
      AsyncAction('_LoginFormStore.changePassword');

  @override
  Future<dynamic> changePassword() {
    return _$changePasswordAsyncAction.run(() => super.changePassword());
  }

  final _$sendForgetPasswordLinkAsyncAction =
      AsyncAction('_LoginFormStore.sendForgetPasswordLink');

  @override
  Future<dynamic> sendForgetPasswordLink() {
    return _$sendForgetPasswordLinkAsyncAction
        .run(() => super.sendForgetPasswordLink());
  }

  final _$logoutAsyncAction = AsyncAction('_LoginFormStore.logout');

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$_LoginFormStoreActionController =
      ActionController(name: '_LoginFormStore');

  @override
  void setUserId(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.setUserId');
    try {
      return super.setUserId(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFirstName(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.setFirstName');
    try {
      return super.setFirstName(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastName(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.setLastName');
    try {
      return super.setLastName(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentPassword(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.setCurrentPassword');
    try {
      return super.setCurrentPassword(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserEmail(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.validateUserEmail');
    try {
      return super.validateUserEmail(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateFirstName(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.validateFirstName');
    try {
      return super.validateFirstName(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateLastName(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.validateLastName');
    try {
      return super.validateLastName(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConfirmPassword(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.validateConfirmPassword');
    try {
      return super.validateConfirmPassword(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCurrentPassword(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
        name: '_LoginFormStore.validateCurrentPassword');
    try {
      return super.validateCurrentPassword(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
username: ${username},
firstname: ${firstname},
lastname: ${lastname},
password: ${password},
currentPassword: ${currentPassword},
confirmPassword: ${confirmPassword},
success: ${success},
loading: ${loading},
loginFuture: ${loginFuture},
registerFuture: ${registerFuture},
currentPasswordFuture: ${currentPasswordFuture},
canLogin: ${canLogin},
canRegister: ${canRegister},
canForgetPassword: ${canForgetPassword},
canChangePassword: ${canChangePassword},
isSigningIn: ${isSigningIn},
isSigningUp: ${isSigningUp}
    ''';
  }
}

mixin _$LoginFormErrorStore on _LoginFormErrorStore, Store {
  Computed<bool>? _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??= Computed<bool>(
          () => super.hasErrorsInLogin,
          name: '_LoginFormErrorStore.hasErrorsInLogin'))
      .value;
  Computed<bool>? _$hasErrorsInRegisterComputed;

  @override
  bool get hasErrorsInRegister => (_$hasErrorsInRegisterComputed ??=
          Computed<bool>(() => super.hasErrorsInRegister,
              name: '_LoginFormErrorStore.hasErrorsInRegister'))
      .value;
  Computed<bool>? _$hasErrorInForgotPasswordComputed;

  @override
  bool get hasErrorInForgotPassword => (_$hasErrorInForgotPasswordComputed ??=
          Computed<bool>(() => super.hasErrorInForgotPassword,
              name: '_LoginFormErrorStore.hasErrorInForgotPassword'))
      .value;
  Computed<bool>? _$hasErrorInChangePasswordComputed;

  @override
  bool get hasErrorInChangePassword => (_$hasErrorInChangePasswordComputed ??=
          Computed<bool>(() => super.hasErrorInChangePassword,
              name: '_LoginFormErrorStore.hasErrorInChangePassword'))
      .value;

  final _$userEmailAtom = Atom(name: '_LoginFormErrorStore.userEmail');

  @override
  String? get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String? value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  final _$firstNameAtom = Atom(name: '_LoginFormErrorStore.firstName');

  @override
  String? get firstName {
    _$firstNameAtom.reportRead();
    return super.firstName;
  }

  @override
  set firstName(String? value) {
    _$firstNameAtom.reportWrite(value, super.firstName, () {
      super.firstName = value;
    });
  }

  final _$lastNameAtom = Atom(name: '_LoginFormErrorStore.lastName');

  @override
  String? get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String? value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginFormErrorStore.password');

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$confirmPasswordAtom =
      Atom(name: '_LoginFormErrorStore.confirmPassword');

  @override
  String? get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String? value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$currentPasswordAtom =
      Atom(name: '_LoginFormErrorStore.currentPassword');

  @override
  String? get currentPassword {
    _$currentPasswordAtom.reportRead();
    return super.currentPassword;
  }

  @override
  set currentPassword(String? value) {
    _$currentPasswordAtom.reportWrite(value, super.currentPassword, () {
      super.currentPassword = value;
    });
  }

  @override
  String toString() {
    return '''
userEmail: ${userEmail},
firstName: ${firstName},
lastName: ${lastName},
password: ${password},
confirmPassword: ${confirmPassword},
currentPassword: ${currentPassword},
hasErrorsInLogin: ${hasErrorsInLogin},
hasErrorsInRegister: ${hasErrorsInRegister},
hasErrorInForgotPassword: ${hasErrorInForgotPassword},
hasErrorInChangePassword: ${hasErrorInChangePassword}
    ''';
  }
}
