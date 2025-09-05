import 'package:agent_pie/core/network/api_helper.dart';
import 'package:agent_pie/core/network/network_constant.dart';
import 'package:agent_pie/core/utils/logger_util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UploadTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController uploadAnimationController;
  final uploadProgress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    uploadAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> uploadPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        // Start animation
        if (!uploadAnimationController.isAnimating) {
          uploadAnimationController.forward();
          uploadAnimationController.repeat();
        }

        await APIHelper.instance.callPostFile(
          NetworkConstant.sops,
          filePath,
          true, // show loader
          queryParameters: {'manager_id': '4'},
          onSendProgress: (sent, total) {
            if (total != -1) {
              uploadProgress.value = sent / total;
              logger.i('Upload progress: ${(uploadProgress.value * 100).toStringAsFixed(0)}%');
            }
          },
        );

        // Stop animation on completion
        uploadAnimationController.reset();
      }
    } else {
      // User canceled the picker
    }
  }

  @override
  void onClose() {
    uploadAnimationController.dispose();
    super.onClose();
  }
}