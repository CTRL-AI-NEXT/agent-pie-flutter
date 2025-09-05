import 'package:agent_pie/core/environment_setup/environment.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'core/utils/app_loader.dart';
import 'core/utils/app_utils.dart';
import 'features/my_app.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializingInitials();
  Future.delayed(
      const Duration(milliseconds: 500), () => runApp(const MyApp()));
}

Future<void> initializingInitials() async {
  await Loader.instance.init();
  await GetStorage.init();
  await Environment().initConfig(Environment.development);
  // await Firebase.initializeApp();
  // await AppUtils.config();
  // startTrackingCrashes();
  orientations();
}
