import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/core/model/ui_model/chat_message_response_model.dart';
import 'package:flutter/cupertino.dart';

class ChatsController extends GetxController {
  final messageList = <ChatMessageResponseModel>[].obs;
  final scrollController = ScrollController();
  final isPaginating = false.obs;
  final isSendingMessage = false.obs;

  final chatTextEditingController = TextEditingController();
  final showSendIcon = false.obs;

  @override
  void onClose() {
    messageList.close();
    isPaginating.close();
    scrollController.dispose();
    super.onClose();
  }

  onJustSearchButton() {}
}
