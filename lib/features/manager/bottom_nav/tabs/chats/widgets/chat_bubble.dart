import 'package:agent_pie/core/model/ui_model/chat_message_response_model.dart';
import 'package:agent_pie/core/utils/extension.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/basic_features.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageResponseModel chatItem;

  const ChatBubble({super.key, required this.chatItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey(chatItem.id),
      children: [
        // Query
        JustAskChatMessageBubble(
          isUserQuery: true,
          message: chatItem.message,
        ),

        // Response
        chatItem.message.isNullOrEmpty()
            ? const SizedBox()
            : JustAskChatMessageBubble(
                isUserQuery: false,
                message: chatItem.message,
              ),
      ],
    );
  }
}

class JustAskChatMessageBubble extends StatelessWidget {
  final String? message;
  final bool isUserQuery;

  const JustAskChatMessageBubble(
      {super.key, required this.message, required this.isUserQuery});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserQuery ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: Dimensions.h10,
          right: isUserQuery ? 0 : Dimensions.w50,
          left: isUserQuery ? Dimensions.w50 : 0,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w15, vertical: Dimensions.w10),
        decoration: BoxDecoration(
            color: isUserQuery
                ? AppColors.primaryColor
                : Get.theme.colorScheme.textFieldColor,
            borderRadius: BorderRadius.circular(Dimensions.r15)),
        child: Text.rich(
          AppUtils.aIFormattedText(message ?? ''),
          textAlign: TextAlign.start,
          style: fontStyleRegular15.copyWith(
              color: isUserQuery
                  ? AppColors.whiteColor
                  : Get.theme.colorScheme.textColor),
        ),
      ),
    );
  }
}

