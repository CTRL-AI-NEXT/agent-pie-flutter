import 'dart:ui';

import 'package:agent_pie/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/basic_features.dart';

class FloatingBottomNavBar extends StatelessWidget {
  final List<FloatingNavItem> items;
  final int selectedIndex;
  final Function(int) onTap;

  const FloatingBottomNavBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FractionallySizedBox(
            widthFactor: 0.80,
            child: Container(
              margin: EdgeInsets.only(bottom: Dimensions.h10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.r30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(13),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.r30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h3),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      // Semi-Transparent glass
                      borderRadius: BorderRadius.circular(Dimensions.r30),
                    ),
                    // Bottom Nav
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(items.length, (index) {
                        final isSelected = selectedIndex == index;
                        final item = items[index];

                        return InkWell(
                          onTap: () => onTap(index),
                          borderRadius: BorderRadius.circular(Dimensions.r100),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 340),
                            padding: EdgeInsets.all(Dimensions.w6),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Glowy background (only when selected)
                                AnimatedScale(
                                  scale: isSelected ? 1.0 : 0.8,
                                  duration: Duration(milliseconds: 260),
                                  child: AnimatedOpacity(
                                    opacity: isSelected ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 300),
                                    child: Container(
                                      width: Dimensions.w45,
                                      height: Dimensions.w45,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            AppColors.primaryColor
                                                .withValues(alpha: 0.04),
                                            AppColors.primaryColor
                                                .withValues(alpha: 0.04),
                                            AppColors.primaryColor
                                                .withValues(alpha: 0.04),
                                            AppColors.primaryColor
                                                .withValues(alpha: 0.02),
                                            AppColors.primaryColor
                                                .withValues(alpha: 0.01),
                                            Colors.transparent,
                                          ],
                                          radius: 0.8,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Actual icon and label
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AnimatedSwitcher(
                                      duration: Duration(milliseconds: 200),
                                      transitionBuilder: (child, animation) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                      child: CustomAssetImage(
                                        key: ValueKey(isSelected),
                                        image: isSelected
                                            ? item.filledSVGIcon
                                            : item.outlinedSVGIcon,
                                        width: Dimensions.w20,
                                        height: Dimensions.w20,
                                        imageColor: !isSelected
                                            ? AppColors.textGreyColor
                                            : null,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.h6),
                                    Text(
                                      item.label,
                                      style: fontStyleBold10.copyWith(
                                        color: isSelected
                                            ? Colors.white54
                                            : AppColors.textGreyColor,
                                        fontWeight: isSelected
                                            ? FontAsset.bold
                                            : FontAsset.regular,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            )
                .animate()
                .slideY(
                  begin: 0.3, // subtle entrance from below
                  end: 0.0,
                  delay: 500.ms,
                  curve: Curves.easeOutBack,
                  duration: const Duration(milliseconds: 900),
                )
                .fadeIn(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                )
                .scaleXY(
                  begin: 0.85,
                  end: 1.0,
                  curve: Curves.easeOutExpo,
                  duration: const Duration(milliseconds: 1100),
                )));
  }
}

class FloatingNavItem {
  final String filledSVGIcon;
  final String outlinedSVGIcon;
  final String label;

  FloatingNavItem({
    required this.filledSVGIcon,
    required this.outlinedSVGIcon,
    required this.label,
  });
}
