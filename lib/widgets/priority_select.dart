import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../constants/enums.dart';
import '../models/priority/priority.dart';
import '../stores/priority/priority_store.dart';
import 'progress_indicator/progress_indicator_text_widget.dart';

class _PriorityListWidget extends StatefulWidget {
  void Function(Priority?)? onSelectedPriorityChanged;
  PriorityListViewMode priorityListView;

  int? initialSelectedId;

  _PriorityListWidget(
      {this.onSelectedPriorityChanged,
      this.priorityListView = PriorityListViewMode.Radiobutton,
      this.initialSelectedId});

  @override
  _PriorityListWidgetState createState() => _PriorityListWidgetState();
}

class _PriorityListWidgetState extends State<_PriorityListWidget> {
  //stores:---------------------------------------------------------------------
  late PriorityStore _priorityStore;
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
    _priorityStore = Provider.of<PriorityStore>(context);

    // check to see if already called api
    if (!_priorityStore.loading) {
      _priorityStore.getPriorities();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  bool initialed = false;

  setInitialSelectedPriority() {
    if (initialed) return;
    if (_selectedPriority == null && widget.initialSelectedId != null) {
      if (_priorityStore.priorityList?.priorities != null) {
        if (_priorityStore.priorityList!.priorities!
                .any((element) => element.id == widget.initialSelectedId) ==
            true) {
          _selectedPriority = _priorityStore.priorityList!.priorities!
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
        return _priorityStore.loading
            ? CustomProgressIndicatorTextWidget(
                message: 'Loading Priorities...',
              )
            : Material(child: _priorityView());
      },
    );
  }

  Widget _priorityView() {
    setInitialSelectedPriority();
    return widget.priorityListView == PriorityListViewMode.List
        ? _buildListView()
        : widget.priorityListView == PriorityListViewMode.Radiobutton
            ? _buildRadiobuttonListView()
            : Center(
                child: Text('There is no selected view type!'),
              );
  }

  Widget _buildListView() {
    return _priorityStore.priorityList != null
        ? ListView.separated(
            itemCount: _priorityStore.priorityList!.priorities!.length,
            separatorBuilder: (context, position) {
              return Divider();
            },
            itemBuilder: (context, position) {
              return _buildListItem(position);
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
            ),
          );
  }

  Widget _buildRadiobuttonListView() {
    return _priorityStore.priorityList != null
        ? ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _priorityStore.priorityList!.priorities!.length,
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

  Priority? _selectedPriority;

  _onSubCategoryTap(Priority? priority) {
    setState(() {
      if (_selectedPriority?.id == priority?.id) {
        _selectedPriority = null;
        if (widget.onSelectedPriorityChanged != null)
          widget.onSelectedPriorityChanged!(null);
      } else {
        _selectedPriority = priority;
        if (widget.onSelectedPriorityChanged != null)
          widget.onSelectedPriorityChanged!(priority);
      }
    });
  }

  Widget _buildRadioItem(int position) {
    return InkWell(
      onTap: () {
        // selectedMainCategory = e;
        // widget.selectedCategoryChanged(e.id);

        _onSubCategoryTap(_priorityStore.priorityList!.priorities![position]);
      },
      child: Row(
        children: [
          Radio<Priority>(
            value: _priorityStore.priorityList!.priorities![position],
            toggleable: true,
            autofocus: true,
            groupValue: _selectedPriority,
            onChanged: (Priority? value) {
              // setState(() {
              // selectedMainCategory = value;
              // widget.selectedCategoryChanged(value.id);
              // });
              _onSubCategoryTap(value);
            },
          ),
          Text(
            '${_priorityStore.priorityList?.priorities?[position].localizedName(_languageStore.locale)}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(int position) {
    return ListTile(
      dense: true,
      leading: Icon(Icons.cloud_circle),
      title: Text(
        '${_priorityStore.priorityList?.priorities?[position].localizedName(_languageStore.locale)}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: _priorityStore.priorityList?.priorities?[position]?.id ==
                _selectedPriority?.id
            ? Theme.of(context).textTheme.subtitle1
            : Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(
        '${_priorityStore.priorityList?.priorities?[position].localizedName(_languageStore.locale)}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
      onTap: () {
        _onSubCategoryTap(_priorityStore.priorityList?.priorities?[position]);
      },
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_priorityStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_priorityStore.errorStore.errorMessage);
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

class PriorityFormField extends FormField<Priority> {
  PriorityListViewMode priorityListView;
  Function(Priority?)? onChange;
  StreamController<Priority?>? stream;

  PriorityFormField(
      {required FormFieldSetter<Priority> onSaved,
      required FormFieldValidator<Priority> validator,
      int? initialSelectedId,
      //Category? initialValue,
      AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
      this.priorityListView = PriorityListViewMode.Radiobutton,
      this.onChange,
      this.stream})
      : super(
            onSaved: onSaved,
            validator: validator,
            //initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<Priority> state) {
              return Container(
                height: 50,
                child: Stack(
                  children: [
                    _PriorityListWidget(
                        initialSelectedId: initialSelectedId,
                        onSelectedPriorityChanged: (priority) {
                          if (onChange != null) {
                            onChange(priority);
                          }
                          state.didChange(priority);
                          if (stream != null) stream.add(priority);
                        },
                        priorityListView: priorityListView),
                    state.hasError
                        ? Text(
                            '${state.errorText}',
                            style: TextStyle(color: Colors.red),
                          )
                        : Container()
                  ],
                ),
              );
            });
}
