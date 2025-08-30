import 'package:flutter/material.dart';

import '../../../../../../core/basic_features.dart';
import '../../../../../../core/widgets/custom_image.dart';

class ChatEmptyView extends StatelessWidget {
  const ChatEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        const Spacer(),

        // Bulb Icon
        CustomSvgAssetImage(
            image: AppImages.icQuizFilled),

        // Title
        Text(
          AppString.itsQuietHere.tr,
          style: fontStyleBold18.apply(color: Get.theme.colorScheme.textColor),
          textAlign: TextAlign.center,
        ),

        // Subtitle
        Text(
          AppString.sayHiToBeginChatting.tr,
          style:
              fontStyleRegular12.apply(color: Get.theme.colorScheme.textColor),
          textAlign: TextAlign.center,
        ),

        const Spacer(),
      ],
    ));
  }
}
