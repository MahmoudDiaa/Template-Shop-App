import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../data/respository/user_repository.dart';
import '../../stores/forget_password_form/forget_password_form_store.dart';
import '../../utils/device/device_utils.dart';
import '../../utils/locale/app_localization.dart';
import '../../widgets/textfield_widget.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';

final TextEditingController emailController = TextEditingController();

class MyDialog1 {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  ForgetPasswordFormStore _forgetPasswordFormStore =
      ForgetPasswordFormStore(GetIt.instance<UserRepository>());

  forgotPassword(BuildContext context) async {
    _forgetPasswordFormStore =
        ForgetPasswordFormStore(GetIt.instance<UserRepository>());
    _codeController = TextEditingController();
    return (await showDialog(
          barrierDismissible: true,
          context: context,
          barrierColor: Colors.black.withOpacity(0.6),
          builder: (context) => new AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('forgetPassword'),
                    style: TextStyle(
                      fontSize: Dimensions.extraLargeTextSize,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Observer(
                        builder: (context) {
                          return !_forgetPasswordFormStore.codeSent
                              ? TextFieldWidget(
                                  hint: AppLocalizations.of(context)
                                      .translate('login_et_user_email'),
                                  inputType: TextInputType.emailAddress,
                                  icon: Icons.person,
                                  iconColor: Colors.black54,
                                  textController: emailController,
                                  inputAction: TextInputAction.next,
                                  autoFocus: false,
                                  onChanged: (value) {
                                    _forgetPasswordFormStore
                                        .setEmail(emailController.text);
                                  },
                                  onFieldSubmitted: (value) {
                                    // FocusScope.of(context)
                                    //     .requestFocus(_passwordFocusNode);
                                  },
                                  errorText: _forgetPasswordFormStore
                                      .forgetPasswordFormErrorStore
                                      .userEmailError,
                                )
                              : Container(
                                  height: 300,
                                  child: Column(
                                    children: [
                                      TextFieldWidget(
                                        hint: AppLocalizations.of(context)
                                            .translate('enterCode'),
                                        inputType: TextInputType.text,
                                        icon: Icons.text_decrease,
                                        iconColor: Colors.black54,
                                        textController: _codeController,
                                        inputAction: TextInputAction.next,
                                        autoFocus: false,
                                        onChanged: (value) {
                                          _forgetPasswordFormStore
                                              .setCode(_codeController.text);
                                        },
                                        onFieldSubmitted: (value) {
                                          // FocusScope.of(context)
                                          //     .requestFocus(_passwordFocusNode);
                                        },
                                        errorText: _forgetPasswordFormStore
                                            .forgetPasswordFormErrorStore
                                            .codeError,
                                      ),
                                      TextFieldWidget(
                                        hint: AppLocalizations.of(context)
                                            .translate(
                                                'login_et_user_password'),
                                        inputType: TextInputType.text,
                                        icon: Icons.text_decrease,
                                        iconColor: Colors.black54,
                                        textController: _passwordController,
                                        inputAction: TextInputAction.next,
                                        autoFocus: false,
                                        onChanged: (value) {
                                          _forgetPasswordFormStore.setPassword(
                                              _passwordController.text);
                                        },
                                        onFieldSubmitted: (value) {
                                          // FocusScope.of(context)
                                          //     .requestFocus(_passwordFocusNode);
                                        },
                                        errorText: _forgetPasswordFormStore
                                            .forgetPasswordFormErrorStore
                                            .passwordError,
                                      ),
                                      TextFieldWidget(
                                        hint: AppLocalizations.of(context)
                                            .translate(
                                                'login_et_user_password_again'),
                                        inputType: TextInputType.text,
                                        icon: Icons.text_decrease,
                                        iconColor: Colors.black54,
                                        textController:
                                            _confirmPasswordController,
                                        inputAction: TextInputAction.next,
                                        autoFocus: false,
                                        onChanged: (value) {
                                          _forgetPasswordFormStore
                                              .setConfirmPassword(
                                                  _confirmPasswordController
                                                      .text);
                                        },
                                        onFieldSubmitted: (value) {
                                          // FocusScope.of(context)
                                          //     .requestFocus(_passwordFocusNode);
                                        },
                                        errorText: _forgetPasswordFormStore
                                            .forgetPasswordFormErrorStore
                                            .confirmPasswordError,
                                      ),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                  Observer(
                    builder: (context) {
                      if (_forgetPasswordFormStore.codeSent) {
                        //_forgetPasswordFormStore.success = false;
                        Future.delayed(Duration(milliseconds: 0), () {
                          FlushbarHelper.createSuccess(
                            message: AppLocalizations.of(context)
                                .translate('checkMailForForgetPassword'),
                            title: AppLocalizations.of(context)
                                .translate('forgetPassword'),
                            duration: Duration(seconds: 3),
                          )..show(context);
                        });

                        _forgetPasswordFormStore.setEmail('');
                      }

                      return (_forgetPasswordFormStore.codeSent &&
                              _forgetPasswordFormStore.email != '')
                          ? Text(
                              'link sent to your email',
                              style: TextStyle(color: CustomColor.primaryColor),
                            )
                          : Text(
                              '',
                              style: TextStyle(color: Colors.red),
                            );
                      // ? navigate(context)
                      // : _showErrorMessage(
                      // _signup_store.errorStore.errorMessage);
                    },
                  ),
                  Observer(
                    builder: (context) {
                      return _forgetPasswordFormStore.sendingCode
                          ? Text('Sending code...')
                          : InkWell(
                              child: Container(
                                height: 60.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: CustomColor.primaryColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Dimensions.radius))),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('sendForgetPasswordCode'),
                                    style: TextStyle(
                                        fontSize: Dimensions.extraLargeTextSize,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (_forgetPasswordFormStore
                                    .canSendForgetPasswordCode) {
                                  DeviceUtils.hideKeyboard(context);
                                  _forgetPasswordFormStore
                                      .sendForgetPasswordCode();
                                } else {
                                  Future.delayed(Duration(milliseconds: 0), () {
                                    FlushbarHelper.createError(
                                      message: 'ddd',
                                      title: AppLocalizations.of(context)
                                          .translate('home_tv_error'),
                                      duration: Duration(seconds: 3),
                                    )..show(context);
                                  });
                                }
                                // Navigator.of(context).pop();
                              },
                            );
                    },
                  )
                ],
              ),
            ),
          ),
        )) ??
        false;
  }

