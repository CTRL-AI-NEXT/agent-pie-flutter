import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/features/bottom_nav/tabs/actions/actions_tab.dart';
import 'package:agent_pie/features/bottom_nav/tabs/chats/chats_tab.dart';
import 'package:agent_pie/features/bottom_nav/tabs/quiz/quiz_tab.dart';

import '../tabs/profile/profile_tab.dart';
import '../widgets/floating_nav_bar.dart';

class BottomNavController extends GetxController {
  final selectedIndex = 1.obs;

  final screens = [
    ChatsTab(),
    QuizTab(),
    ActionsTab(),
    ProfileTab(),
  ];

  final destinations = <FloatingNavItem>[
    // Community
    FloatingNavItem(
      label: AppString.allowAccess,
      filledSVGIcon: AppImages.icAdmin,
      outlinedSVGIcon: AppImages.icAdmin,
    ),

    // AI Creation
    FloatingNavItem(
      label: AppString.allowAccess,
      filledSVGIcon: AppImages.icAdmin,
      outlinedSVGIcon: AppImages.icAdmin,
    ),

    // Event
    FloatingNavItem(
      label: AppString.allowAccess,
      filledSVGIcon: AppImages.icAdmin,
      outlinedSVGIcon: AppImages.icAdmin,
    ),

    // Profile
    FloatingNavItem(
      label: AppString.allowAccess,
      filledSVGIcon: AppImages.icAdmin,
      outlinedSVGIcon: AppImages.icAdmin,
    ),
  ];

  void onDestinationSelected(int index) => selectedIndex.value = index;

  void onPopInvokedWithResult(bool didPop, dynamic _) {
    if (!didPop) {
      if (selectedIndex.value != 1) {
        selectedIndex.value = 1;
      } else {
        AppUtils.showExitPopScopePopup();
      }
    }
  }
}
