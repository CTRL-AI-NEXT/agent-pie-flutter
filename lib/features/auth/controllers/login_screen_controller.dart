import 'package:agent_pie/features/bottom_nav/bottom_nav_screen.dart';
import 'package:agent_pie/features/manager/bottom_nav/manager_bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final RxString selectedLoginMode = "user".obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void login() {
    if (formKey.currentState!.validate()) {
      // Perform login logic here
      if (selectedLoginMode.value == "user") {
        Get.offAll(() => const BottomNavScreen());
      }else {
        Get.offAll(() => const ManagerBottomNavScreen());
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
