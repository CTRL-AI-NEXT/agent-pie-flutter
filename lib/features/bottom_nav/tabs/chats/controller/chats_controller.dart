import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/core/model/ui_model/chat_message_response_model.dart';
import 'package:agent_pie/features/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:flutter/cupertino.dart';

class ChatsController extends GetxController {
  final bottomNavController = Get.find<BottomNavController>();

  final messageList = <ChatMessageResponseModel>[
    ChatMessageResponseModel(
      id: '4',
      reference: 'User Manual v2.1',
      createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
      query: 'How do I reset my password?',
      message:
      'To reset your password, please follow these steps:\n\n1. Go to the login page.\n2. Click on the "Forgot Password?" link.\n3. Enter your registered email address.\n4. Follow the instructions sent to your email to create a new password.\n\nFor more details, you can consult page 12 of the User Manual v2.1.',
    ),
    ChatMessageResponseModel(
      id: '1',
      reference: 'SOP 001 v1',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      query: 'Hey, can you help me getting better at making tea better?',
      message:
      'Definitely! Here are some tips to make better tea:\n\n1. Use fresh, cold water.\n2. Preheat your teapot or cup.\n3. Measure your tea leaves.\n4. Pay attention to water temperature.\n5. Steep for the right amount of time.\n6. Experiment with different teas and blends.\n7. Enjoy your tea mindfully!',
    ),
    ChatMessageResponseModel(
      id: '2',
      reference: 'Product Info XZ v3',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      query: 'What are the key features of the new XZ model?',
      message:
      'The new XZ model boasts several key features:\n\n- Advanced AI-powered noise cancellation.\n- Extended battery life, up to 30 hours.\n- Lightweight and ergonomic design.\n- Seamless Bluetooth 5.2 connectivity.\n- Customizable EQ settings via our app.',
    ),
    ChatMessageResponseModel(
      id: '5',
      reference: 'FAQ - Shipping',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      query: 'What are your international shipping rates?',
      message:
      'Our international shipping rates vary depending on the destination and the weight of the package. \n\n- Standard International Shipping: Starts at \$15 USD.\n- Express International Shipping: Starts at \$30 USD.\n\nYou can get an exact quote during the checkout process by entering your shipping address. Please also check our FAQ on shipping for more details on customs and delivery times.',
    ),
    ChatMessageResponseModel(
      id: '3',
      reference: 'Troubleshooting Guide ABC',
      createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
      query: 'My device is not turning on, what should I do?',
      message:
      "I'm sorry to hear you're having trouble. Let's try a few things:\n\n1. Ensure the device is adequately charged. Try plugging it in for at least 30 minutes.\n2. Press and hold the power button for 10-15 seconds for a hard reset.\n3. Check the charging port for any debris or damage.\n4. If the issue persists, please refer to section 3.2 of the Troubleshooting Guide ABC or contact customer support.",
    ),
  ].obs;
  final scrollController = ScrollController();
  final isPaginating = false.obs;
  final isSendingMessage = false.obs;
  final isLoading = false.obs;
  final focusNode = FocusNode();
  final isKeyboardVisible = false.obs;

  final chatTextEditingController = TextEditingController();
  final showSendIcon = false.obs;

  @override
  void onInit() {
    // sort messageList on basis of createdAt
    messageList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    focusNode.addListener(() {
      isKeyboardVisible.value = focusNode.hasFocus;
    });
    super.onInit();
  }

  @override
  void onClose() {
    messageList.close();
    isPaginating.close();
    scrollController.dispose();
    super.onClose();
  }

  void onMessageSend() {
    if (chatTextEditingController.text.isEmpty) return;
    AppUtils.closeKeyboard();

    final newMessage = ChatMessageResponseModel(
      id: DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),
      reference: 'Ad-hoc Query',
      createdAt: DateTime.now(),
      query: chatTextEditingController.text,
      message:
      'This is a simulated response for the query: "${chatTextEditingController
          .text}". In a real application, this would be replaced with an actual response from the backend or AI service.',
    );

    messageList.insert(0, newMessage);
    chatTextEditingController.clear();
    showSendIcon.value = false;

    // Scroll to the bottom to show the new message
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
