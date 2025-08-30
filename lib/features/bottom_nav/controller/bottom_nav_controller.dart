import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/core/storage/preference_storage.dart';
import 'package:agent_pie/features/auth/login_screen.dart';
import 'package:agent_pie/features/bottom_nav/tabs/actions/actions_tab.dart';
import 'package:agent_pie/features/bottom_nav/tabs/chats/chats_tab.dart';
import 'package:agent_pie/features/bottom_nav/tabs/quiz/quiz_tab.dart';

import '../tabs/profile/profile_tab.dart';
import '../widgets/floating_nav_bar.dart';

class BottomNavController extends GetxController {
  final selectedIndex = 0.obs;

  final screens = [
    const ChatsTab(),
    const QuizTab(),
    const ActionsTab(),
    const ProfileTab(),
  ];

  final destinations = <FloatingNavItem>[
    // Chats
    FloatingNavItem(
      label: AppString.chats,
      filledIcon: AppImages.icChatsFilled,
      outlinedIcon: AppImages.icChatsUnfilled,
    ),

    // Quiz
    FloatingNavItem(
      label: AppString.quiz,
      filledIcon: AppImages.icQuizFilled,
      outlinedIcon: AppImages.icQuizUnfilled,
    ),

    // Actions
    FloatingNavItem(
      label: AppString.actions,
      filledIcon: AppImages.icActionsFilled,
      outlinedIcon: AppImages.icActionsUnfilled,
    ),

    // Profile
    FloatingNavItem(
      label: AppString.profile,
      filledIcon: AppImages.icProfileFilled,
      outlinedIcon: AppImages.icProfileUnfilled,
    ),
  ];

  final selectedSopTitle = 'SOP 001 v1'.obs;
  final sopTitles = <String>[
    'SOP 001 v1',
    'SOP 002 v1',
    'SOP 003 v1',
    'SOP 004 v1',
    'SOP 005 v1',
  ].obs;

  void onDestinationSelected(int index) {
    selectedIndex.value = index;

    if (index == 3) {
      _signOut();
    }
  }

  void onLongTap(int index) {
    if (index == 3) {
      _signOut();
    }
  }

  Future<void> _signOut() async {
    await PreferenceStorage.clearStorage();
    Get.offAll(const LoginScreen());


    // Show the snackbar after a short delay to ensure navigation is complete.
    Future.delayed(
      const Duration(milliseconds: 500), // Adjust delay as needed
          () => AppUtils.showSnackBar(
        isSuccess: true,
        message: AppString.loggedOutSuccessfully.tr,
      ),
    );
  }

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
