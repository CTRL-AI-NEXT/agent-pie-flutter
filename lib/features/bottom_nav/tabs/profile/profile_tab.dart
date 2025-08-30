import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/features/auth/controllers/login_screen_controller.dart';
import 'package:flutter/material.dart';

import '../../../../core/storage/preference_storage.dart';
import '../../../auth/login_screen.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyButton(
              onPressed: () async {
                await PreferenceStorage.clearStorage();
                Get.offAll(const LoginScreen());
              },
              title: AppString.login,
            )
          ],
        ),
      ),
    );
  }
}
