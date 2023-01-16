import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/di/components/service_locator.dart';
import 'package:boilerplate/stores/category/category_store.dart';
import 'package:boilerplate/stores/incident/incident_store.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/login/login.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../data/respository/category_repository.dart';
import '../data/respository/incident_repository.dart';
import '../data/respository/priority_repository.dart';
import '../data/respository/subcategory_repository.dart';
import '../data/respository/user_repository.dart';
import '../stores/incident_form/incident_form_store.dart';
import '../stores/priority/priority_store.dart';
import '../stores/subcategory/subcategory_store.dart';
import 'constants/colors.dart';
import 'home/categories.dart';
import 'splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final PostStore _postStore = PostStore(getIt<Repository>());
  final CategoryStore _categoryStore =
      CategoryStore(getIt<CategoryRepository>());
  final SubCategoryStore _subcategoryStore =
      SubCategoryStore(getIt<SubCategoryRepository>());

  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  final UserStore _userStore = UserStore(getIt<UserRepository>());
  final PriorityStore _priorityStore =
      PriorityStore(getIt<PriorityRepository>());
  final IncidentStore _incidentStore =
      IncidentStore(getIt<IncidentRepository>());
  final IncidentFormStore _incidentFormStore =
      IncidentFormStore(getIt<IncidentRepository>());

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<PostStore>(create: (_) => _postStore),
        Provider<CategoryStore>(create: (_) => _categoryStore),
        Provider<SubCategoryStore>(create: (_) => _subcategoryStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<UserStore>(create: (_) => _userStore),
        Provider<PriorityStore>(create: (_) => _priorityStore),
        Provider<IncidentStore>(create: (_) => _incidentStore),
        Provider<IncidentFormStore>(create: (_) => _incidentFormStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            // theme: _themeStore.darkMode
            //     ? AppThemeData.darkThemeData
            //     : AppThemeData.lightThemeData,
            theme: ThemeData(
                primaryColor: CustomColor.primaryColor,
                fontFamily: 'Montserrat'),
            routes: Routes.routes,
            locale: Locale(_languageStore.locale),
            supportedLocales: _languageStore.supportedLanguages
                .map((language) => Locale(language.locale!, language.code))
                .toList(),
            localizationsDelegates: [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],
            //home: _userStore.isLoggedIn ? CategoryListPage() : LoginScreen(),
            home: SplashScreen2(),
          );
        },
      ),
    );
  }
}
