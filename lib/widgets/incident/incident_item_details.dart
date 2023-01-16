import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/models/incident/incident.dart';
import 'package:boilerplate/widgets/incident/transactions_timeline.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../stores/incident/incident_store.dart';
import '../../stores/language/language_store.dart';
import '../../stores/theme/theme_store.dart';
import '../../ui/constants/colors.dart';
import '../../ui/constants/dimensions.dart';
import '../../utils/locale/app_localization.dart';
import '../navigation/back_widget.dart';
import '../progress_indicator/progress_indicator_text_widget.dart';
import '../progress_indicator/progress_indicator_widget.dart';
import 'about_incident_widget.dart';

import 'incident_images_widget.dart';
import 'incident_transactions_widget.dart';

class InidentDetailsScreen extends StatefulWidget {
  String? incidentId;

  Incident? incident;

  InidentDetailsScreen({Key? key, this.incidentId, this.incident})
      : assert(incidentId != null || incident != null),
        super(key: key);

  @override
  _InidentDetailsScreenState createState() => _InidentDetailsScreenState();
}

class _InidentDetailsScreenState extends State<InidentDetailsScreen> {
  //stores:---------------------------------------------------------------------
  late IncidentStore _incidentStore;
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _incidentStore = Provider.of<IncidentStore>(context);

    // check to see if already called api
    if (!_incidentStore.gettingIncident) {
      if (widget.incidentId != null)
        _incidentStore.getIncident(widget.incidentId!);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _handleErrorMessage(),
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Observer(
              builder: (context) {
                return _incidentStore.gettingIncident
                    ? CustomProgressIndicatorWidget()
                    : Material(
                        child: Column(
                        children: [
                          headerWidget(context),
                          detailsWidget(context),
                        ],
                      ));
              },
            )

            // FutureBuilder(
            //     future: categoryService.getIncident(widget.incidentId),
            //     builder: (BuildContext ctx, AsyncSnapshot<Incident> snapshot) {
            //       if (snapshot.hasData) incident = snapshot.data;
            //       return Column(
            //         children: [
            //           headerWidget(context, snapshot),
            //           detailsWidget(context, snapshot),
            //         ],
            //       );
            //     }),
            ),
      ],
    );
  }

  headerWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        children: [
          CachedNetworkImage(
              imageUrl: _incidentStore
                      .incident?.primaryImageFromList?.UrlAfterCheckUrl ??
                  '',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.softLight,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, err) =>
                  Center(child: Text('جاري تحميل الصورة الرئيسية.'))),
          BackWidget(),
          Positioned(
            bottom: Dimensions.heightSize * 2,
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
            child: Container(
              color: CustomColor.primaryColor.withOpacity(0.6),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(

                      _incidentStore.incident
                              ?.localizedTitle(_languageStore.locale) ??
                          '',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.extraLargeTextSize),
                    ),
                    Text(
                      _incidentStore.incident?.createDate == null
                          ? ''
                          : DateFormat('dd/MM/yyyy')
                              .format(_incidentStore.incident!.createDate!)
                      //'${incident.incidentCategoryArabicName ?? ''} -- ${incident.incidentSubCategoryArabicName ?? ''}'
                      ,
                      style: TextStyle(
                          color: CustomColor.redDarkColor,
                          fontSize: Dimensions.smallTextSize,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // MyRating(
                        //   rating: '5.0',
                        // ),

                        Container(
                          height: 30.0,
                          width: 145.0,
                          decoration: BoxDecoration(
                            color: CustomColor.primaryColor.withOpacity(0.5),
                          ),
                          child: Center(
                            child: Text(
                              _incidentStore.incident?.localizedStatusName(
                                      _languageStore.locale) ??
                                  'Unknown status!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.smallTextSize),
                            ),
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            color: CustomColor.secondaryColor.withOpacity(0.5),
                          ),
                          child: Center(
                            child: Text(
                              _incidentStore.incident?.localizedPriorityName(
                                      _languageStore.locale) ??
                                  '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.smallTextSize),
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 30.0,
                        //   width: 100.0,
                        //   decoration: BoxDecoration(
                        //       color: CustomColor.primaryColor,
                        //       borderRadius: BorderRadius.circular(15.0)),
                        //   child: Center(
                        //     child: Text(
                        //       (incident.createdBy == null ||
                        //               incident.createdBy.isEmpty)
                        //           ? 'مستخدم!'
                        //           : incident.createdBy,
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: Dimensions.smallTextSize),
                        //     ),
                        //   ),
                        // )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  int currentTabIndex = 0;

  detailsWidget(BuildContext context) {
    int totalPages = 3;
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.65,
          color: Colors.white,
          child: Observer(
            builder: (context) {
              return _incidentStore.gettingIncident
                  ? CustomProgressIndicatorTextWidget(
                      message: 'Loading Incidents...',
                    )
                  : Material(
                      child: PageView.builder(
                          itemCount: totalPages,
                          itemBuilder: (context, index) {
                            return Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 40.0,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 40,
                                              color: index == 0
                                                  ? CustomColor.primaryColor
                                                  : Colors.black,
                                              child: GestureDetector(
                                                onTap: () {
                                                  currentTabIndex = 0;
                                                },
                                                child: Center(
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate('details'),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: Dimensions
                                                            .defaultTextSize,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 40,
                                              color: index == 1
                                                  ? CustomColor.primaryColor
                                                  : Colors.black,
                                              child: GestureDetector(
                                                onTap: () {
                                                  currentTabIndex = 1;
                                                },
                                                child: Center(
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate('theImages'),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: Dimensions
                                                            .defaultTextSize,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 40,
                                              color: index == 2
                                                  ? CustomColor.primaryColor
                                                  : Colors.black,
                                              child: GestureDetector(
                                                onTap: () {
                                                  currentTabIndex = 2;
                                                },
                                                child: Center(
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'incidentTransactions'),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: Dimensions
                                                            .defaultTextSize,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: pageViewWidget(index),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }));
            },
          ),
        ),
      ],
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_incidentStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_incidentStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  pageViewWidget(int i) {
    switch (i) {
      case 0:
        return AboutIncidentWidget(
          incident: _incidentStore.incident!,
          onSdadDone: () {
            _incidentStore.getIncident(widget.incidentId!);
          },
        );
      case 1:
        return IncidentImagesWidget(
          incident: _incidentStore.incident!,
        );
      case 2:
        return Container(
          height: MediaQuery.of(context).size.height * 0.65,
          child: IncidentTransactionTimeline(
            incident: _incidentStore.incident!,
          ),
        );
      // case 3:
      //   return ServiceWidget();

      // default:
      //   return AboutIncidentWidget(
      //     incident: _incidentStore.incident!,
      //   );
    }
  }
}
