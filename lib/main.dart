

import 'package:bloc/bloc.dart';
import 'package:bmw/style/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'components/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'layout/cubit/cubit.dart';
import 'layout/shopLayout.dart';
import 'modules/login/shop_login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');
   bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
   token = CacheHelper.getData(key: 'token')??'';


  Widget widget;
  if (onBoarding != null) {
    if (token.isNotEmpty) {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }


  runApp(MyApp(
    isDark: isDark ?? false,
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget widget;

  const MyApp({super.key, required this.isDark, required this.widget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getUserData()),

      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            themeMode:
                // isDark ? ThemeMode.dark :
                ThemeMode.light,
            darkTheme: darkTheme,
            home: widget,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
