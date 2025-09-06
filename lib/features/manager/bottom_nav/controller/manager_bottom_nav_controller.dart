import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/core/utils/logger_util.dart';
import 'package:agent_pie/features/bottom_nav/tabs/profile/profile_tab.dart';
import 'package:agent_pie/features/manager/bottom_nav/tabs/dashboard/dashboard_tab.dart';
import 'package:agent_pie/features/manager/bottom_nav/tabs/upload/upload_tab.dart';
import '../../../../core/storage/preference_storage.dart';
import '../../../auth/login_screen.dart';
import '../../../bottom_nav/widgets/floating_nav_bar.dart';
class ManagerBottomNavController extends GetxController {
  final selectedIndex = 0.obs;

  final screens = [
    const DashboardTab(),
    const UploadTab(),
    const ProfileTab()
  ];

  final destinations = <FloatingNavItem>[
    // Quiz
    FloatingNavItem(
      label: AppString.dashboard,
      filledIcon: AppImages.icDashboardFilled,
      outlinedIcon: AppImages.icDashboard,
    ),

    // Actions
    FloatingNavItem(
      label: AppString.upload,
      filledIcon: AppImages.icUploadFilled,
      outlinedIcon: AppImages.icUpload,
    ),

    // Profile
    FloatingNavItem(
      label: AppString.profile,
      filledIcon: AppImages.icProfileFilled,
      outlinedIcon: AppImages.icProfileUnfilled,
    ),
  ];


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

  void onDestinationSelected(int index) {
    selectedIndex.value = index;
    if (index == 2) {
      _signOut();
    }
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
