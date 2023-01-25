import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/PriorityLevels%20/priorrity_level.dart';
import 'package:boilerplate/models/priority/priority.dart';
import 'package:boilerplate/stores/category/category_store.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/enums.dart';
import '../../models/category/category.dart';
import '../../models/subcategory/subcategory.dart';
import '../../stores/user/user_store.dart';
import '../../widgets/categories_select.dart';
import '../../widgets/incident/incident_item_details.dart';
import '../../widgets/incident/incident_list_widget.dart';
import '../../widgets/media_picker_widget.dart';
import '../../widgets/google_map/place_picker_widget.dart';
import '../../widgets/priority_select.dart';
import '../../widgets/subcategories_select.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  //stores:---------------------------------------------------------------------
  late CategoryStore _categoryStore;
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;
  late UserStore _userStore;

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
    _categoryStore = Provider.of<CategoryStore>(context);
    _userStore = Provider.of<UserStore>(context);

    // check to see if already called api
    if (!_categoryStore.loading) {
      _categoryStore.getCategories();
    }
  }

  Category? selectedCat;
  SubCategory? selectedSubCat;

  StreamController<PriorityLevel?>? stream = StreamController<PriorityLevel?>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        // body: CategoryListWidget(onSelectedCategoryChanged: (category) {
        //   var ff;
        // }),
        body:

        // InidentDetailsScreen(
        //   incidentId: '6da02150-dd47-4cc4-99f2-90713e4b9bde',
        // )
        // IncidentFormField(
        //   incidentListView: IncidentListView.List,
        //   initialSelectedId: 8,
        //   onChange: (incident) {
        //     //selectedCat = category;
        //   },
        //   onSaved: (incident) {},
        //   validator: (incident) {
        //     return selectedCat == null ? 'select priority ' : null;
        //   },
        //  // stream: stream,
        //   //initialValue: null,
        // ),

        // PriorityFormField(
        //   initialSelectedId: 8,
        //   onChange: (category) {
        //     //selectedCat = category;
        //   },
        //   onSaved: (category) {},
        //   validator: (category) {
        //     return selectedCat == null ? 'select priority ' : null;
        //   },
        //   stream: stream,
        //   //initialValue: null,
        // ),

        // PlacePickerWidget(
        //   loadMapBtnPopupText: 'open map',
        //   loadMapBtnContainerText: 'open container',
        //   onPlaceChange: (placeInfo) {},
        //   showMapInDialog: true,
        // )
        SubCategoryFormField(
          gridAndListHeight: MediaQuery.of(context).size.height - 370,

          subcategoryListView: SubCategoryListViewMode.ImageList,
          initialSelectedId: 8,
          onChange: (category) {
            selectedSubCat = category;
          },
          onSaved: (category) {},
          validator: (category) {
            return selectedSubCat == null ? 'select one ' : null;
          },
         // stream: stream,
          //initialValue: null,
        ),

        //     MediaPickerWidget(
        //   onImageListChanged: (list) {},
        //   hidePickSingleVideoFromGallery: true,
        //   hideTakeVideo: true,
        //   //showSelectedImage: false,
        // )
        //
        );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(AppLocalizations.of(context).translate('home_tv_cats')),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      _buildLanguageButton(),
      _buildThemeButton(),
      _buildLogoutButton(),
      StreamBuilder(
        builder: (context, snapshot) {
          return Container(
            child: Text('${selectedCat?.arabicName}'),
          );
        },
        stream: stream?.stream,
      )
    ];
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {
            _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
          },
          icon: Icon(
            _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return IconButton(
      onPressed: () {
        SharedPreferences.getInstance().then((preference) {
          _userStore.logout();
          Navigator.of(context).pushReplacementNamed(Routes.login);
        });
      },
      icon: Icon(
        Icons.power_settings_new,
      ),
    );
  }

  Widget _buildLanguageButton() {
    return IconButton(
      onPressed: () {
        _buildLanguageDialog();
      },
      icon: Icon(
        Icons.language,
      ),
    );
  }

  // body methods:--------------------------------------------------------------

  // General Methods:-----------------------------------------------------------

  _buildLanguageDialog() {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        enableFullWidth: true,
        title: Text(
          AppLocalizations.of(context).translate('home_tv_choose_language'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        closeButtonColor: Colors.white,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        children: _languageStore.supportedLanguages
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0.0),
                title: Text(
                  object.language!,
                  style: TextStyle(
                    color: _languageStore.locale == object.locale
                        ? Theme.of(context).primaryColor
                        : _themeStore.darkMode
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // change user language based on selected locale
                  _languageStore.changeLanguage(object.locale!);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  _showDialog<T>({required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
    });
  }
}
