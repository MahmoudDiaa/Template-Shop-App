import 'dart:async';

import 'package:boilerplate/models/category/category.dart';
import 'package:boilerplate/ui/create_incident/create_incident_step2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/enums.dart';
import '../../models/subcategory/subcategory.dart';
import '../../stores/incident_form/incident_form_store.dart';
import '../../stores/language/language_store.dart';
import '../../stores/theme/theme_store.dart';
import '../../utils/locale/app_localization.dart';
import '../../widgets/categories_select.dart';
import '../../widgets/subcategories_select.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../constants/strings.dart';

class IncidentFormStep1 extends StatefulWidget {
  const IncidentFormStep1({Key? key}) : super(key: key);

  @override
  State<IncidentFormStep1> createState() => _IncidentFormStep1State();
}

class _IncidentFormStep1State extends State<IncidentFormStep1> {
  int index = 0;

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

  var subCategories = <SubCategory>[];

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

  String accessToken = '';

  _loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = (prefs.getString('authtoken') ?? '');
    });
  }

  StreamController<Category?>? categoryStreamController =
      StreamController<Category?>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
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
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: Dimensions.heightSize * 1),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          AppLocalizations.of(context).translate('newIncident'),
                          style: TextStyle(
                              fontSize: Dimensions.extraLargeTextSize * 1.2,
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.heightSize,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: Dimensions.marginSize),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Center(
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(10.0),
                          //     child: TextFormField(
                          //       autofocus: false,
                          //
                          //       decoration: const InputDecoration(
                          //           labelText: 'العنوان',
                          //           enabledBorder: OutlineInputBorder(
                          //             borderRadius: BorderRadius.all(
                          //                 Radius.circular(20.0)),
                          //             borderSide: BorderSide(
                          //                 color: Colors.grey,
                          //                 width: 0.0),
                          //           ),
                          //           border: OutlineInputBorder()),
                          //       onFieldSubmitted: (value) {
                          //         setState(() {
                          //           BlocProvider.of<IncidentBloc>(
                          //                   context)
                          //               .incident
                          //               .title = value;
                          //         });
                          //       },
                          //       onChanged: (value) {
                          //         setState(() {
                          //           BlocProvider.of<IncidentBloc>(
                          //                   context)
                          //               .incident
                          //               .title = value;
                          //         });
                          //       },
                          //       validator: (value) {
                          //         if (value == null ||
                          //             value.isEmpty ||
                          //             value.contains(
                          //                 RegExp(r'^[a-zA-Z\-]'))) {
                          //           return 'Use only numbers!';
                          //         }
                          //         return null;
                          //       },
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: Dimensions.marginSize),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('mainCategory'),
                              style: TextStyle(
                                  fontSize: Dimensions.extraLargeTextSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.heightSize * 0.5,
                          ),
                          CategoryFormField(
                            gridAndListHeight: 0,
                            autoSelectFirstItem: true,
                            categoryListView: CategoryListViewMode.Radiobutton,
                            //initialSelectedId: 8,
                            onCategoryChange: (category) {
                              _incidentFormStore.incident.categoryId =
                                  category?.id;
                            },
                            onSaved: (category) {},
                            validator: (category) {},
                            categoryStream: categoryStreamController,
                            //initialValue: null,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 2,
                    ),
                    StreamBuilder<Category?>(
                        stream: categoryStreamController?.stream,
                        builder: (context, snapshot) {
                          return SubCategoryFormField(
                            gridAndListHeight:
                                MediaQuery.of(context).size.height - 460,
                            categoryId: snapshot.data?.id,
                            subcategoryListView:
                                SubCategoryListViewMode.ImageList,
                            //initialSelectedId: 8,
                            categoryIdIsMandatory: true,
                            onChange: (subCategory) {
                              _incidentFormStore.incident.subCategoryId =
                                  subCategory?.id;
                              _incidentFormStore.incident.amountUnitId =
                                  subCategory?.amountUnitId;
                              _incidentFormStore.incident.amountUnitName =
                                  subCategory?.localizedUnitName(_languageStore.locale);
                            },
                            onSaved: (category) {},
                            validator: (category) {
                              return _incidentFormStore.incident.categoryId ==
                                      null
                                  ? AppLocalizations.of(context)
                                      .translate('selectSubCategory')
                                  : null;
                            },

                            //initialValue: null,
                          );
                        }),

                    //selectSubcategoryWidget(context),
                  ],
                ),
              ),
              nextButtonWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  // selectSubcategoryWidget(BuildContext context) {
  //   subCategories.map((subCategory) => null);
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       subCategories.length == 0
  //           ? Center(
  //               child: Padding(
  //                 padding: const EdgeInsets.only(right: 10.0),
  //                 child: Text('حدد الرئيسي لتحميل الأنواع الفرعية'),
  //               ),
  //             )
  //           : Padding(
  //               padding: const EdgeInsets.only(right: Dimensions.marginSize),
  //               child: Text(
  //                 Strings.selectSubCategory,
  //                 style: TextStyle(
  //                     fontSize: Dimensions.extraLargeTextSize,
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //             ),
  //       Container(
  //         height: MediaQuery.of(context).size.height,
  //         width: MediaQuery.of(context).size.width,
  //         child: ListView.builder(
  //             itemCount: subCategories.length,
  //             physics: NeverScrollableScrollPhysics(),
  //             itemBuilder: (context, index) {
  //               //subCategories[index].imageUrl = '';
  //               return InkWell(
  //                 onTap: () {},
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(
  //                     left: Dimensions.marginSize,
  //                     right: Dimensions.marginSize,
  //                     bottom: Dimensions.heightSize,
  //                   ),
  //                   child: Container(
  //                     height: 90,
  //                     width: MediaQuery.of(context).size.width,
  //                     decoration: BoxDecoration(
  //                         color: Color(0xFFF8F8F8),
  //                         borderRadius:
  //                             BorderRadius.circular(Dimensions.radius)),
  //                     child: Row(
  //                       children: [
  //                         Expanded(
  //                           flex: 1,
  //                           child: Image.network(
  //                             subCategories[index].icon ?? '',
  //                             fit: BoxFit.contain,
  //                             errorBuilder: (BuildContext context,
  //                                 Object exception, StackTrace? stackTrace) {
  //                               return Image.asset(Strings.noImageSmall,
  //                                   fit: BoxFit.contain);
  //                             },
  //                           )
  //                           // FadeInImage.assetNetwork(
  //                           //         placeholder: Strings.noImageSmall,
  //                           //         image: 'https://i.stack.imgur.com/cWyFQ',
  //                           //         height: 90,
  //                           //         width: 90,
  //                           //         fit: BoxFit.cover,
  //                           //       )
  //
  //                           ,
  //                         ),
  //                         Expanded(
  //                           flex: 2,
  //                           child: Padding(
  //                             padding: const EdgeInsets.only(
  //                                 right: Dimensions.widthSize),
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Flexible(
  //                                   child: new Container(
  //                                     padding: new EdgeInsets.only(right: 13.0),
  //                                     child: new Text(
  //                                       subCategories[index].arabicName,
  //                                       overflow: TextOverflow.ellipsis,
  //                                       style: new TextStyle(
  //                                         fontSize: 13.0,
  //                                         fontFamily: 'Roboto',
  //                                         color: new Color(0xFF212121),
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   height: Dimensions.heightSize * 0.5,
  //                                 ),
  //                                 Text('الطرق العامه',
  //                                     style: CustomStyle.textStyle),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                         // Expanded(
  //                         //   flex: 1,
  //                         //   child: Container(
  //                         //     height: 50.0,
  //                         //     decoration: BoxDecoration(
  //                         //         color: CustomColor.secondaryColor,
  //                         //         borderRadius: BorderRadius.all(
  //                         //             Radius.circular(Dimensions.radius)),
  //                         //         border: Border.all(
  //                         //             color: Colors.black.withOpacity(0.1))),
  //                         //     child: Padding(
  //                         //       padding: const EdgeInsets.only(
  //                         //           left: Dimensions.marginSize * 0.5,
  //                         //           right: Dimensions.marginSize * 0.5),
  //                         //       child: DropdownButton(
  //                         //         isExpanded: true,
  //                         //         underline: Container(),
  //                         //         hint: Text(
  //                         //           selectedService,
  //                         //           style: CustomStyle.textStyle,
  //                         //         ),
  //                         //         // Not necessary for Option 1
  //                         //         value: selectedService,
  //                         //         onChanged: (newValue) {
  //                         //           // setState(() {
  //                         //           //   selectedService = newValue;
  //                         //           //   print('value: '+selectedService.toString());
  //                         //           // });
  //                         //         },
  //                         //         items: services.serviceList.map((value) {
  //                         //           return DropdownMenuItem(
  //                         //             child: new Text(
  //                         //               value,
  //                         //               style: CustomStyle.textStyle,
  //                         //             ),
  //                         //             value: value,
  //                         //           );
  //                         //         }).toList(),
  //                         //       ),
  //                         //     ),
  //                         //   ),
  //                         // )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             }),
  //       ),
  //       SizedBox(
  //         height: 50,
  //       ),
  //     ],
  //   );
  // }

  nextButtonWidget(BuildContext context) {
    return Positioned(
      bottom: 80,
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
                AppLocalizations.of(context).translate('next'),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Dimensions.largeTextSize,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            // if (BlocProvider.of<IncidentBloc>(context).incident.subCategoryId ==
            //     null)
            //   return;
            // else
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => IncidentFormStep2()));
            // // BlocProvider.of<IncidentBloc>(context).incident.categoryId = 34;
            // // BlocProvider.of<IncidentBloc>(context).add(IncidentChanged(
            // //     BlocProvider.of<IncidentBloc>(context).incident));
          },
        ),
      ),
    );
  }
}
