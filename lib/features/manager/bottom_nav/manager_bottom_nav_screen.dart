import 'package:agent_pie/features/manager/bottom_nav/controller/manager_bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../bottom_nav/widgets/floating_nav_bar.dart';

class ManagerBottomNavScreen extends StatelessWidget {
  const ManagerBottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerBottomNavController>(
      init: ManagerBottomNavController(),
      builder: (controller) =>   PopScope(
          canPop: false,
          onPopInvokedWithResult: controller.onPopInvokedWithResult,
          child: Obx(() => Scaffold(
            extendBody: true,
            body: controller.screens[controller.selectedIndex.value],
            bottomNavigationBar: FloatingBottomNavBar(
              selectedIndex: controller.selectedIndex.value,
              onTap: controller.onDestinationSelected,
              items: controller.destinations,
            ),
          ))),
    );
  }
}
