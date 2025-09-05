import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/core/widgets/custom_image.dart';
import 'package:agent_pie/core/widgets/text_field/text_field/my_text_field.dart';
import 'package:agent_pie/features/auth/controllers/login_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginScreenController>(
      init: LoginScreenController(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(Dimensions.w16),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.h20,
                    ),
                    const CustomSvgAssetImage(image: AppImages.icAppIconFull),
                    SizedBox(
                        width: Get.width * 0.7,
                        height: Dimensions.h200,
                        child: Lottie.asset('assets/loaders/loader.json')),
                    SizedBox(
                      height: Dimensions.h60,
                    ),
                    // Obx(
                    //     () => CupertinoSlidingSegmentedControl<String>(
                    //       padding: const EdgeInsets.all(8),
                    //       groupValue: controller.selectedLoginMode.value,
                    //       children: {
                    //         "user": const Padding(
                    //           padding: EdgeInsets.symmetric(horizontal: 16.0),
                    //           child: Text("User"),
                    //         ),
                    //         "admin": const Padding(
                    //           padding: EdgeInsets.symmetric(horizontal: 16.0),
                    //           child: Text("Admin"),
                    //         ),
                    //       },
                    //       onValueChanged: (value) {
                    //         if (value != null) {
                    //           controller.selectedLoginMode.value = value;
                    //         }
                    //       },
                    //     )
                    //
                    //   ,
                    // ),
                    SizedBox(height: Dimensions.h16,),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyTextField(
                            textController: controller.emailController,
                            hintText: AutofillHints.email,
                            validator: controller.validateEmail,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: Dimensions.w10),
                              child: const Icon(CupertinoIcons.mail),
                            ),
                          ),
                          SizedBox(height: Dimensions.h16),
                          MyTextField(
                            textController: controller.passwordController,
                            hintText: AutofillHints.password,
                            obscureText: true,
                            validator: controller.validatePassword,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: Dimensions.w10),
                              child: const Icon(CupertinoIcons.lock),
                            ),
                          ),
                          SizedBox(height: Dimensions.h8),
                          Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                  onTap: () {},
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.r4),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.w4),
                                    child: Text(
                                      AppString.forgotPassword,
                                      style: fontStyleRegular12.apply(
                                          decoration: TextDecoration.underline),
                                    ),
                                  ))),
                          SizedBox(height: Dimensions.h16),
                          MyButton(
                            onPressed: controller.callSignInAPI,
                            title: AppString.login,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
