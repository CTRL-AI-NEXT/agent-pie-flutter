import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/features/bottom_nav/tabs/profile/profile_tab.dart';
import '../tabs/dashboard/dashboard_tab.dart';
import '../tabs/upload/upload_tab.dart';
import '../widgets/floating_nav_bar.dart';

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
