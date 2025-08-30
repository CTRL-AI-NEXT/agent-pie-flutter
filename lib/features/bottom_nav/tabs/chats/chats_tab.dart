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
    return GetBuilder<ChatsController>(
      init: ChatsController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: CustomSvgAssetImage(
            image: AppImages.icAppIconFull,
            height: Dimensions.h32,
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: controller.messageList.isNotEmpty
                    ?
                    // Chatting
                    ListView.builder(
                        itemCount: controller.messageList.length + 1,
                        controller: controller.scrollController,
                        reverse: true,
                        padding: EdgeInsets.only(
                          bottom: Dimensions.h10,
                          left: Dimensions.w5,
                          right: Dimensions.w5,
                        ),
                        itemBuilder: (context, index) {
                          if (index == controller.messageList.length) {
                            return controller.isPaginating.value
                                ? const CupertinoActivityIndicator()
                                : const SizedBox();
                          }

                          // Determine the date of the next (older) chat item
                          final previousMessageDate =
                              (index + 1 < controller.messageList.length)
                                  ? controller.messageList[index + 1].createdAt
                                  : null;

                          return ChatQueryAndResponseTile(
                            chatItem: controller.messageList[index],
                            previousMessageDate: previousMessageDate,
                          );
                        },
                      )
                    :
                    // Empty Chat or Loading View
                    // Note: The loading state should be handled here to prevent the list from building when empty.
                    (false)
                        ? const ShimmerChattingScreen()
                        : const ChatEmptyView(),
              ),

              // Send Message Bar
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Dimensions.w20).copyWith(
                  bottom: MediaQuery.viewInsetsOf(context).bottom > 0
                      ? MediaQuery.viewInsetsOf(context).bottom
                      : Dimensions.h100,
                ),
                child: SendMessageTextField(
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
                  hintText: AppString.askMeAnything.tr,
                  hintTextColor: Theme.of(context).colorScheme.hintTextColor,
                  onFieldSubmit: (_) => controller.onMessageSend(),
                  suffixIcon: controller.isSendingMessage.value
                      ? const CupertinoActivityIndicator()
                      : IconButton(
                          onPressed: () {},
                          icon: CustomAssetImage(
                            onTap: controller.onMessageSend,
                            image: controller.showSendIcon.value
                                ? AppImages.isSend
                                : AppImages.isSend,
                            height: Dimensions.w18,
                            width: Dimensions.w18,
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
