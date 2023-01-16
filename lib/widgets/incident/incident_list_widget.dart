import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/incident/incident.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/enums.dart';
import '../../data/sharedpref/shared_preference_helper.dart';
import '../../extension/string_extension.dart';
import '../../models/incident/incident_filter.dart';
import '../../stores/incident/incident_store.dart';
import '../../stores/incident_form/incident_form_store.dart';
import '../../ui/constants/custom_style.dart';
import '../../ui/constants/dimensions.dart';
import '../../ui/sdad/incident_finally_sdad_screen.dart';
import '../../ui/sdad/incident_sdad_screen.dart';
import '../../ui/sdad/incident_upping_sdad_screen.dart';
import '../progress_indicator/progress_indicator_text_widget.dart';
import 'incident-employee-actions.dart';
import 'incident-mqawel-actions.dart';

class _IncidentListWidget extends StatefulWidget {
  void Function(Incident?)? onSelectedIncidentChanged;
  IncidentListViewMode incidentListView;

  int? initialSelectedId;

  int? subCategoryId;

  int? categoryId;
  String? incidentId;

  double height;

  _IncidentListWidget(
      {this.onSelectedIncidentChanged,
      this.incidentListView = IncidentListViewMode.Radiobutton,
      this.initialSelectedId,
      this.subCategoryId,
      this.categoryId,
      this.incidentId,
      required this.height});

  @override
  _IncidentListWidgetState createState() => _IncidentListWidgetState();
}

class _IncidentListWidgetState extends State<_IncidentListWidget> {
  //stores:---------------------------------------------------------------------
  late IncidentStore _incidentStore;
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;
  late IncidentFormStore _incidentFormStore;

