import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/ui/authentication/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/enums.dart';
import '../../data/respository/user_repository.dart';
import '../../data/sharedpref/constants/preferences.dart';
import '../../stores/login_form/login_form_store.dart';
import '../../stores/theme/theme_store.dart';
import '../../utils/device/device_utils.dart';
import '../../utils/locale/app_localization.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/navigation/back_widget.dart';
import '../../widgets/progress_indicator/progress_indicator_widget.dart';
import '../../widgets/rounded_button_widget.dart';
import '../../widgets/textfield_widget.dart';
import '../constants/colors.dart';
import '../constants/custom_style.dart';
import '../constants/dimensions.dart';
import '../constants/strings.dart';

class SignUpFormWidget extends StatefulWidget {
  SignUpFormWidget();

  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userFirstNameController = TextEditingController();
  TextEditingController _userLastNameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _verifyPasswordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  //stores:---------------------------------------------------------------------
  final _signup_store = LoginFormStore(GetIt.instance<UserRepository>());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  //final _emailController = TextEditingController(text: "demo@orbits.com");
  final _emailController = TextEditingController();
  bool _toggleVisibility = true;
  bool checkedValue = false;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context).translate('login_et_user_email'),
          inputType: TextInputType.emailAddress,
          icon: Icons.email,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userEmailController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _signup_store.setUserId(_userEmailController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _signup_store.formErrorStore.userEmail,
        );
      },
    );
  }

  Widget _buildUserFirstNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint:
              AppLocalizations.of(context).translate('login_et_user_firstname'),
          inputType: TextInputType.name,
          icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userFirstNameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _signup_store.setFirstName(_userFirstNameController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _signup_store.formErrorStore.firstName,
        );
        // TextFormField(
        //   style: CustomStyle.textStyle,
        //   decoration: InputDecoration(
        //     hintText: Strings.demoEmail,
        //     contentPadding: EdgeInsets.symmetric(
        //         vertical: 10.0, horizontal: 10.0),
        //     labelStyle: CustomStyle.textStyle,
        //     filled: true,
        //     fillColor: CustomColor.accentColor,
        //     hintStyle: CustomStyle.textStyle,
        //     focusedBorder: CustomStyle.focusBorder,
        //     enabledBorder: CustomStyle.focusErrorBorder,
        //     focusedErrorBorder:
        //     CustomStyle.focusErrorBorder,
        //     errorBorder: CustomStyle.focusErrorBorder,
        //     prefixIcon: Icon(Icons.mail),
        //   ),
        //   controller: _emailController,
        //   keyboardType: TextInputType.emailAddress,
        //   autocorrect: false,
        //   validator: (value) {
        //     if (value!.isEmpty) {
        //       return Strings.pleaseFillOutTheField;
        //     }
        //     return null;
        //   },
        // )
      },
    );
  }

  Widget _buildUserLastNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint:
              AppLocalizations.of(context).translate('login_et_user_lastname'),
          inputType: TextInputType.name,
          icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userLastNameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _signup_store.setLastName(_userLastNameController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _signup_store.formErrorStore.lastName,
        );
        // TextFormField(
        //   style: CustomStyle.textStyle,
        //   decoration: InputDecoration(
        //     hintText: Strings.demoEmail,
        //     contentPadding: EdgeInsets.symmetric(
        //         vertical: 10.0, horizontal: 10.0),
        //     labelStyle: CustomStyle.textStyle,
        //     filled: true,
        //     fillColor: CustomColor.accentColor,
        //     hintStyle: CustomStyle.textStyle,
        //     focusedBorder: CustomStyle.focusBorder,
        //     enabledBorder: CustomStyle.focusErrorBorder,
        //     focusedErrorBorder:
        //     CustomStyle.focusErrorBorder,
        //     errorBorder: CustomStyle.focusErrorBorder,
        //     prefixIcon: Icon(Icons.mail),
        //   ),
        //   controller: _emailController,
        //   keyboardType: TextInputType.emailAddress,
        //   autocorrect: false,
        //   validator: (value) {
        //     if (value!.isEmpty) {
        //       return Strings.pleaseFillOutTheField;
        //     }
        //     return null;
        //   },
        // )
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint:
              AppLocalizations.of(context).translate('login_et_user_password'),
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _passwordController,
          focusNode: _passwordFocusNode,
          errorText: _signup_store.formErrorStore.password,
          onChanged: (value) {
            _signup_store.setPassword(_passwordController.text);
          },
        );
      },
    );
    // TextFormField(
    //   style: CustomStyle.textStyle,
    //   decoration: InputDecoration(
    //     hintText: Strings.typePassword,
    //     contentPadding: EdgeInsets.symmetric(
    //         vertical: 10.0, horizontal: 10.0),
    //     labelStyle: CustomStyle.textStyle,
    //     focusedBorder: CustomStyle.focusBorder,
    //     enabledBorder: CustomStyle.focusErrorBorder,
    //     focusedErrorBorder:
    //     CustomStyle.focusErrorBorder,
    //     errorBorder: CustomStyle.focusErrorBorder,
    //     filled: true,
    //     fillColor: CustomColor.accentColor,
    //     hintStyle: CustomStyle.textStyle,
    //     prefixIcon: Icon(Icons.lock),
    //     suffixIcon: IconButton(
    //       onPressed: () {
    //         setState(() {
    //           _toggleVisibility = !_toggleVisibility;
    //         });
    //       },
    //       icon: _toggleVisibility
    //           ? Icon(
    //         Icons.visibility_off,
    //         color: Colors.black,
    //       )
    //           : Icon(
    //         Icons.visibility,
    //         color: Colors.black,
    //       ),
    //     ),
    //   ),
    //   obscureText: _toggleVisibility,
    //   controller: _passwordController,
    //   validator: (value) {
    //     if (value!.isEmpty) {
    //       return Strings.pleaseFillOutTheField;
    //     }
    //     return null;
    //   },
    // ),
  }

  Widget _buildVerifyPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: AppLocalizations.of(context)
              .translate('login_et_user_password_again'),
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _verifyPasswordController,
          //focusNode: _passwordFocusNode,
          errorText: _signup_store.formErrorStore.confirmPassword,
          onChanged: (value) {
            _signup_store.setConfirmPassword(_verifyPasswordController.text);
          },
        );
      },
    );
    // TextFormField(
    //   style: CustomStyle.textStyle,
    //   decoration: InputDecoration(
    //     hintText: Strings.typePassword,
    //     contentPadding: EdgeInsets.symmetric(
    //         vertical: 10.0, horizontal: 10.0),
    //     labelStyle: CustomStyle.textStyle,
    //     focusedBorder: CustomStyle.focusBorder,
    //     enabledBorder: CustomStyle.focusErrorBorder,
    //     focusedErrorBorder:
    //     CustomStyle.focusErrorBorder,
    //     errorBorder: CustomStyle.focusErrorBorder,
    //     filled: true,
    //     fillColor: CustomColor.accentColor,
    //     hintStyle: CustomStyle.textStyle,
    //     prefixIcon: Icon(Icons.lock),
    //     suffixIcon: IconButton(
    //       onPressed: () {
    //         setState(() {
    //           _toggleVisibility = !_toggleVisibility;
    //         });
    //       },
    //       icon: _toggleVisibility
    //           ? Icon(
    //         Icons.visibility_off,
    //         color: Colors.black,
    //       )
    //           : Icon(
    //         Icons.visibility,
    //         color: Colors.black,
    //       ),
    //     ),
    //   ),
    //   obscureText: _toggleVisibility,
    //   controller: _passwordController,
    //   validator: (value) {
    //     if (value!.isEmpty) {
    //       return Strings.pleaseFillOutTheField;
    //     }
    //     return null;
    //   },
    // ),
  }

  Widget _buildSignupButton() {
    return RoundedButtonWidget(
      buttonText: AppLocalizations.of(context).translate('login_btn_sign_up'),
      buttonColor: CustomColor.primaryColor,
      textColor: Colors.white,
      onPressed: () async {
        if (_signup_store.canRegister) {
          DeviceUtils.hideKeyboard(context);
          _signup_store.register();
        } else {
          _showErrorMessage(AppLocalizations.of(context)
              .translate('login_error_fill_fields'));
        }
      },
    );
  }

  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('home_tv_error'),
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //BackWidget(),
                  SizedBox(height: 100),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: CustomColor.accentColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius * 2),
                            topRight: Radius.circular(Dimensions.radius * 2))),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: Dimensions.heightSize * 3),
                        child: Text(
                          AppLocalizations.of(context).translate('newAccount'),
                          style: TextStyle(
                              fontSize: Dimensions.extraLargeTextSize * 1.2,
                              color: Colors.black),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: Dimensions.heightSize * 2,
                                left: Dimensions.marginSize,
                                right: Dimensions.marginSize),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildUserIdField(),
                                _buildUserFirstNameField(),
                                _buildUserLastNameField(),
                                _buildPasswordField(),
                                _buildVerifyPasswordField(),
                                Observer(
                                  builder: (context) {
                                    return _signup_store.success
                                        ? navigate(context)
                                        : _showErrorMessage(_signup_store
                                            .errorStore.errorMessage);
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Dimensions.heightSize * 2),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: Dimensions.marginSize,
                                right: Dimensions.marginSize),
                            child: _buildSignupButton(),
                          ),
                          SizedBox(height: Dimensions.heightSize * 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .translate('alreadyHaveAccount'),
                                style: CustomStyle.textStyle,
                              ),
                              GestureDetector(
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('login'),
                                  style: TextStyle(
                                      color: CustomColor.primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed(Routes.login);
                                },
                              )
                            ],
                          )
                        ],
                      )
                    ]),
                  )
                ],
              ),
            ),
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _signup_store.loading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      FlushbarHelper.createSuccess(
        message: AppLocalizations.of(context).translate('afterCreateAccount'),
        title: AppLocalizations.of(context).translate('successMessageTitle'),
        duration: Duration(seconds: 3),
      )..show(context).then((value) {
          Future.delayed(Duration(milliseconds: 0), () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AuthenticationScreen(
                      authScreenMode: AuthScreenMode.Login,
                      // initialUserName: _signup_store.username,
                      // initialPassword: _signup_store.password,
                    )));
          });
        });
    });

    //_signup_store.login();
    return Container();
  }
}
