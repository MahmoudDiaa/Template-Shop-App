import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/incident/incident.dart';
import '../../stores/incident_form/incident_form_store.dart';
import '../../stores/language/language_store.dart';
import '../../stores/theme/theme_store.dart';
import '../../utils/device/device_utils.dart';
import '../../utils/locale/app_localization.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/navigation/back_widget.dart';
import '../../widgets/priority_select.dart';
import '../../widgets/progress_indicator/progress_indicator_widget.dart';
import '../constants/colors.dart';
import '../constants/custom_style.dart';
import '../constants/dimensions.dart';
import '../constants/strings.dart';

class IncidentFormStep3 extends StatefulWidget {
  @override
  _IncidentFormStep3State createState() => _IncidentFormStep3State();
}

class _IncidentFormStep3State extends State<IncidentFormStep3> {
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

    // check to see if already called api
    if (!_incidentFormStore.loading) {
      //_incidentFormStore.getCategories();
    }
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
      backgroundColor: CustomColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  BackWidget(),
                ],
              ),
              Container(
                //width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 168,
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
                            padding: const EdgeInsets.only(
                                top: Dimensions.heightSize * 1),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('lastStep'),
                                style: TextStyle(
                                    fontSize:
                                        Dimensions.extraLargeTextSize * 1.2,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.heightSize,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: Dimensions.marginSize),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    initialValue: _incidentFormStore
                                                .incident.amountValue ==
                                            null
                                        ? ''
                                        : _incidentFormStore
                                            .incident.amountValue
                                            .toString(),
                                    autofocus: false,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText:
                                            '${AppLocalizations.of(context).translate('quantity')}-${_incidentFormStore?.incident?.amountUnitName}',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 0.0),
                                        ),
                                        border: OutlineInputBorder()),
                                    onFieldSubmitted: (value) {
                                      // setState(() {
                                      //   BlocProvider.of<IncidentBloc>(context).incident.amountValue =
                                      //       double.parse(value);
                                      // });

                                      try {
                                        _incidentFormStore.incident
                                            .amountValue = double.parse(value);
                                      } catch (e) {}
                                    },
                                    onChanged: (value) {
                                      // setState(() {
                                      //   BlocProvider.of<IncidentBloc>(context).incident.amountValue =
                                      //       double.parse(value);
                                      // });
                                      try {
                                        _incidentFormStore.incident
                                            .amountValue = double.parse(value);
                                      } catch (e) {}
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.contains(
                                              RegExp(r'^[a-zA-Z\-]'))) {
                                        return 'Use only numbers!';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 0.5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    initialValue:
                                        _incidentFormStore.incident.notes,
                                    autofocus: false,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)
                                            .translate('notes'),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
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
                                      // setState(() {
                                      //   BlocProvider.of<IncidentBloc>(context).incident.notes = value;
                                      //   // lastNameList.add(lastName);
                                      // });
                                    },
                                    onChanged: (value) {
                                      _incidentFormStore.incident.notes = value;
                                      // setState(() {
                                      //   BlocProvider.of<IncidentBloc>(context).incident.notes = value;
                                      // });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 0.5,
                                ),
                                Padding(
                                    padding: EdgeInsets.all(14.0),
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate('priority'),
                                        style: TextStyle(fontSize: 17))),
                                PriorityFormField(
                                  initialSelectedId:
                                      _incidentFormStore.incident.priority,
                                  onChange: (priority) {
                                    _incidentFormStore.incident.priority =
                                        priority?.id;
                                  },
                                  onSaved: (category) {},
                                  validator: (category) {
                                    //  return selectedCat == null ? 'select priority ' : null;
                                  },
                                  //stream: stream,
                                  //initialValue: null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    nextButtonWidget(context),
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
                    Observer(
                      builder: (context) {
                        return Visibility(
                          visible: _incidentFormStore.loading,
                          child: CustomProgressIndicatorWidget(),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.dashboard, (Route<dynamic> route) => false);
    });
    _incidentFormStore.setIncidentValue(Incident());
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

  List<FruitsList> fList = [
    FruitsList(index: 0, name: "منخفض", id: 1),
    FruitsList(index: 1, name: "متوسط", id: 2),
    FruitsList(index: 2, name: "عالى", id: 3),
  ];
  late FruitsList selectedPriority;

  nextButtonWidget(BuildContext context) {
    return Positioned(
      bottom: 2,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(
            left: Dimensions.marginSize, right: Dimensions.marginSize),
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
                AppLocalizations.of(context).translate('finishAndSend'),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Dimensions.largeTextSize,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            _incidentFormStore.setIncidentValue(_incidentFormStore.incident);
            if (_incidentFormStore.canSubmit) {
              DeviceUtils.hideKeyboard(context);
              _submit();
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
      ),
    );
  }

  bodyWidget(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(
        //       top: Dimensions.heightSize * 3,
        //       left: Dimensions.marginSize,
        //       right: Dimensions.marginSize),
        //   child: Text(
        //     Strings.pickAnImage,
        //     style: TextStyle(
        //         fontSize: Dimensions.extraLargeTextSize,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.black),
        //   ),
        // ),
        // SizedBox(height: Dimensions.heightSize),

        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: _incidentFormStore?.incident?.unitValue == null
                ? ''
                : _incidentFormStore?.incident?.unitValue.toString(),
            autofocus: false,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                labelText: 'الكمية',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                ),
                border: OutlineInputBorder()),
            onFieldSubmitted: (value) {
              // setState(() {
              //   BlocProvider.of<IncidentBloc>(context).incident.amountValue =
              //       double.parse(value);
              // });
            },
            onChanged: (value) {
              // setState(() {
              //   BlocProvider.of<IncidentBloc>(context).incident.amountValue =
              //       double.parse(value);
              // });
              try {
                _incidentFormStore.incident.amountValue = double.parse(value);
              } catch (e) {}
            },
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value.contains(RegExp(r'^[a-zA-Z\-]'))) {
                return 'Use only numbers!';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: _incidentFormStore?.incident?.notes,
            autofocus: false,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
                labelText: 'ملاحظات',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
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
              // setState(() {
              //   BlocProvider.of<IncidentBloc>(context).incident.notes = value;
              //   // lastNameList.add(lastName);
              // });
            },
            onChanged: (value) {
              _incidentFormStore.incident.notes = value;
              // setState(() {
              //   BlocProvider.of<IncidentBloc>(context).incident.notes = value;
              // });
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(14.0),
                child: Text('الأولوية', style: TextStyle(fontSize: 17))),
            PriorityFormField(
              initialSelectedId: 8,
              onChange: (priority) {
                _incidentFormStore.incident.priority = priority?.id;
              },
              onSaved: (category) {},
              validator: (category) {
                //  return selectedCat == null ? 'select priority ' : null;
              },
              //stream: stream,
              //initialValue: null,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        // selectDateWidget(context),
        // const SizedBox(
        //   height: 20,
        // ),
        // selectTimeWidget(context),
        // const SizedBox(
        //   height: 20,
        // ),
        Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.marginSize,
              right: Dimensions.marginSize,
              bottom: Dimensions.marginSize),
          child: InkWell(
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius))),
              child: Center(
                child: Text(
                  'إرسال البلاغ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () {
              _submit();
            },
          ),
        ),
      ],
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("جاري إرسال البلاغ...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _submit() {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(AppLocalizations.of(context).translate('cancel')),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        AppLocalizations.of(context).translate('yes'),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        _incidentFormStore.save(); // dismiss dialog
        // BlocProvider.of<IncidentBloc>(context)
        //     .add(IncidentSave(token: accessToken));
        // showLoaderDialog(context);
        // Save();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        AppLocalizations.of(context).translate('sendingIncident'),
      ),
      content: Text(
        AppLocalizations.of(context).translate('sendIncidentConfirmation'),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
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
            title: AppLocalizations.of(context)
                .translate('home_tv_saving_incident'),
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

  selectDateWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize, right: Dimensions.marginSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'التاريخ',
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.extraLargeTextSize,
            ),
          ),
          SizedBox(height: Dimensions.heightSize),
          GestureDetector(
            onTap: () async {
              // final DateTime picked = await showDatePicker(
              //     context: context,
              //     initialDate: BlocProvider.of<IncidentBloc>(context)
              //         .incident
              //         .createDate,
              //     firstDate: DateTime(2020, 1),
              //     lastDate: DateTime(2030));
              // if (picked != null &&
              //     picked !=
              //         BlocProvider.of<IncidentBloc>(context)
              //             .incident
              //             .createDate)
              //   setState(() {
              //     BlocProvider.of<IncidentBloc>(context).incident.createDate =
              //         picked;
              //     //expDate = "${BlocProvider.of<IncidentBloc>(context).incident.dateTime.toLocal()}".split(' ')[0];
              //     //print('date: ' + expDate);
              //   });
            },
            child: Container(
                height: 48.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.marginSize,
                        right: Dimensions.marginSize),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'date',
                          style: CustomStyle.textStyle,
                        ),
                        Icon(Icons.calendar_today)
                      ],
                    ),
                  ),
                )),
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
