import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionItem {
  final String title;
  final IconData icon;

  ActionItem({required this.title, required this.icon});
}

class ActionsController extends GetxController {
  final List<ActionItem> actionItems = [
    ActionItem(title: 'Create a new task', icon: Icons.add_task),
    ActionItem(title: 'Upload a document', icon: Icons.cloud_upload_outlined),
    ActionItem(title: 'Scan a QR code', icon: Icons.qr_code_scanner),
    ActionItem(title: 'Set a reminder', icon: Icons.alarm),
    ActionItem(title: 'Start a new chat', icon: Icons.chat_bubble_outline),
    ActionItem(title: 'Check your profile', icon: Icons.person_outline),
    ActionItem(title: 'View statistics', icon: Icons.bar_chart),
    ActionItem(title: 'Settings', icon: Icons.settings_outlined),
  ];
}
