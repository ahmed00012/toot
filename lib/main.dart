import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/presentation/screens/splash_screen.dart';

import 'cubits/auth_cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
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
    return BlocProvider<AuthCubit>(
      create: (BuildContext context) => AuthCubit(),
      child: ScreenUtilInit(
        designSize: Size(411, 683),
        builder: () => MaterialApp(
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
