import 'package:agent_pie/core/constants/app_colors.dart';
import 'package:agent_pie/features/bottom_nav/tabs/actions/controller/actions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionsTab extends StatelessWidget {
  const ActionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActionsController>(
      init: ActionsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            title: const Text(
              'Quick Actions',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: AppColors.backgroundColorDark,
            elevation: 0,
          ),
          body: ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.actionItems.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
            itemBuilder: (context, index) {
              final item = controller.actionItems[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: AppColors.blackColor,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  leading: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Icon(
                      item.icon,
                      color: AppColors.primaryColor,
                      size: 28.0,
                    ),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                      fontSize: 16.0,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18.0,
                    color: AppColors.textGreyColor,
                  ),
                  onTap: () {
                    // TODO: Implement action
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
