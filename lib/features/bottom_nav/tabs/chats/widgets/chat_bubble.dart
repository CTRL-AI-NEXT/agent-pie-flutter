import 'package:agent_pie/core/model/ui_model/chat_message_response_model.dart';
import 'package:agent_pie/core/utils/extension.dart';
import 'package:agent_pie/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/basic_features.dart';

class ChatQueryAndResponseTile extends StatelessWidget {
  final DateTime? previousMessageDate;
  final ChatMessageResponseModel chatItem;

  const ChatQueryAndResponseTile(
      {super.key, required this.chatItem, this.previousMessageDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey(chatItem.id),
      children: [
        // Date Label
        if (_shouldShowDateLabel()) _DateLabel(date: chatItem.createdAt),

        // Query
        ChatBubble(
          isUserQuery: true,
          chatItem: chatItem,
        ),

        // Response
        chatItem.message.isNullOrEmpty()
            ? const SizedBox()
            : ChatBubble(
                isUserQuery: false,
                chatItem: chatItem,
              ),
      ],
    );
  }

  bool _shouldShowDateLabel() {
    if (previousMessageDate == null) {
      return true; // Show date label for the first message
    }
    // Show date label if the current message's date is different from the previous one
    return !DateUtils.isSameDay(previousMessageDate, chatItem.createdAt);
  }
}

class _DateLabel extends StatelessWidget {
  final DateTime date;

  const _DateLabel({required this.date});

  @override
  Widget build(BuildContext context) {
    String label;
    final now = DateTime.now();
    if (DateUtils.isSameDay(date, now)) {
      label = AppString.today.tr;
    } else if (DateUtils.isSameDay(
        date, DateTime(now.year, now.month, now.day - 1))) {
      label = AppString.yesterday.tr;
    } else {
      label = AppUtils.formatDateTimeToDayMonthYear(date);
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.h10),
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w10, vertical: Dimensions.h4),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(Dimensions.r10),
      ),
      child: Text(
        label,
        style: fontStyleMedium12.copyWith(
          color: Get.theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessageResponseModel chatItem;
  final bool isUserQuery;

  const ChatBubble({
    super.key,
    required this.isUserQuery,
    required this.chatItem,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserQuery ? Alignment.centerRight : Alignment.centerLeft,
      child: IntrinsicWidth(
        child: Container(
          margin: EdgeInsets.only(
            bottom: Dimensions.h10,
            right: isUserQuery ? 0 : Dimensions.w50,
            left: isUserQuery ? Dimensions.w50 : 0,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w15,
            vertical: Dimensions.w10,
          ),
          decoration: BoxDecoration(
            color: isUserQuery
                ? AppColors.primaryDarkColor
                : Get.theme.colorScheme.textFieldColor,
            borderRadius: BorderRadius.circular(Dimensions.r15),
          ),
          constraints: BoxConstraints(
            maxWidth: Get.width * 0.75,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Message Text
              Text.rich(
                AppUtils.aIFormattedText(
                  isUserQuery ? chatItem.query : chatItem.message,
                ),
                textAlign: TextAlign.start,
                style: fontStyleRegular13.copyWith(
                  color: isUserQuery
                      ? AppColors.whiteColor
                      : Get.theme.colorScheme.textColor,
                ),
              ),

              // Reference Text
              if (chatItem.reference.isNotNullOrEmpty() && !isUserQuery)
                Padding(
                  padding: EdgeInsets.only(top: Dimensions.h10),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w10,
                      vertical: Dimensions.h4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(Dimensions.r10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomAssetImage(
                          image: AppImages.icLink,
                          imageColor: AppColors.whiteColor,
                          size: Dimensions.w12,
                        ),
                        SizedBox(width: Dimensions.w5),
                        Flexible(
                          child: Text(
                            chatItem.reference,
                            style: fontStyleRegular12.copyWith(
                              fontSize: Dimensions.sp10,
                              color: AppColors.whiteColor,
                              fontStyle: FontStyle.italic,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Time Text
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(top: Dimensions.h5),
                  child: Text(
                    AppUtils.formatDateTimeToDayMonthYear(chatItem.createdAt),
                    style: fontStyleMedium10.copyWith(
                      color: isUserQuery
                          ? AppColors.whiteColor.withValues(alpha: 0.8)
                          : Get.theme.colorScheme.textColor
                              .withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
