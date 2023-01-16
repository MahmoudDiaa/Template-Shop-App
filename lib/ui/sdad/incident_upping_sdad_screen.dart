import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/enums.dart';
import '../../models/incident/incident.dart';
import '../../stores/incident/incident_store.dart';
import '../../stores/incident_form/incident_form_store.dart';
import '../../stores/language/language_store.dart';
import '../../stores/theme/theme_store.dart';
import '../../utils/device/device_utils.dart';
import '../../utils/locale/app_localization.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/media_picker_widget.dart';
import '../../widgets/navigation/back_widget.dart';
import '../../widgets/priority_select.dart';
import '../../widgets/progress_indicator/progress_indicator_text_widget.dart';
import '../../widgets/progress_indicator/progress_indicator_widget.dart';
import '../constants/colors.dart';
import '../constants/custom_style.dart';
import '../constants/dimensions.dart';
import '../constants/strings.dart';

class IncidentUppingSdadScreen extends StatefulWidget {
  IncidentUppingSdadScreen();

  @override
  _IncidentUppingSdadScreenState createState() =>
      _IncidentUppingSdadScreenState();
}

class _IncidentUppingSdadScreenState extends State<IncidentUppingSdadScreen> {
  //stores:---------------------------------------------------------------------
  late IncidentFormStore _incidentFormStore;
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  @override
  void didChangeDependencies() {
    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _incidentFormStore = Provider.of<IncidentFormStore>(context);

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _loadSharedPref();
  }

  String accessToken = '';

  _loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = (prefs.getString('authtoken') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.primaryColor,
        title: Text(AppLocalizations.of(context).translate('incidentUpping')),
      ),
      //backgroundColor: CustomColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Container(
          //width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 2),
                  topRight: Radius.circular(Dimensions.radius * 2))),
          child: Stack(
            children: [
              //BackWidget(),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(AppLocalizations.of(context)
                                .translate('theImages')),
                          ),
                          SingleChildScrollView(
                            child: MediaPickerWidget(
                              imageMaxWidth: 500,
                              imageMaxHeight: 500,
                              imageQuality: 100,
                              initialImageList:
                                  _incidentFormStore.incident?.xFiles,
                              onImageListChanged: (list) {
                                _incidentFormStore.incident.xFiles = list;
                              },
                              hidePickSingleVideoFromGallery: true,
                              hideTakeVideo: true,
                              //showSelectedImage: false,
                            ),
                            scrollDirection: Axis.horizontal,
                          ),
                          SizedBox(
                            height: Dimensions.heightSize * 0.5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: _incidentFormStore?.incident?.notes,
                              autofocus: false,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 3,
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)
                                      .translate('notes'),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  border: OutlineInputBorder()),
                              validator: (value) {
                                // if (value == null || value.isEmpty || value.length < 3) {
                                //   return 'Last Name must contain at least 3 characters';
                                // } else if (value.contains(RegExp(r'^[0-9_\-=@,\.;]+$'))) {
                                //   return 'Last Name cannot contain special characters';
                                // }
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                _incidentFormStore.incident.notes = value;
                              },
                              onChanged: (value) {
                                _incidentFormStore.incident.notes = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              submitButtonWidget(context),

              _handleSavingErrorMessage(),
              Observer(
                builder: (context) {
                  return _incidentFormStore.saved
                      ? navigate(context)
                      : _showErrorMessage(
                          _incidentFormStore.errorStore.errorMessage);
                },
              ),
              // Observer(
              //   builder: (context) {
              //     return _incidentFormStore.saved
              //         ? Future.delayed(Duration(milliseconds: 3), () {
              //             // _showSuccessMessage(AppLocalizations.of(context)
              //             //     .translate('incidentSavedSuccessfully'));
              //             // Navigator.of(context).pushNamedAndRemoveUntil(
              //             //     Routes.dashboard,
              //             //     (Route<dynamic> route) => false);
              //           })
              //         : _showErrorMessage(
              //             _incidentFormStore.errorStore.errorMessage);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      FlushbarHelper.createSuccess(
        message: AppLocalizations.of(context)
            .translate('incidentUppedSuccessMessage'),
        title: AppLocalizations.of(context).translate('successMessageTitle'),
        duration: Duration(seconds: 1),
      )..show(context).then((value) => Navigator.of(context).pop());
    });

    _incidentFormStore.setTakeActionIncidentValue(Incident());
    _incidentFormStore.saved = false;

    return Container();
  }

  Widget _handleSavingErrorMessage() {
    return Observer(
      builder: (context) {
        if (_incidentFormStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_incidentFormStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

  submitButtonWidget(BuildContext context) {
    return Positioned(
      bottom: 2,
      left: 0,
      right: 0,
      child: Observer(
        builder: (context) {
          return _incidentFormStore.loading == true
              ? Visibility(
                  visible: _incidentFormStore.loading,
                  child: CustomProgressIndicatorTextWidget(
                    message: AppLocalizations.of(context)
                        .translate('incidentUppingInProgressMessage'),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize),
                  child: InkWell(
                    child: Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: CustomColor.primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dimensions.radius),
                              topRight: Radius.circular(Dimensions.radius))),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('incidentUpping'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.largeTextSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      _incidentFormStore.incident.notes = '';
                      _incidentFormStore.setTakeActionIncidentValue(
                          _incidentFormStore.incident);
                      if (_incidentFormStore.canSubmitTakeAction) {
                        //Navigator.of(context).pop();
                        DeviceUtils.hideKeyboard(context);
                        // _submit();
                        _incidentFormStore
                            .workFlowStepSave(IncidentStatusEnum.Upped);
                      } else {
                        _showErrorMessage(
                          AppLocalizations.of(context)
                              .translate('login_error_fill_fields'),
                        );
                      }

                      // if (BlocProvider.of<IncidentBloc>(context).incident.subCategoryId ==
                      //     null)
                      //   return;
                      // else
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => IncidentFormStep3()));
                      // // BlocProvider.of<IncidentBloc>(context).incident.categoryId = 34;
                      // // BlocProvider.of<IncidentBloc>(context).add(IncidentChanged(
                      // //     BlocProvider.of<IncidentBloc>(context).incident));
                    },
                  ),
                );
        },
      ),
    );
  }

  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('home_tv_error'),
            duration: Duration(seconds: 2),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  _showSuccessMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createSuccess(
            message: message,
            title:
                AppLocalizations.of(context).translate('successMessageTitle'),
            duration: Duration(seconds: 5),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  invoiceDetailsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize, right: Dimensions.marginSize),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: CustomStyle.textStyle,
                    ),
                    Text(
                      'Joshifa Mariya',
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Phone',
                      style: CustomStyle.textStyle,
                    ),
                    Text(
                      Strings.demoPhoneNumber,
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer ID',
                      style: CustomStyle.textStyle,
                    ),
                    Text(
                      '4589G',
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Beauty Expertist',
                      style: CustomStyle.textStyle,
                    ),
                    Text(
                      'Thisha Khan',
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: CustomStyle.textStyle,
                    ),
                    Text(
                      '22 Dec, 2021',
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Time',
                      style: CustomStyle.textStyle,
                    ),
                    Text(
                      'Today 3.00 PM',
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discount',
                      style: CustomStyle.textStyle,
                    ),
                    Text(
                      '\$15 Off',
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Amount',
                      style: CustomStyle.textStyle,
                    ),
                    Text(
                      '\$250',
                      style: TextStyle(
                          fontSize: Dimensions.defaultTextSize,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FruitsList {
  String name;
  int index;
  int id;

  FruitsList({required this.name, required this.index, required this.id});
}
