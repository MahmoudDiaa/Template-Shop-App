import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import '../constants/enums.dart';
import '../models/incident/incident.dart';
import '../stores/incident/incident_store.dart';
import '../ui/constants/custom_style.dart';
import '../ui/constants/dimensions.dart';
import 'progress_indicator/progress_indicator_text_widget.dart';

class _IncidentListWidget extends StatefulWidget {
  void Function(Incident?)? onSelectedIncidentChanged;
  IncidentListViewMode incidentListView;

  int? initialSelectedId;

  bool autoSelectFirstItem;

  _IncidentListWidget({
    this.onSelectedIncidentChanged,
    this.incidentListView = IncidentListViewMode.Radiobutton,
    this.initialSelectedId,
    this.autoSelectFirstItem = false,
  });

  @override
  _IncidentListWidgetState createState() => _IncidentListWidgetState();
}

class _IncidentListWidgetState extends State<_IncidentListWidget> {
  //stores:---------------------------------------------------------------------
  late IncidentStore _incidentStore;
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _incidentStore = Provider.of<IncidentStore>(context);

    // check to see if already called api
    if (!_incidentStore.loading) {
      _incidentStore.getIncidents();
    }
  }

  @override
  Widget build(BuildContext context) {
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
          Future.delayed(Duration(seconds: 0), () {
            _onIncidentTap(_incidentStore.incidentList!.incidents!.firstWhere(
                (element) => element.id == widget.initialSelectedId));
          });
          widget.initialSelectedId = null;
        }
      }
    } else if (widget.autoSelectFirstItem == true &&
        _incidentStore.incidentList?.incidents != null) {
      Future.delayed(Duration(seconds: 0), () {
        _onIncidentTap(_incidentStore.incidentList!.incidents![0]);
      });
    }
    // if (_selectedIncident != null)
    //   Future.delayed(Duration(seconds: 0), () {
    //     _onIncidentTap(_selectedIncident);
    //   });

    initialed = true;
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _incidentStore.loading
            ? CustomProgressIndicatorTextWidget(
                message: 'Loading Categories...',
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

  Widget _buildListView() {
    return _incidentStore.incidentList != null
        ? ListView(
            scrollDirection: Axis.horizontal,
            children: _incidentStore.incidentList!.incidents!
                .map((e) => _buildRadioItem(e))
                .toList(),
            // itemCount: _incidentStore.incidentList!.incidents!.length,
            // separatorBuilder: (context, position) {
            //   return Divider();
            // },
            // itemBuilder: (context, position) {
            //   return _buildListItem(position);
            // },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
            ),
          );
  }

  Widget _buildRadiobuttonListView() {
    return _incidentStore.incidentList != null
        ? Container(
            height: 30.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _incidentStore.incidentList!.incidents!
                  .map((e) => _buildRadioItem(e))
                  .toList(),
              // itemCount: _subincidentStore.subincidentList!.subincidents!.length,
              // separatorBuilder: (context, position) {
              //   return Divider();
              // },
              // itemBuilder: (context, position) {
              //   return _buildRadioItem(position);
              // },
            ),
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
            ),
          );
  }

  Incident? _selectedIncident;

  _onIncidentTap(Incident? incident) {
    setState(() {
      if (_selectedIncident?.id == incident?.id) {
        _selectedIncident = null;
        if (widget.onSelectedIncidentChanged != null)
          widget.onSelectedIncidentChanged!(null);
      } else {
        _selectedIncident = incident;
        if (widget.onSelectedIncidentChanged != null)
          widget.onSelectedIncidentChanged!(incident);
      }
    });
  }

  Widget _buildRadioItem(Incident incident) {
    var dd = InkWell(
      onTap: () {
        _onIncidentTap(incident);
      },
      child: Row(
        children: [
          Radio<Incident>(
            value: incident,
            toggleable: true,
            autofocus: true,
            groupValue: _selectedIncident,
            onChanged: (Incident? value) {
              _onIncidentTap(value);
            },
          ),
          Text(
            '${incident.localizedTitle(_languageStore.locale)}',
            style: CustomStyle.textStyle,
          ),
          SizedBox(
            width: Dimensions.widthSize,
          ),
        ],
      ),
    );
    return dd;
  }

  Widget _buildListItem(int position) {
    return ListTile(
      dense: true,
      leading: Icon(Icons.cloud_circle),
      title: Text(
        '${_incidentStore.incidentList?.incidents?[position].localizedTitle(_languageStore.locale)}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: _incidentStore.incidentList?.incidents?[position]?.id ==
                _selectedIncident?.id
            ? Theme.of(context).textTheme.subtitle1
            : Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(
        '${_incidentStore.incidentList?.incidents?[position].localizedTitle(_languageStore.locale)}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
      onTap: () {
        _onIncidentTap(_incidentStore.incidentList?.incidents?[position]);
      },
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
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }
}

class IncidentFormField extends FormField<Incident> {
  IncidentListViewMode incidentListView;
  Function(Incident?)? onChange;
  StreamController<Incident?>? stream;

  IncidentFormField(
      {required FormFieldSetter<Incident> onSaved,
      required FormFieldValidator<Incident> validator,
      int? initialSelectedId,
      //Incident? initialValue,
      AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
      this.incidentListView = IncidentListViewMode.Radiobutton,
      this.onChange,
      this.stream,
      bool autoSelectFirstItem = false})
      : assert(initialSelectedId == null || autoSelectFirstItem == false),
        super(
            onSaved: onSaved,
            validator: validator,
            //initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<Incident> state) {
              return Stack(
                children: [
                  _IncidentListWidget(
                      autoSelectFirstItem: autoSelectFirstItem,
                      initialSelectedId: initialSelectedId,
                      onSelectedIncidentChanged: (incident) {
                        if (onChange != null) {
                          onChange(incident);
                        }
                        state.didChange(incident);
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
