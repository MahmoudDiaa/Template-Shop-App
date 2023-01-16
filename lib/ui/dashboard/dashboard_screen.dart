import 'dart:ui';

import 'package:boilerplate/ui/constants/colors.dart';
import 'package:boilerplate/ui/create_incident/create_incident_step1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

// import 'package:rolling_nav_bar/indexed.dart';
// import 'package:rolling_nav_bar/rolling_nav_bar.dart';

import '../../data/sharedpref/shared_preference_helper.dart';
import '../../stores/language/language_store.dart';
import '../../stores/theme/theme_store.dart';
import '../../utils/locale/app_localization.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/incident/incidents_map.dart';
import '../constants/strings.dart';
import '../home/home_screen.dart';
import '../incident/incident_list_screen.dart';

double scaledHeight(BuildContext context, double baseSize) {
  return baseSize * (MediaQuery.of(context).size.height / 800);
}

double scaledWidth(BuildContext context, double baseSize) {
  return baseSize * (MediaQuery.of(context).size.width / 375);
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late LanguageStore _languageStore;
  late ThemeStore _themeStore;

  //Color? logoColor;
  int? activeIndex;

  var iconData = <IconData>[
    Icons.home,
    Icons.list,
    //Icons.location_on,
    Icons.apps_outlined,
    // Icons.person,
  ];

  var badges = <int?>[null, null, null,null];

  var iconText = <Widget>[
    Text(Strings.home, style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text(Strings.myincidents,
        style: TextStyle(color: Colors.grey, fontSize: 12)),
    // Text(Strings.icidentsMap,
    //     style: TextStyle(color: Colors.grey, fontSize: 12)),
    Text(Strings.newIncidents,
        style: TextStyle(color: Colors.grey, fontSize: 12)),
    // Text(Strings.profile, style: TextStyle(color: Colors.grey, fontSize: 12)),
  ];

  var indicatorColors = <Color>[
    Colors.red,
    Colors.orange,
    //Colors.orange,
    Colors.green,
    // Colors.blue,
  ];

  // List<Text?> get badgeWidgets => indexed(badges)
  //     .map((Indexed indexed) => indexed.value != null
  //         ? Text(indexed.value.toString(),
  //             style: TextStyle(
  //               color: indexed.index == activeIndex
  //                   ? indicatorColors[indexed.index]
  //                   : Colors.white,
  //             ))
  //         : null)
  //     .toList();

  @override
  void initState() {
    //logoColor = Colors.red![600];
    activeIndex = 0;
    super.initState();
  }

  void incrementIndex() {
    setState(() {
      activeIndex = activeIndex! < (iconData.length - 1) ? activeIndex! + 1 : 0;
    });
  }

  // ignore: unused_element
  // _onAnimate(AnimationUpdate update) {
  //   setState(() {
  //     //logoColor = update.color;
  //   });
  // }

  _onTap(int index) {
    activeIndex = index;

    print('indexsd: ' + index.toString());
  }

  List<Widget> get builderChildren => const <Widget>[
        Text('1', style: TextStyle(color: Colors.red)),
        Text('2', style: TextStyle(color: Colors.grey)),
        Text('3', style: TextStyle(color: Colors.grey)),
      ];
  final _pageController = PageController();
  SharedPreferenceHelper? sharedPreferenceHelper;

  @override
  void didChangeDependencies() {
    sharedPreferenceHelper = GetIt.instance<SharedPreferenceHelper>();
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName:
                  Text('${sharedPreferenceHelper?.authUser?.user?.fullName}'),
              accountEmail: Column(
                children: [
                  Text('${sharedPreferenceHelper?.authUser?.user?.userName}'),
                  Text(
                      '${sharedPreferenceHelper?.authUser?.user?.roles.toString()}'),
                ],
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/default_user.png'),
                // NetworkImage(
                //     "https://appmaking.co/wp-content/uploads/2021/08/appmaking-logo-colored.png"),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/menu_background.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              otherAccountsPictures: [
                _buildLanguageButton(),
                _buildThemeButton(),
                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   backgroundImage: NetworkImage(
                //       "https://randomuser.me/api/portraits/women/74.jpg"),
                // ),
                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   backgroundImage: NetworkImage(
                //       "https://randomuser.me/api/portraits/men/47.jpg"),
                // ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('${appLocalization.translate('home')}'),
              onTap: () {
                _pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                );
                activeIndex = 0;
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.list_outlined),
              title: Text('${appLocalization.translate('myincidents')}'),
              onTap: () {
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                );
                activeIndex = 1;
                Navigator.of(context).pop();
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.grid_3x3_outlined),
            //   title: Text("Products"),
            //   onTap: () {},
            // ),
            // ListTile(
            //   leading: Icon(Icons.contact_mail),
            //   title: Text("Contact"),
            //   onTap: () {},
            // ),
            Divider(),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('${appLocalization.translate('changePassword')}'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(Routes.changePassword);
              },
            ),
            ListTile(
              leading: Icon(Icons.follow_the_signs_outlined),
              title: Text('${appLocalization.translate('logout')}'),
              onTap: () {
                sharedPreferenceHelper?.removeLoggedInUser();
                Navigator.of(context).pushReplacementNamed(Routes.login);
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomeScreen(),
          IncidentListScreen(hideSubCategoryWidget: false),
          IncidentFormStep1(),
          IncidentsMap(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        //color: CustomColor.primaryColor.value,
        controller: _pageController,
        flat: true,
        useActiveColorByDefault: false,
        items: [
          RollingBottomBarItem(Icons.home,
              label: appLocalization.translate('home'),
              activeColor: CustomColor.primaryColor),
          RollingBottomBarItem(Icons.view_list,
              label: appLocalization.translate('list'),
              activeColor: CustomColor.primaryColor),
          RollingBottomBarItem(Icons.new_label_rounded,
              label: appLocalization.translate('new'),
              activeColor: CustomColor.secondaryColor),
          RollingBottomBarItem(Icons.map,
              label: 'Map', activeColor: Colors.orangeAccent),
        ],
        enableIconRotation: true,
        onTap: (index) {
          _pageController.jumpToPage(
            index,
          );
          activeIndex = index;
        },
      ),
    );
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          color: _themeStore.darkMode ? Colors.black : Colors.white,
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

  Widget _buildLanguageButton() {
    return IconButton(
      color: Colors.white,
      onPressed: () {
        _buildLanguageDialog();
      },
      icon: Icon(
        Icons.language,
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

  goToScreen(int activeIndex) {
    switch (activeIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return IncidentListScreen(); //NearByScreen
      // case 2:
      //   return GoogleMapMarkers();
      case 2:
        return IncidentFormStep1();
      case 3:
        return IncidentsMap();
      // case 3:
      //   return Center(
      //     child: Column(
      //       children: [
      //         Center(child: Text('profile')),
      //
      //         IconButton(
      //
      //             icon: Icon(Icons.logout),
      //             onPressed: () {
      //               authenticationBloc.add(UserLogOut());
      //               Navigator.pushReplacementNamed(context, '/auth_start');
      //             }),
      //       ],
      //     ),
      //   );
      // case 3: return HomeScreenNews();
    }
  }
}
