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
import '../../data/sharedpref/shared_preference_helper.dart';
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

class ChangePasswordFormWidget extends StatefulWidget {
  ChangePasswordFormWidget();

  @override
  _ChangePasswordFormWidgetState createState() =>
      _ChangePasswordFormWidgetState();
}

class _ChangePasswordFormWidgetState extends State<ChangePasswordFormWidget> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userCurrentPasswordController =
      TextEditingController();

  TextEditingController _newpasswordController = TextEditingController();
  TextEditingController _verifyNewPasswordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  //stores:---------------------------------------------------------------------
  final _signup_store = LoginFormStore(GetIt.instance<UserRepository>());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool checkedValue = false;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    sharedPreferenceHelper = GetIt.instance<SharedPreferenceHelper>();
    _themeStore = Provider.of<ThemeStore>(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _newpasswordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Widget _buildUserCurrentPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'كلمة المرور الحالية',
          inputType: TextInputType.name,
          icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userCurrentPasswordController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _signup_store
                .setCurrentPassword(_userCurrentPasswordController.text);
          },
          onFieldSubmitted: (value) {
            //FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _signup_store.formErrorStore.currentPassword,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'كلمة المرور الجديدة',
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _newpasswordController,
          focusNode: _passwordFocusNode,
          errorText: _signup_store.formErrorStore.password,
          onChanged: (value) {
            _signup_store.setPassword(_newpasswordController.text);
          },
        );
      },
    );
  }

  Widget _buildVerifyPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'تأكيد كلمة المرور الجديدة',
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.lock,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _verifyNewPasswordController,
          //focusNode: _passwordFocusNode,
          errorText: _signup_store.formErrorStore.confirmPassword,
          onChanged: (value) {
            _signup_store.setConfirmPassword(_verifyNewPasswordController.text);
          },
        );
      },
    );
  }

  Widget _buildChangePasswordButton() {
    return RoundedButtonWidget(
      buttonText: 'تغيير كلمة المرور',
      buttonColor: CustomColor.primaryColor,
      textColor: Colors.white,
      onPressed: () async {
        if (_signup_store.canChangePassword) {
          DeviceUtils.hideKeyboard(context);
          _signup_store.changePassword();
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
                  BackWidget(),
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
                          'تغيير كلمة المرور',
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
                                _buildUserCurrentPasswordField(),
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
                            child: _buildChangePasswordButton(),
                          ),
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

  SharedPreferenceHelper? sharedPreferenceHelper;

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      sharedPreferenceHelper?.removeLoggedInUser();
      Navigator.of(context).pushReplacementNamed(Routes.login);

      //Navigator.of(context).pushReplacementNamed(Routes.dashboard);

      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     Routes.login, (Route<dynamic> route) => false,arguments: {
      //
      // });
    });
    //_signup_store.login();
    return Container();
  }
}
