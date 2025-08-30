import 'package:agent_pie/core/basic_features.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'controllers/upload_tab_controllers.dart';

class UploadTab extends StatelessWidget {
  const UploadTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: UploadTabController(),
        builder: (controller) => SafeArea(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppString.uploadSop,
                  style: fontStyleMedium18,
                ),
                SizedBox(
                  height: Dimensions.h8,
                ),
                Text(
                  AppString.uploadSopText,
                  style: fontStyleRegular12.apply(color: Colors.grey),
                ),
                SizedBox(
                  height: Dimensions.h24,
                ),
                DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                      dashPattern: [10, 5],
                      strokeWidth: 1,
                      padding: EdgeInsets.all(Dimensions.w16)
                          .copyWith(bottom: Dimensions.h24),
                      color: AppColors.dividerColor,
                      radius: Radius.circular(Dimensions.r12)),
                  child: SizedBox(
                    width: Get.width,
                    child: Column(
                      children: [
                        SizedBox(
                          width: Get.width * 0.4,
                          height: Get.width * 0.4,
                          child: Lottie.asset(
                            controller: controller.uploadAnimationController,
                            repeat: true,
                            AppImages.fileUploadLottie,
                          ),
                        ),

                        SizedBox(
                          width: Get.width * 0.4,
                          child: MyButton(
                            height: Dimensions.h16,
                            textStyle: fontStyleMedium12,
                            cornerRadius: Dimensions.r8,
                            onPressed: controller.uploadPdf,
                            title: AppString.tapToUploadSOP,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
