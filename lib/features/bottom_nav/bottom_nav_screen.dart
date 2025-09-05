import 'package:agent_pie/features/bottom_nav/widgets/floating_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'controller/bottom_nav_controller.dart';

export 'package:get/get.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (controller) => PopScope(
          canPop: false,
          onPopInvokedWithResult: controller.onPopInvokedWithResult,
          child: Obx(() => Scaffold(
                extendBody: true,
                body: controller.screens[controller.selectedIndex.value],
                bottomNavigationBar: FloatingBottomNavBar(
                  selectedIndex: controller.selectedIndex.value,
                  onTap: controller.onDestinationSelected,
                  items: controller.destinations,
                  onLongPress: controller.onLongTap,
                ),
              ))),
    );
  }
}
