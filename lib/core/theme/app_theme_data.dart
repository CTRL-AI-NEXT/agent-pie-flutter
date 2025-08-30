import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';
import '../constants/dimensions.dart';
import '../utils/style.dart';

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: const Color(0xff8C74FB),
    splashColor: AppColors.primaryLightColor.withValues(alpha: 0.2),
    highlightColor: AppColors.primaryLightColor.withValues(alpha: 0.2),
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light, seedColor: AppColors.primaryColor),
    cardColor: const Color(0xfff9f9f9),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    hintColor: AppColors.hintColor,
    canvasColor: AppColors.whiteColor,
    // textTheme: TextTheme(bodyMedium: fontStyleMedium16),
    dialogBackgroundColor: const Color(0x80000000),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      elevation: 0.0,
      color: AppColors.backgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      centerTitle: false,
    ),
    tabBarTheme: TabBarThemeData(
      splashFactory: NoSplash.splashFactory,
      overlayColor:
          WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        // Use the default focused overlay color
        return states.contains(WidgetState.focused) ? null : Colors.transparent;
      }),
    ),
    navigationBarTheme: NavigationBarThemeData(
      iconTheme: WidgetStateProperty.all(const IconThemeData(
        color: Colors.black, // Set the color for your icons here
      )),
      // height: Platform.isIOS ? null : Dimensions.h80,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.textFieldColor,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      indicatorColor: Colors.transparent,
      labelTextStyle:
          WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return fontStyleSemiBold12.apply(
            color: AppColors.backgroundColorDark,
          );
        } else {
          return fontStyleRegular12.copyWith(
            color: AppColors.backgroundColorDark,
          );
        }
      }),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: Dimensions.h3),
        backgroundColor: AppColors.signInModeButtonColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.r10)),
        side:
            const BorderSide(color: AppColors.signInModeButtonColor, width: 0),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(
                AppColors.primaryLightColor.withValues(alpha: 0.2)))),
  );

// static ThemeData darkTheme = ThemeData(
//   useMaterial3: true,
//   dialogBackgroundColor: Colors.white.withValues(alpha: 0.01),
//   primaryColor: const Color(0xff8C74FB),
//   shadowColor: Colors.white38,
//   splashColor: ColorConst.primaryLightColor.withValues(alpha: 0.2),
//   highlightColor: ColorConst.primaryLightColor.withValues(alpha: 0.1),
//   colorScheme: ColorScheme.fromSeed(
//     brightness: Brightness.dark,
//     seedColor: ColorConst.primaryColor,
//   ),
//   canvasColor: ColorConst.backgroundColorDark,
//   scaffoldBackgroundColor: ColorConst.backgroundColorDark,
//   cardColor: const Color(0xff202020),
//   hintColor: ColorConst.hintColor,
//   appBarTheme: const AppBarTheme(
//     surfaceTintColor: Colors.transparent,
//     elevation: 0.0,
//     color: ColorConst.backgroundColorDark,
//     systemOverlayStyle: SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.light),
//     centerTitle: false,
//   ),
//   tabBarTheme: TabBarTheme(
//     splashFactory: NoSplash.splashFactory,
//     overlayColor:
//         WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
//       // Use the default focused overlay color
//       return states.contains(WidgetState.focused) ? null : Colors.transparent;
//     }),
//   ),
//   navigationBarTheme: NavigationBarThemeData(
//     iconTheme: WidgetStateProperty.all(const IconThemeData(
//       color: Colors.white, // Set the color for your icons here
//     )),
//     backgroundColor: ColorConst.backgroundColorDark,
//     surfaceTintColor: ColorConst.backgroundColorDark,
//     labelTextStyle:
//         WidgetStateProperty.resolveWith((Set<WidgetState> states) {
//       if (states.contains(WidgetState.selected)) {
//         return fontStyleSemiBold12.apply(color: ColorConst.whiteColor);
//       } else {
//         return fontStyleRegular12.apply(color: ColorConst.whiteColor);
//       }
//     }),
//   ),
//   outlinedButtonTheme: OutlinedButtonThemeData(
//     style: OutlinedButton.styleFrom(
//       padding: EdgeInsets.symmetric(vertical: Dimensions.h3),
//       backgroundColor: const Color(0xff202020),
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(Dimensions.r10)),
//       side: const BorderSide(color: Colors.transparent, width: 0),
//     ),
//   ),
//   textButtonTheme: TextButtonThemeData(
//       style: ButtonStyle(
//           overlayColor:
//               WidgetStateProperty.all(ColorConst.primaryLightColor))),
// );
}
