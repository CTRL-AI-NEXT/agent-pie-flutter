import 'package:agent_pie/core/basic_features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuizOptionWidget extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final VoidCallback onTap;

  const QuizOptionWidget({
    super.key,
    required this.optionText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected
            ? AppColors.primaryColor.withValues(alpha:  0.5)
            : Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.r25),
          side: BorderSide(
            color: isSelected
                ? AppColors.primaryColor
                : Colors.grey.shade300,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Dimensions.h15, horizontal: Dimensions.w20),
          child: Text(
            optionText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ),
      ),
    ).animate().fade(duration: 500.ms).slideY(begin: 0.5, end: 0);
  }
}
