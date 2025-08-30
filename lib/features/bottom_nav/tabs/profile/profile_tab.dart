import 'package:agent_pie/core/constants/app_colors.dart';
import 'package:agent_pie/core/constants/app_string.dart';
import 'package:agent_pie/core/constants/dimensions.dart';
import 'package:agent_pie/core/utils/style.dart';
import 'package:agent_pie/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'controller/profile_controller.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(),
      builder: (controller) => Scaffold(
        body: SingleChildScrollView(
          padding: Dimensions.commonHorizontalEdgeInsets,
          child: Column(
            // children: [
            //   // Name & Email | Edit Profile
            //   SizedBox(height: Dimensions.h12),
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       // Name & Email
            //       Flexible(
            //         flex: 12,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             // Name
            //             Text(
            //               controller.userName,
            //               style: fontStyleMedium20.copyWith(
            //                   color: AppColors.textColor),
            //             ),
            //
            //             // Email
            //             Text(
            //               controller.userEmail,
            //               maxLines: 1,
            //               overflow: TextOverflow.ellipsis,
            //               style: fontStyleRegular15.copyWith(
            //                   color: AppColors.textGreyColor),
            //             )
            //           ],
            //         ),
            //       ),
            //
            //       // Edit Profile
            //       Flexible(
            //         flex: 7,
            //         child: MyOutLineButton(
            //           height: Dimensions.h35,
            //           borderWidth: 1.2.w,
            //           title: AppString.editProfile,
            //           textStyle: fontStyleMedium15.copyWith(
            //               color: AppColors.textColor),
            //           onPressed: (){},
            //         ),
            //       )
            //     ],
            //   ),
            //   SizedBox(height: Dimensions.h12),
            //
            //   // Setting List Tiles
            //   ListView.builder(
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: controller.settingList.length,
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) => SettingListTile(
            //         key: ValueKey(controller.settingList[index].title),
            //         settingTileModel: controller.settingList[index]),
            //   ),
            //
            //   // Logout & Delete Account Button
            //   TextButton(
            //     onPressed: controller.authController.showLogoutDialog,
            //     style: ButtonStyle(
            //       padding: WidgetStateProperty.all(EdgeInsets.only(
            //           right: Dimensions.w10,
            //           top: Dimensions.h6,
            //           bottom: Dimensions.h6)),
            //       overlayColor: WidgetStateProperty.resolveWith(
            //             (states) {
            //           if (states.contains(WidgetState.pressed)) {
            //             return AppColors.logoutRedColor.withValues(alpha: 0.1);
            //           }
            //           return Colors.transparent;
            //         },
            //       ),
            //     ),
            //     child: Text(
            //       AppString.logout.tr,
            //       textAlign: TextAlign.center,
            //       style: fontStyleMedium17.apply(
            //           color: AppColors.logoutRedColor,
            //           decorationColor: AppColors.logoutRedColor,
            //           decoration: TextDecoration.underline),
            //     ),
            //   ),
            //
            //   // Advanced Settings
            //   TextButton(
            //     onPressed: (){},
            //     child: Text(
            //       AppString.advancedSettings,
            //       style: fontStyleRegular13.copyWith(
            //           color: AppColors.textGreyColor,
            //           decoration: TextDecoration.underline),
            //     ),
            //   ), //
            //   SizedBox(height: Dimensions.h10),
            //
            //   // Version Info
            //   Text(
            //     "${AppString.version.tr} 1.0.2",
            //     style:
            //     fontStyleRegular13.copyWith(color: AppColors.textGreyColor),
            //   ),
            // ],
          ),
        ),
      ),
    );
  }
}
