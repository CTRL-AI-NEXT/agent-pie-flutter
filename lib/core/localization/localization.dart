import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../storage/preference_storage.dart';
import 'languages.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        Languages.englishLocale.languageCode: Languages.english,
        Languages.frenchLocale.languageCode: Languages.french,
        Languages.hindiLocale.languageCode: Languages.hindi,
      };

  void changeLocale({required Locale newLocale}) {
    Get.updateLocale(newLocale);
    PreferenceStorage.setAppLocale(newLocale.languageCode);
  }
}
