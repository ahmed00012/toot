import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/cubits/favorites_cubit/favorites_cubit.dart';
import 'package:toot/cubits/product_cubit/product_cubit.dart';
import 'package:toot/presentation/screens/splash_screen.dart';

import 'cubits/auth_cubit/auth_cubit.dart';
import 'cubits/bloc_observer.dart';
import 'cubits/cart_cubit/cart_cubit.dart';
import 'data/local_storage.dart';
import 'data/web_services/cart_web_service.dart';
import 'data/web_services/favorites_web_service.dart';
import 'data/web_services/product_web_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LocalStorage.init();
  await ProductWebServices.init();
  await FavoritesWebServices.init();
  await CartWebServices.init();
  Bloc.observer = MyBlocObserver();
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [
      Locale('ar'),
      Locale('en')
    ], //must be in this arrangement
    path: "assets/lang",
    startLocale: Locale('ar'),
    saveLocale: true,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ScreenUtilInit(
      designSize: Size(411, 683),
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(),
          ),
          BlocProvider<ProductCubit>(
            create: (BuildContext context) => ProductCubit(),
          ),
          BlocProvider<FavoritesCubit>(
            create: (BuildContext context) => FavoritesCubit(),
          ),
          BlocProvider<CartCubit>(
            create: (BuildContext context) => CartCubit(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Toot',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.indigo,
              canvasColor: Colors.grey.shade50,
              fontFamily: 'Tajawal'),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
