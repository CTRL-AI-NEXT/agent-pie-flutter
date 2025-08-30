// @lib/features/manager/bottom_nav/tabs/dashboard/dashboard_controller.dart

import 'package:agent_pie/core/constants/dimensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Use Rx variables to make the data reactive
  var completedTrainingPercentage = 75.0.obs;
  var overallTrainingText = ''.obs;

  final barChartData = <BarChartGroupData>[].obs;
  final lineChartData = <FlSpot>[].obs;

  final List<Color> chartColors = [
    const Color(0xFF6B8A9D), // Slate Blue
    const Color(0xFF71C5A6), // Muted Green
    const Color(0xFF81B0D8), // Calm Blue
    const Color(0xFFA6E3CC), // Pale Green
    const Color(0xFF94A5B7), // Blue-Gray
    const Color(0xFFBED2E5), // Powder Blue
    const Color(0xFF667A85), // Dark Teal-Gray
    const Color(0xFF5A7584), // Steel Blue
  ];

  @override
  void onInit() {
    super.onInit();
    // Generate initial data for the charts
    _generateChartData();
  }

  void _generateChartData() {
    // Pie Chart Data Logic
    overallTrainingText.value = 'Overall Training Completion: ${completedTrainingPercentage.value}%';

    // Bar Chart Data Logic (Individual Trainee Progress)
    final traineeData = [
      {'name': 'Alex', 'progress': 85.00},
      {'name': 'Sara', 'progress': 60.00},
      {'name': 'Ben', 'progress': 95.00},
      {'name': 'Eva', 'progress': 70.00},
    ];

    barChartData.value = traineeData.asMap().entries.map((entry) {
      int index = entry.key;
      double progress = (entry.value['progress']) as double;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: progress,
            color: chartColors[index % chartColors.length],
            width: Dimensions.w20,
            borderRadius: BorderRadius.circular(Dimensions.r4),
          ),
        ],
      );
    }).toList();

    // Line Chart Data Logic (Daily progress over 7 days)
    final dailyProgress = [55, 60, 65, 68, 70, 72, 75];
    lineChartData.value = dailyProgress.asMap().entries.map((entry) {
      int index = entry.key;
      double progress = entry.value.toDouble();
      return FlSpot(index.toDouble(), progress);
    }).toList();
  }
}