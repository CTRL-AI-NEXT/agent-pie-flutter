import 'dart:ui';

import '../constants/app_string.dart';

class Languages {
  static Map<String, String> english = {
    AppString.appName: "<Your App Name>",
  };

  static Map<String, String> french = {
    AppString.appName: "<Your App Name>",
    AppString.done: "Terminé",
  };

  static Map<String, String> hindi = {
    AppString.appName: "<Your App Name>",
  };

  static const hindiLocale = Locale("hi");
  static const englishLocale = Locale("en");
  static const frenchLocale = Locale("fr");

  static final supportedLocales = [
    englishLocale,
    frenchLocale,
    hindiLocale,
  ];
}