  @override
  dispose() {
    _forgetPasswordFormStore.setEmail('');
    _emailController.dispose();
    _emailController.clear();
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog({Key? key}) : super(key: key);

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  ForgetPasswordFormStore _forgetPasswordFormStore =
      ForgetPasswordFormStore(GetIt.instance<UserRepository>());

  @override
  void didChangeDependencies() {
    _forgetPasswordFormStore =
        ForgetPasswordFormStore(GetIt.instance<UserRepository>());
    _codeController = TextEditingController();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _forgetPasswordFormStore.setEmail('');
    _emailController.clear();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context).translate('forgetPassword'),
            style: TextStyle(
              fontSize: Dimensions.extraLargeTextSize,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Observer(
                builder: (context) {
                  return !_forgetPasswordFormStore.codeSent
                      ? TextFieldWidget(
                          hint: AppLocalizations.of(context)
                              .translate('login_et_user_email'),
                          inputType: TextInputType.emailAddress,
                          icon: Icons.person,
                          iconColor: Colors.black54,
                          textController: emailController,
                          inputAction: TextInputAction.next,
                          autoFocus: false,
                          onChanged: (value) {
                            _forgetPasswordFormStore
                                .setEmail(emailController.text);
                          },
                          onFieldSubmitted: (value) {
                            // FocusScope.of(context)
                            //     .requestFocus(_passwordFocusNode);
                          },
                          errorText: _forgetPasswordFormStore
                              .forgetPasswordFormErrorStore.userEmailError,
                        )
                      : Container(
                          height: 200,
                          child: Column(
                            children: [
                              TextFieldWidget(
                                hint: AppLocalizations.of(context)
                                    .translate('enterCode'),
                                inputType: TextInputType.text,
                                icon: Icons.text_decrease,
                                iconColor: Colors.black54,
                                textController: _codeController,
                                inputAction: TextInputAction.next,
                                autoFocus: false,
                                onChanged: (value) {
                                  _forgetPasswordFormStore
                                      .setCode(_codeController.text);
                                },
                                onFieldSubmitted: (value) {
                                  // FocusScope.of(context)
                                  //     .requestFocus(_passwordFocusNode);
                                },
                                errorText: _forgetPasswordFormStore
                                    .forgetPasswordFormErrorStore.codeError,
                              ),
                              TextFieldWidget(
                                hint: AppLocalizations.of(context)
                                    .translate('login_et_user_password'),
                                inputType: TextInputType.visiblePassword,
                                icon: Icons.lock,
                                iconColor: Colors.black54,
                                textController: _passwordController,
                                inputAction: TextInputAction.next,
                                autoFocus: false,
                                onChanged: (value) {
                                  _forgetPasswordFormStore
                                      .setPassword(_passwordController.text);
                                },
                                onFieldSubmitted: (value) {
                                  // FocusScope.of(context)
                                  //     .requestFocus(_passwordFocusNode);
                                },
                                errorText: _forgetPasswordFormStore
                                    .forgetPasswordFormErrorStore.passwordError,
                              ),
                              TextFieldWidget(
                                hint: AppLocalizations.of(context)
                                    .translate('login_et_user_password_again'),
                                inputType: TextInputType.visiblePassword,
                                icon: Icons.lock,
                                iconColor: Colors.black54,
                                textController: _confirmPasswordController,
                                inputAction: TextInputAction.next,
                                autoFocus: false,
                                onChanged: (value) {
                                  _forgetPasswordFormStore.setConfirmPassword(
                                      _confirmPasswordController.text);
                                },
                                onFieldSubmitted: (value) {
                                  // FocusScope.of(context)
                                  //     .requestFocus(_passwordFocusNode);
                                },
                                errorText: _forgetPasswordFormStore
                                    .forgetPasswordFormErrorStore
                                    .confirmPasswordError,
                              ),
                            ],
                          ),
                        );
                },
              ),
            ],
          ),
          // Observer(
          //   builder: (context) {
          //     if (_forgetPasswordFormStore.codeSent) {
          //       //_forgetPasswordFormStore.success = false;
          //       Future.delayed(Duration(milliseconds: 0), () {
          //         FlushbarHelper.createSuccess(
          //           message: AppLocalizations.of(context)
          //               .translate('checkMailForForgetPassword'),
          //           title: AppLocalizations.of(context)
          //               .translate('forgetPassword'),
          //           duration: Duration(seconds: 3),
          //         )..show(context);
          //       });
          //       //Navigator.of(context).pop();
          //       _forgetPasswordFormStore.setEmail('');
          //     }
          //     return (_forgetPasswordFormStore.codeSent &&
          //             _forgetPasswordFormStore.email != '')
          //         ? Text(
          //             'link sent to your email',
          //             style: TextStyle(color: CustomColor.primaryColor),
          //           )
          //         : Text(
          //             '',
          //             style: TextStyle(color: Colors.red),
          //           );
          //     // ? navigate(context)
          //     // : _showErrorMessage(
          //     // _signup_store.errorStore.errorMessage);
          //   },
          // ),
          Observer(
            builder: (context) {
              return _forgetPasswordFormStore.sendingCode
                  ? Text('Sending code...')
                  : !_forgetPasswordFormStore.codeSent
                      ? InkWell(
                          child: Container(
                            height: 60.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: CustomColor.primaryColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.radius))),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('sendForgetPasswordCode'),
                                style: TextStyle(
                                    fontSize: Dimensions.extraLargeTextSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (_forgetPasswordFormStore
                                .canSendForgetPasswordCode) {
                              DeviceUtils.hideKeyboard(context);
                              var res = await _forgetPasswordFormStore
                                  .sendForgetPasswordCode();
                              if (res?.success == true) {
                                Future.delayed(Duration(milliseconds: 0), () {
                                  FlushbarHelper.createSuccess(
                                    message: AppLocalizations.of(context)
                                        .translate(
                                            'checkMailForForgetPassword'),
                                    title: AppLocalizations.of(context)
                                        .translate('forgetPassword'),
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                                });
                              } else {
                                Future.delayed(Duration(milliseconds: 0), () {
                                  FlushbarHelper.createError(
                                    message: AppLocalizations.of(context)
                                        .translate('sendCodeFailed'),
                                    title: AppLocalizations.of(context)
                                        .translate('home_tv_error'),
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                                });
                              }
                            } else {
                              Future.delayed(Duration(milliseconds: 0), () {
                                FlushbarHelper.createError(
                                  message: AppLocalizations.of(context)
                                      .translate('login_error_fill_fields'),
                                  title: AppLocalizations.of(context)
                                      .translate('home_tv_error'),
                                  duration: Duration(seconds: 3),
                                )..show(context);
                              });
                            }
                            // Navigator.of(context).pop();
                          },
                        )
                      : InkWell(
                          child: Container(
                            height: 60.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: CustomColor.primaryColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Dimensions.radius))),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('resetPassword'),
                                style: TextStyle(
                                    fontSize: Dimensions.extraLargeTextSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (_forgetPasswordFormStore.canChangePassword) {
                              DeviceUtils.hideKeyboard(context);
                              var res = await _forgetPasswordFormStore
                                  .resetPassword();
                              if (res?.success == true) {
                                Navigator.of(context).pop();
                                Future.delayed(Duration(milliseconds: 0), () {
                                  FlushbarHelper.createSuccess(
                                    message: AppLocalizations.of(context)
                                        .translate('passwordChanged'),
                                    title: AppLocalizations.of(context)
                                        .translate('forgetPassword'),
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                                });

                                _forgetPasswordFormStore.setEmail('');
                                _forgetPasswordFormStore.setCode('');
                                _forgetPasswordFormStore.setPassword('');
                                _forgetPasswordFormStore.setConfirmPassword('');
                              } else {
                                Future.delayed(Duration(milliseconds: 0), () {
                                  FlushbarHelper.createError(
                                    message: AppLocalizations.of(context)
                                        .translate('resetPasswordfailed'),
                                    title: AppLocalizations.of(context)
                                        .translate('home_tv_error'),
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                                });
                              }
                            } else {
                              Future.delayed(Duration(milliseconds: 0), () {
                                FlushbarHelper.createError(
                                  message: AppLocalizations.of(context)
                                      .translate('login_error_fill_fields'),
                                  title: AppLocalizations.of(context)
                                      .translate('home_tv_error'),
                                  duration: Duration(seconds: 3),
                                )..show(context);
                              });
                            }
                            // Navigator.of(context).pop();
                          },
                        );
            },
          )
        ],
      ),
    );
  }
}
