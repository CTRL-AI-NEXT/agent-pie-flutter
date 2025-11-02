import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/core/utils/custom_dialogs.dart';
import 'package:agent_pie/core/utils/enum.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/widgets/custom_appbar.dart';
import 'controllers/upload_tab_controllers.dart';

class UploadTab extends StatefulWidget {
  const UploadTab({super.key});

  @override
  State<UploadTab> createState() => _UploadTabState();
}

class _UploadTabState extends State<UploadTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: bottomNavTabAppBar(false),
      body: GetBuilder(
        init: UploadTabController(),
        autoRemove: false,
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
                InkWell(
                  onTap: controller.uploadPdf,
                  borderRadius: BorderRadius.circular(Dimensions.r12),
                  child: DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                          dashPattern: [10, 5],
                          strokeWidth: 1,
                          padding: EdgeInsets.all(Dimensions.w16)
                              .copyWith(bottom: Dimensions.h24),
                          color: AppColors.dividerColor,
                          radius: Radius.circular(Dimensions.r12)),
                      child: SizedBox(
                        width: Get.width,
                        child: Obx(() {
                          return Column(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                height: controller.lottieSize,
                                width: controller.lottieSize,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 400),
                                  child: Lottie.asset(
                                    controller.lottieAnimation,
                                    // controller: controller.uploadAnimationController,
                                    repeat: true,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Obx(() {
                                final isLoading =
                                    controller.currentStep.value !=
                                        UploadStep.idle;

                                return AnimatedOpacity(
                                  duration: const Duration(seconds: 1),
                                  opacity: isLoading ? 1.0 : 1.0,
                                  // Always visible
                                  child: isLoading
                                      ? FadeTransition(
                                          opacity: controller.fadeAnimation,
                                          // custom fade animation
                                          child: Text(
                                            controller.stepText,
                                            style: fontStyleMedium14,
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      : Text(
                                          AppString.tapToUploadSOP,
                                          style: fontStyleMedium12,
                                          textAlign: TextAlign.center,
                                        ),
                                );
                              })
                            ],
                          );
                        }),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
