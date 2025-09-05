import 'package:agent_pie/core/model/response_model/login_response_model.dart';
import 'package:agent_pie/features/auth/login_screen.dart';
import 'package:agent_pie/features/bottom_nav/bottom_nav_screen.dart';
import 'package:agent_pie/features/manager/bottom_nav/manager_bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:agent_pie/core/localization/localization.dart';

import '../core/basic_features.dart';
import '../core/localization/languages.dart';
import '../core/storage/preference_storage.dart';
import '../core/theme/app_theme_data.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Brightness brightness = Brightness.light;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // NotificationManager().init();
    // FirebaseNotifications().initialize();

    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    setState(() {
      this.brightness = brightness;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: brightness));
    });
  }

  LoginResponseModel? loginResponseModel =
      PreferenceStorage.getLoginResponseModel();

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (_, widget) => GestureDetector(
          onTap: AppUtils.closeKeyboard,
          child: GetMaterialApp(
            translations: AppLocalization(),
            locale: PreferenceStorage.getAppLocale().isEmpty
                ? Get.deviceLocale
                : Locale(PreferenceStorage.getAppLocale()),
            fallbackLocale: Languages.englishLocale,
            builder: EasyLoading.init(
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              ),
            ),
            darkTheme: AppThemeData.darkTheme,
            defaultTransition: Transition.cupertino,
            themeMode: ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            title: AppString.appName,
            // home: BottomNavScreen(),
            home: loginResponseModel == null
                ? const LoginScreen()
                : loginResponseModel?.isManager ?? false
                    ? const ManagerBottomNavScreen()
                    : const BottomNavScreen(),
          ),
        ),
      );
}
