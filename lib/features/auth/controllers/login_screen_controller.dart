import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/core/model/response_model/login_response_model.dart';
import 'package:agent_pie/core/utils/enum.dart';
import 'package:agent_pie/features/auth/login_screen.dart';
import 'package:agent_pie/features/bottom_nav/bottom_nav_screen.dart';
import 'package:agent_pie/features/manager/bottom_nav/manager_bottom_nav_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/network/api_helper.dart';
import '../../../core/network/api_response_handler.dart';
import '../../../core/network/api_result.dart';
import '../../../core/network/network_constant.dart';
import '../../../core/storage/preference_storage.dart';

class LoginScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final RxString selectedLoginMode = "user".obs;
  final emailController = TextEditingController(text: 'john@mail.com');
  final passwordController = TextEditingController(text: '12345678');
  final loginAPIResult = Rx(APIResult<LoginResponseModel?>.loading());

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

// Your login method
  void login() {
    if (formKey.currentState!.validate()) {
      // Perform login logic here
      if (selectedLoginMode.value == "user") {
        Get.offAll(() => const BottomNavScreen());
      } else {
        Get.offAll(() => const ManagerBottomNavScreen());
      }

      // Show the snackbar after a short delay to ensure navigation is complete.
      Future.delayed(
        const Duration(milliseconds: 500), // Adjust delay as needed
        () => AppUtils.showSnackBar(
          isSuccess: true,
          message: AppString.loggedInSuccessfully.tr,
        ),
      );
    }
  }

  // Making Sign In API CAll
  Future<void> callSignInAPI({
    String? email,
    String? password,
  }) async {
    AppUtils.closeKeyboard();
    loginAPIResult.value = APIResult<LoginResponseModel>.loading();
    final Map<String, String> signInRequest = {
      'email': email ?? emailController.text,
      'password': password ?? passwordController.text,
    };

    var networkResult = await APIHelper.instance.callPostApi(
      NetworkConstant.login,
      signInRequest,
      true,
    );

    var apiResultFromNetwork =
        getAPIResultFromNetworkWithoutBase<LoginResponseModel?>(
            networkResult, (e) => LoginResponseModel.fromJson(e));

    loginAPIResult.value = apiResultFromNetwork;

    if (loginAPIResult.value.apiResultType == APIResultType.success) {
      // logger.i(loginAPIResult.value.result);
      await PreferenceStorage.putObject(
          AppString.loginResponseModelKey, loginAPIResult.value.result!);
      if (loginAPIResult.value.result?.isManager ?? false) {
        Get.offAll(
          () => const ManagerBottomNavScreen(),
        );
      } else {
        Get.offAll(
          () => const BottomNavScreen(),
        );
      }
    }
    if (loginAPIResult.value.apiResultType != APIResultType.success) {
      AppUtils.showSnackBar(
          message: loginAPIResult.value.message ?? '', isSuccess: false);
    }
  }

  // Call Sign Out API
  Future<void> callSignOutAPI() async {
    // Clear All Data
    // await PurchaseManager.instance.logOut();
    await PreferenceStorage.clearStorage();
    Get.offAll(const LoginScreen());
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