  SharedPreferenceHelper? sharedPreferenceHelper;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    sharedPreferenceHelper = GetIt.instance<SharedPreferenceHelper>();
    _incidentFormStore = Provider.of<IncidentFormStore>(context);

    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _incidentStore = Provider.of<IncidentStore>(context);
  }

  void loadData() {
    if (!_incidentStore.loading) {
      _incidentStore.getIncidents(
        incidentFilter: IncidentFilter(
            subCategoryId: widget.subCategoryId,
            categoryId: widget.categoryId,
            incidentId: widget.incidentId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return _buildBody();
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  bool initialed = false;

  setInitialSelectedIncident() {
    if (initialed) return;
    if (_selectedIncident == null && widget.initialSelectedId != null) {
      if (_incidentStore.incidentList?.incidents != null) {
        if (_incidentStore.incidentList!.incidents!
                .any((element) => element.id == widget.initialSelectedId) ==
            true) {
          _selectedIncident = _incidentStore.incidentList!.incidents!
              .firstWhere((element) => element.id == widget.initialSelectedId);
          widget.initialSelectedId = null;
        }

        initialed = true;
      }
    }
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _incidentStore.loading
            ? CustomProgressIndicatorTextWidget(
                message: AppLocalizations.of(context)
                    .translate('loadingIncidentList'),
              )
            : Material(child: _incidentView());
      },
    );
  }

  Widget _incidentView() {
    setInitialSelectedIncident();
    return widget.incidentListView == IncidentListViewMode.List
        ? _buildListView()
        : widget.incidentListView == IncidentListViewMode.Radiobutton
            ? _buildRadiobuttonListView()
            : Center(
                child: Text('There is no selected view type!'),
              );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    print(_scrollController?.position.extentAfter);
    if (_scrollController.position.extentAfter < 500) {
      //load more incident items
      if (!_incidentStore.loading && !_incidentStore.loadingMore)
        _incidentStore.getMore(
          incidentFilter: IncidentFilter(
              subCategoryId: widget.subCategoryId,
              categoryId: widget.categoryId,
              incidentId: widget.incidentId),
        );
    }
  }

  late ScrollController _scrollController;

  Future _onRefreshList() async {
    _incidentStore.getIncidents(
      incidentFilter: IncidentFilter(
          subCategoryId: widget.subCategoryId,
          categoryId: widget.categoryId,
          incidentId: widget.incidentId),
    );
  }

  Widget _buildListView() {
    return (_incidentStore.incidentList != null &&
            _incidentStore.incidentList!.incidents != null &&
            _incidentStore.incidentList!.incidents!.isNotEmpty)
        ? Column(
            children: [
              RefreshIndicator(
                onRefresh: _onRefreshList,
                child: Container(
                  height: widget.height - 49,
                  child: Stack(
                    children: [
                      NotificationListener<UserScrollNotification>(
                        onNotification: (notification) {
                          final ScrollDirection direction =
                              notification.direction;
                          //print('-----------: ${notification.metrics.}');
                          if (notification.metrics.extentAfter < 1000 &&
                              notification.direction ==
                                  ScrollDirection.reverse) {
                            if (!_incidentStore.loading &&
                                !_incidentStore.loadingMore)
                              _incidentStore.getMore(
                                incidentFilter: IncidentFilter(
                                    subCategoryId: widget.subCategoryId,
                                    categoryId: widget.categoryId,
                                    incidentId: widget.incidentId),
                              );
                          }
                          // setState(() {
                          //   if (direction == ScrollDirection.reverse) {
                          //     _visible = false;
                          //   } else if (direction == ScrollDirection.forward) {
                          //     _visible = true;
                          //   }
                          // });
                          return true;
                        },
                        child: ListView.separated(
                          //controller: _scrollController,
                          shrinkWrap: true,
                          itemCount:
                              _incidentStore.incidentList!.incidents!.length,
                          separatorBuilder: (context, position) {
                            return Divider();
                          },
                          itemBuilder: (context, position) {
                            return _buildListItem(position);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Observer(
                builder: (context) {
                  return _incidentStore.loadingMore
                      ? Text(
                          AppLocalizations.of(context).translate('gettingMore'))
                      : TextButton(
                          onPressed: () {
                            if (!_incidentStore.loading &&
                                !_incidentStore.loadingMore)
                              _incidentStore.getMore(
                                incidentFilter: IncidentFilter(
                                    subCategoryId: widget.subCategoryId,
                                    categoryId: widget.categoryId,
                                    incidentId: widget.incidentId),
                              );
                          },
                          child: Text(AppLocalizations.of(context)
                              .translate('loadmore')));
                },
              )
            ],
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              child: EmptyWidget(
                image: null,
                packageImage: PackageImage.Image_1,
                title:
                    '${AppLocalizations.of(context).translate('home_tv_no_post_found')}',
                subTitle:
                    '${AppLocalizations.of(context).translate('home_tv_no_post_found_line2')}${widget.subCategoryId}',
                titleTextStyle: TextStyle(
                  fontSize: 22,
                  color: Color(0xff9da9c7),
                  fontWeight: FontWeight.w500,
                ),
                subtitleTextStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xffabb8d6),
                ),
              ),
            ),
            // Center(
            //   child: Column(
            //     children: [
            //       Text(
            //         AppLocalizations.of(context).translate('home_tv_no_post_found'),
            //       ),
            //     ],
            //   ),
            // ),
          );
  }

  Widget _buildRadiobuttonListView() {
    return _incidentStore.incidentList != null
        ? ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _incidentStore.incidentList!.incidents!.length,
            separatorBuilder: (context, position) {
              return Divider();
            },
            itemBuilder: (context, position) {
              return _buildRadioItem(position);
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
            ),
          );
  }

  Incident? _selectedIncident;

  _onIncidentTap(Incident? incident) {
    // setState(() {
    //   if (_selectedIncident?.id == incident?.id) {
    //     _selectedIncident = null;
    //     if (widget.onSelectedIncidentChanged != null)
    //       widget.onSelectedIncidentChanged!(null);
    //   } else {
    //     _selectedIncident = incident;
    //     if (widget.onSelectedIncidentChanged != null)
    //       widget.onSelectedIncidentChanged!(incident);
    //   }
    _selectedIncident = incident;
    if (widget.onSelectedIncidentChanged != null)
      widget.onSelectedIncidentChanged!(incident);
    // });
  }

  Widget _buildRadioItem(int position) {
    return InkWell(
      onTap: () {
        // selectedMainIncident = e;
        // widget.selectedIncidentChanged(e.id);

        _onIncidentTap(_incidentStore.incidentList!.incidents![position]);
      },
      child: Row(
        children: [
          Radio<Incident>(
            value: _incidentStore.incidentList!.incidents![position],
            toggleable: true,
            autofocus: true,
            groupValue: _selectedIncident,
            onChanged: (Incident? value) {
              // setState(() {
              // selectedMainIncident = value;
              // widget.selectedIncidentChanged(value.id);
              // });
              _onIncidentTap(value);
            },
          ),
          Text(
            '${_incidentStore.incidentList?.incidents?[position].localizedTitle(_languageStore.locale)}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(int index) {
    return InkWell(
      onTap: () {
        _onIncidentTap(_incidentStore.incidentList!.incidents![index]);
      },
      // onLongPress: () async {
      //   if (sharedPreferenceHelper?.authUser?.user?.isMqawel == true &&
      //       _incidentStore.incidentList!.incidents![index].incidentStatusId ==
      //           IncidentStatusEnum.Assigned.id) await _openSdadWindow(index);
      // },
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
          bottom: Dimensions.heightSize,
        ),
        child: Column(
          children: [
            Container(
              height: 110,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(Dimensions.radius)),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                          imageUrl:
                              '${_incidentStore.incidentList!.incidents![index].primaryImageFromList?.UrlAfterCheckUrl}',
                          fit: BoxFit.cover,
                          width: 90,
                          height: 90,
                          color: Colors.black.withOpacity(0.5),
                          colorBlendMode: BlendMode.softLight,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, err) => Center(
                                  child: Text(
                                AppLocalizations.of(context)
                                    .translate('cannotGetImage'),
                              )))

                      // Image.network(
                      //   '${_incidentStore.incidentList!.incidents![index].primaryImageFromList?.imageUrl}',
                      //   height: 90,
                      //   width: 90,
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: Dimensions.widthSize,
                          left: Dimensions.widthSize),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${index + 1} - ${_incidentStore.incidentList!.incidents![index].localizedTitle(_languageStore.locale)}',
                            style: TextStyle(
                                fontSize: Dimensions.defaultTextSize,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            //softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: Dimensions.heightSize * 0.5,
                          ),
                          Text(
                            ' ${_incidentStore.incidentList!.incidents![index].localizedStatusName(_languageStore.locale)}',
                            style: TextStyle(
                                color: _incidentStore.incidentList!
                                    .incidents![index].StatusColorDart),
                          ),
                          Text(
                              ' ${_incidentStore.incidentList!.incidents![index].createDate != null ? DateFormat('dd/MM/yyyy').format(_incidentStore.incidentList!.incidents![index].createDate!) : ''} ${_incidentStore.incidentList!.incidents![index].createDate != null ? DateFormat("h:mma").format(_incidentStore.incidentList!.incidents![index].createDate!) : ''}  ',
                              style: CustomStyle.textStyle),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            EmplyeeActionButtons(
              incident: _incidentStore.incidentList!.incidents![index],
              onFinallySdadDone: (result) {
                if (result == true) loadData();
              },
              onUppingSdadDone: (result) {
                if (result == true) loadData();
              },
            ),
            MqawelActionButtons(
              incident: _incidentStore.incidentList!.incidents![index],
              onSdadDone: (result) {
                if (result == true) loadData();
              },
            ),
          ],
        ),
      ),
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

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 0),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }
}

class IncidentListFormField extends FormField<Incident> {
  IncidentListViewMode incidentListView;
  Function(Incident?)? onChange;
  StreamController<Incident?>? stream;

  IncidentListFormField(
      {required FormFieldSetter<Incident> onSaved,
      required FormFieldValidator<Incident> validator,
      int? initialSelectedId,
      //Incident? initialValue,
      AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
      this.incidentListView = IncidentListViewMode.Radiobutton,
      this.onChange,
      this.stream,
      int? subCategoryId,
      int? categoryId,
      String? incidentId,
      required double height})
      : super(
            onSaved: onSaved,
            validator: validator,
            //initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<Incident> state) {
              return Stack(
                children: [
                  _IncidentListWidget(
                      height: height,
                      subCategoryId: subCategoryId,
                      categoryId: categoryId,
                      incidentId: incidentId,
                      initialSelectedId: initialSelectedId,
                      onSelectedIncidentChanged: (incident) {
                        if (onChange != null) {
                          onChange(incident);
                        }
                        //state.didChange(incident);
                        if (stream != null) stream.add(incident);
                      },
                      incidentListView: incidentListView),
                  state.hasError
                      ? Text(
                          '${state.errorText}',
                          style: TextStyle(color: Colors.red),
                        )
                      : Container()
                ],
              );
            });
}
