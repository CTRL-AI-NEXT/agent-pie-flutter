import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:agent_pie/core/localization/localization.dart';

import '../core/basic_features.dart';
import '../core/localization/languages.dart';
import '../core/storage/preference_storage.dart';
import '../core/theme/app_theme_data.dart';
import 'onboarding/welcome_screen.dart';

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
            darkTheme: AppThemeData.lightTheme,
            theme: AppThemeData.lightTheme,
            defaultTransition: Transition.cupertino,
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            title: AppString.appName,
            home: const WelcomeScreen(),
          ),
        ),
      );
}
