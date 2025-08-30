import 'package:flutter/material.dart';

import '../../core/basic_features.dart';
import '../../core/widgets/custom_appbar.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        // image: DecorationImage(
        //     scale: 3,
        //     image: AssetImage(
        //       ImageAsset.icLogoIconBlack,
        //     ),
        //     alignment: Alignment.bottomRight),
      ),
      child: Scaffold(
        appBar: CustomAppBar.blankAppbar(),
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
          child:
              MyButton(title: AppString.letsGetStarted, onPressed: gotoLogin),
        ),
        body: Padding(
          padding: EdgeInsets.only(
              top: Dimensions.h40,
              left: Dimensions.commonPaddingForScreen,
              right: Dimensions.commonPaddingForScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppString.welcomeBack,
                style: fontStyleBold25,
              ),
              SizedBox(
                height: Dimensions.h15,
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Text(
                  AppString.dummyText1 +
                      AppString.dummyText1 +
                      AppString.dummyText1 +
                      AppString.dummyText1 +
                      AppString.dummyText1 +
                      AppString.dummyText1,
                  style: fontStyleMedium15,
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  gotoLogin() {
    Get.snackbar(
      "Hey there👋",
      "That's it, thanks for visiting Demo Projects ",
    );
  }
}
