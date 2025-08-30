// @lib/features/manager/bottom_nav/tabs/dashboard/dashboard_tab.dart

import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/core/constants/dimensions.dart';
import 'package:agent_pie/core/utils/style.dart';
import 'package:agent_pie/core/widgets/custom_appbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/dashboard_controller.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) => Scaffold(
        appBar: bottomNavTabAppBar(false),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w15,
            vertical: Dimensions.h15,
          ).copyWith(bottom: Dimensions.h70 * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trainee Training Progress',
                style: fontStyleSemiBold20,
              ),
              SizedBox(height: Dimensions.h20),

              // --- Pie Chart (Donut) ---
              Obx(
                    () => Container(
                  padding: EdgeInsets.all(Dimensions.w20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLightColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(Dimensions.r15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.h150,
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                color: controller.chartColors[0],
                                value: controller.completedTrainingPercentage.value,
                                title: '${controller.completedTrainingPercentage.value.toInt()}%',
                                radius: Dimensions.r60,
                                titleStyle: fontStyleBold16,
                                showTitle: true,
                              ),
                              PieChartSectionData(
                                color: Colors.grey.shade300,
                                value: 100 - controller.completedTrainingPercentage.value,
                                title: '',
                                radius: Dimensions.r60,
                                showTitle: false,
                              ),
                            ],
                            sectionsSpace: 0,
                            centerSpaceRadius: Dimensions.r40,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.h10),
                      Text(
                        'Overall Training Completion',
                        style: fontStyleMedium14,
                      ),
                      _buildLegend('Completed', controller.chartColors[0]),
                      _buildLegend('Remaining', Colors.grey.shade300),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h30),

              // --- Bar Chart ---
              Obx(
                    () => Container(
                  padding: EdgeInsets.all(Dimensions.w20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLightColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(Dimensions.r15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.h200,
                        child: BarChart(
                          BarChartData(
                            barGroups: controller.barChartData.value,
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 100,
                            titlesData: FlTitlesData(
                              leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    final titles = ['Alex', 'Sara', 'Ben', 'Eva'];
                                    return SideTitleWidget(
                                      // axisSide: meta.axisSide,
                                      meta: meta,
                                      child: Text(titles[value.toInt()], style: fontStyleRegular12),
                                    );
                                  },
                                ),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: const FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.h10),
                      Text(
                        'Individual Trainee Progress',
                        style: fontStyleMedium14,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.h30),

              // --- Line Chart ---
              Obx(
                    () => Container(
                  padding: EdgeInsets.all(Dimensions.w20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLightColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(Dimensions.r15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.h200,
                        child: LineChart(
                          LineChartData(
                            lineBarsData: [
                              LineChartBarData(
                                spots: controller.lineChartData.value,
                                isCurved: true,
                                barWidth: Dimensions.w4,
                                color: controller.chartColors[6],
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: controller.chartColors[6].withOpacity(0.3),
                                ),
                              ),
                            ],
                            minY: 0,
                            maxY: 100,
                            titlesData: FlTitlesData(
                              show: true,
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    final titles = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'];
                                    return SideTitleWidget(
                                      // axisSide: meta.axisSide,
                                      meta: meta,
                                      child: Text(titles[value.toInt()], style: fontStyleRegular12),
                                    );
                                  },
                                ),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: Colors.grey.withOpacity(0.2),
                                  strokeWidth: 1,
                                );
                              },
                            ),
                            borderData: FlBorderData(show: false),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.h10),
                      Text(
                        'Average Daily Training Completion',
                        style: fontStyleMedium14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.h4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Dimensions.w15,
            height: Dimensions.h15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          SizedBox(width: Dimensions.w8),
          Text(label, style: fontStyleRegular12),
        ],
      ),
    );
  }
}