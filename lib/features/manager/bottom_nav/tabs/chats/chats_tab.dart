import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/core/utils/shimmer_screen.dart';
import 'package:agent_pie/core/widgets/custom_image.dart';
import 'package:agent_pie/core/widgets/text_field/text_field/search_bar_text_field.dart';
import 'package:agent_pie/features/bottom_nav/tabs/chats/widgets/chat_bubble.dart';
import 'package:agent_pie/features/bottom_nav/tabs/chats/widgets/chat_empty_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'controller/chats_controller.dart';

class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.chats.tr,
          style: fontStyleSemiBold17,
        ),
        titleSpacing: 0,
        leading: IconButton(
          iconSize: Dimensions.w28,
          icon: CustomSvgAssetImage(
            image: AppImages.icBackArrowNav,
            width: Dimensions.w28,
            height: Dimensions.h28,
            color: Theme.of(context).colorScheme.textColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: GetBuilder<ChatsController>(
        init: ChatsController(),
        autoRemove: false,
        builder: (controller) => SizedBox(
          height: Get.height - kBottomNavigationBarHeight - kToolbarHeight,
          child: Column(
            children: [
              false
                  ?
                  // Full Screen Loading
                  const Expanded(child: ShimmerChattingScreen())
                  : controller.messageList.isNotEmpty
                      ?
                      // Chatting
                      Expanded(
                          child: ListView.builder(
                            itemCount: controller.messageList.length + 1,
                            controller: controller.scrollController,
                            reverse: true,
                            padding: EdgeInsets.only(
                                bottom: Dimensions.h10,
                                left: Dimensions.w5,
                                right: Dimensions.w5),
                            itemBuilder: (context, index) {
                              if (index == controller.messageList.length) {
                                return controller.isPaginating.value
                                    ? const CupertinoActivityIndicator()
                                    : const SizedBox();
                              }

                              return ChatBubble(
                                chatItem: controller.messageList[index],
                              );
                            },
                          ),
                        )
                      :
                      // Empty Chat
                      const ChatEmptyView(),

              // Send Message Bar
              Obx(
                () => Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Dimensions.w20).copyWith(
                    bottom: MediaQuery.viewInsetsOf(context).bottom + Dimensions.h110,
                  ),
                  child: SearchBarTextBoxField(
                    height: Dimensions.h38,
                    minLines: 1,
                    maxLines: 3,
                    isReadOnly: controller.isSendingMessage.value,
                    bgColor: Theme.of(context).colorScheme.textFieldColor,
                    textController: controller.chatTextEditingController,
                    topLeftRadius: Dimensions.r15,
                    topRightRadius: Dimensions.r15,
                    bottomLeftRadius: Dimensions.r15,
                    bottomRightRadius: Dimensions.r15,
                    onChanged: (value) =>
                        controller.showSendIcon.value = value.isNotEmpty,
                    afterClearButton: () {},
                    prefixIcon: const SizedBox(),
                    hintText: AppString.enterYourQuestionHere.tr,
                    hintTextColor: Theme.of(context).colorScheme.hintTextColor,
                    onFieldSubmit: (_) => controller.onJustSearchButton(),
                    suffixIcon: controller.isSendingMessage.value
                        ? const CupertinoActivityIndicator()
                        : CustomSvgAssetImage(
                            onTap: controller.onJustSearchButton,
                            image: controller.showSendIcon.value
                                ? AppImages.icSearch
                                : AppImages.icSearch,
                            height: Dimensions.h25,
                            width: Dimensions.h25,
                            color: Theme.of(context).colorScheme.textColor,
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
