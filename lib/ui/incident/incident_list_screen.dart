import 'dart:async';

import 'package:boilerplate/stores/incident/incident_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/enums.dart';
import '../../models/incident/incident.dart';
import '../../models/incident/incident_filter.dart';
import '../../models/subcategory/subcategory.dart';
import '../../utils/locale/app_localization.dart';
import '../../widgets/incident/incident_item_details.dart';
import '../../widgets/incident/incident_list_widget.dart';
import '../../widgets/progress_indicator/progress_indicator_text_widget.dart';
import '../../widgets/subcategories_select.dart';
import '../constants/colors.dart';
import '../constants/custom_style.dart';
import '../constants/dimensions.dart';
import '../constants/strings.dart';
import '../dummy_data/near_by.dart';

class IncidentListScreen extends StatefulWidget {
  int? initialSubCategoryId;
  bool? showBack = false;

  bool hideSubCategoryWidget;

  @override
  _IncidentListScreenState createState() => _IncidentListScreenState();

  IncidentListScreen(
      {this.initialSubCategoryId,
      this.showBack,
      this.hideSubCategoryWidget = false});
}

class _IncidentListScreenState extends State<IncidentListScreen> {
  TextEditingController searchController = TextEditingController();

  var selectedCatId;
  var selectedSubCatId;

  late AppLocalizations _appLocalizations;

  @override
  void didChangeDependencies() {
    _appLocalizations = AppLocalizations.of(context);
    _subcategoryStreamController = StreamController<SubCategory?>();
    super.didChangeDependencies();
  }

  StreamController<SubCategory?>? _subcategoryStreamController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 2),
                  topRight: Radius.circular(Dimensions.radius * 2))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimensions.heightSize * 0.5,
                ),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: Dimensions.marginSize),
                    child: Text(
                      '${_appLocalizations.translate('myIncidentList')}',
                      style: TextStyle(
                          fontSize: Dimensions.extraLargeTextSize,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                widget.showBack == true
                    ? Padding(
                        padding: const EdgeInsets.only(
                            right: Dimensions.marginSize,
                            top: Dimensions.heightSize * 5,
                            bottom: Dimensions.heightSize * 3),
                        child: GestureDetector(
                          child: Container(
                              width: 120,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    Strings.back,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Dimensions.largeTextSize),
                                  )
                                ],
                              )),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    : Container(),
                //IncidentsMap(),
                SizedBox(
                  height: Dimensions.heightSize * 0.5,
                ),

                widget.hideSubCategoryWidget
                    ? Container()
                    : SubCategoryFormField(
                        gridAndListHeight:
                            MediaQuery.of(context).size.height - 370,

                        autoSelectFirstItem: true,
                        subcategoryListView:
                            SubCategoryListViewMode.Radiobutton,
                        initialSelectedId: widget.initialSubCategoryId,
                        onChange: (subcategory) {
                          //fetch incidents by sub category
                          _subcategoryStreamController?.add(subcategory);
                        },
                        onSaved: (category) {},
                        validator: (category) {
                          // return selectedSubCat == null ? 'select one ' : null;
                        },
                        stream: _subcategoryStreamController,
                        //initialValue: null,
                      ),
                //IncidentsMap(),

                StreamBuilder<SubCategory?>(
                  builder: (context, snapshot) {
                    return snapshot?.data?.id == null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                                '${_appLocalizations.translate('selectSubCategory')}'),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height - 300,
                            //color: Colors.black12,
                            child: IncidentListFormField(
                              height: MediaQuery.of(context).size.height - 300,
                              subCategoryId: snapshot?.data?.id,
                              categoryId: null,
                              incidentId: null,
                              incidentListView: IncidentListViewMode.List,
                              onSaved: (d) {},
                              onChange: (d) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => InidentDetailsScreen(
                                          incidentId: d?.id,
                                        )));
                              },
                              validator: (Incident? value) {},
                            ),
                          );
                  },
                  stream: _subcategoryStreamController?.stream,
                ),
                // SizedBox(
                //   height: 30,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  headerWidget(BuildContext context) {
    return Positioned(
      top: -65,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.marginSize, right: Dimensions.marginSize),
            child: TextFormField(
              style: CustomStyle.textStyle,
              controller: searchController,
              validator: (String? value) {
                // if (value.isEmpty) {
                //   return Strings.spaFacialMakeup;
                // } else {
                //   return null;
                // }
              },
              decoration: InputDecoration(
                hintText: Strings.spaFacialMakeup,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                labelStyle: CustomStyle.textStyle,
                focusedBorder: CustomStyle.focusBorder,
                enabledBorder: CustomStyle.focusErrorBorder,
                focusedErrorBorder: CustomStyle.focusErrorBorder,
                errorBorder: CustomStyle.focusErrorBorder,
                filled: true,
                fillColor: CustomColor.secondaryColor,
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.black.withOpacity(0.4),
                  size: Dimensions.heightSize * 2,
                ),
                hintStyle: CustomStyle.textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  nearByWidget(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 0,
      left: 0,
      child: Container(
        height: 220,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: NearByList.list().length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            NearBy nearby = NearByList.list()[index];
            return Padding(
              padding: const EdgeInsets.only(left: Dimensions.marginSize),
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 200,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Dimensions.radius),
                                topRight: Radius.circular(Dimensions.radius)),
                            child: Image.asset(
                              nearby.image,
                              height: 150,
                              width: 200,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Positioned(
                            bottom: 20.0,
                            left: 10,
                            child: Row(
                              children: [
                                Container(
                                  height: 25,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: CustomColor.primaryColor,
                                      borderRadius: BorderRadius.circular(13)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      Text(
                                        nearby.rating,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Dimensions.smallTextSize,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.widthSize * 0.5,
                                ),
                                Container(
                                  height: 25,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: CustomColor.secondaryColor,
                                      borderRadius: BorderRadius.circular(13)),
                                  child: Center(
                                    child: Text(
                                      nearby.status,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Dimensions.smallTextSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize),
                    Column(
                      children: [
                        Text(
                          nearby.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.largeTextSize,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Dimensions.heightSize * 0.5,
                        ),
                        Text(
                          nearby.location,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.defaultTextSize,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
