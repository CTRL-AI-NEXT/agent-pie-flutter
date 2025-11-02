import 'package:agent_pie/features/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:flutter/material.dart';

class SOPBottomSheetView extends StatelessWidget {
  final BottomNavController controller;
  const SOPBottomSheetView({
    super.key, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.sopTitles.length,
      itemBuilder: (context, index) {
        final sop = controller.sopTitles[index];
        return CheckboxListTile(
          title: Text(sop.filename ?? ""),
          value: controller.selectedSopTitle.value == sop,
          onChanged: (value) {
            if (value == true) {
              controller.selectedSopTitle.value = sop;
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }
}
