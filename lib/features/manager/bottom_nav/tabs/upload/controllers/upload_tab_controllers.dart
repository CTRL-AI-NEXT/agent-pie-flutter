import 'package:agent_pie/core/basic_features.dart';
import 'package:agent_pie/core/model/response_model/training_response_model.dart';
import 'package:agent_pie/core/model/response_model/upload_sop_response_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../core/network/api_helper.dart';
import '../../../../../../core/network/api_response_handler.dart';
import '../../../../../../core/network/network_constant.dart';
import '../../../../../../core/storage/preference_storage.dart';
import '../../../../../../core/utils/custom_dialogs.dart';
import '../../../../../../core/utils/enum.dart';
import '../../../../../../core/utils/logger_util.dart';

class UploadTabController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController uploadAnimationController;
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;
  final uploadProgress = 0.0.obs;
  var currentStep = UploadStep.idle.obs;

  // You can manage lottie size with this
  double get lottieSize {
    return currentStep.value == UploadStep.idle ? Dimensions.w200 : Dimensions.w300;
  }

  String get lottieAnimation {
    return currentStep.value == UploadStep.idle ? AppImages.fileUploadLottie : AppImages.loaderLottie;
  }

  String get stepText {
    switch (currentStep.value) {
      case UploadStep.uploadingPDF:
        return AppString.uploadingPDF;
      case UploadStep.generatingQuiz:
        return AppString.generatingQuiz;
      case UploadStep.generatingTraining:
        return AppString.generatingTraining;
      case UploadStep.completed:
        return "All done! 🎉";
      default:
        return AppString.tapToUploadSOP;
    }
  }

  @override
  void onInit() {
    super.onInit();
    uploadAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    fadeAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: fadeController, curve: Curves.easeInOut),
    );
  }

  void startLoading(String text) {
    currentStep.value != UploadStep.idle;
    fadeController.repeat(reverse: true);
  }

  void stopLoading() {
    currentStep.value = UploadStep.idle;
    fadeController.stop();
  }

  Future<void> uploadPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    final filePath = result?.files.single.path;
    if (filePath == null) return; // nothing selected

    try {
      // Start animation
      if (!uploadAnimationController.isAnimating) {
        uploadAnimationController.repeat();
      }

      currentStep.value = UploadStep.uploadingPDF;
      final managerID = PreferenceStorage.getLoginResponseModel()?.id.toString() ?? "";

      // Upload SOP
      final sopResponse = await _uploadSop(filePath, managerID);
      if (sopResponse == null) return;

      // Generate Training
      currentStep.value = UploadStep.generatingTraining;
      final trainingResponse = await _generateTraining(sopResponse.id.toString());
      if (trainingResponse == null) return;

      // Generate Quiz
      currentStep.value = UploadStep.generatingQuiz;
      await _generateQuiz(trainingResponse.id.toString());
    } catch (e, s) {
      logger.e("Upload failed $e, $s");
      // optionally show snackbar
    } finally {
      // Reset state and animation
      currentStep.value = UploadStep.idle;
      await Future.delayed(const Duration(seconds: 2));
      uploadAnimationController.reset();
    }
  }

// --- helpers ---

  Future<UploadSopResponseModel?> _uploadSop(String filePath, String managerID) async {
    final result = await APIHelper.instance.callPostFile(
      NetworkConstant.sops,
      filePath,
      false,
      queryParameters: {'manager_id': managerID},
      onSendProgress: (sent, total) {
        if (total != -1) {
          uploadProgress.value = sent / total;
          logger.i("Upload progress: ${(uploadProgress.value * 100).toStringAsFixed(0)}%");
        }
      },
    );

    final apiResult = getAPIResultFromNetworkWithoutBase<UploadSopResponseModel?>(
      result,
          (e) => UploadSopResponseModel.fromJson(e),
    );

    return apiResult.apiResultType == APIResultType.success ? apiResult.result : null;
  }

  Future<TrainingResponseModel?> _generateTraining(String sopID) async {
    final result = await APIHelper.instance.callPostApi(
      "${NetworkConstant.training}/$sopID/${NetworkConstant.generate}",
      null,
      false,
    );

    final apiResult = getAPIResultFromNetworkWithoutBase<TrainingResponseModel?>(
      result,
          (e) => TrainingResponseModel.fromJson(e),
    );

    return apiResult.apiResultType == APIResultType.success ? apiResult.result : null;
  }

  Future<void> _generateQuiz(String trainingID) async {
    final result = await APIHelper.instance.callPostApi(
      "${NetworkConstant.quizzes}/$trainingID/${NetworkConstant.generate}",
      null,
      false,
    );

    if (result.networkResultType == NetworkResultType.success){
      CustomDialogs.showCustomDialog(
          myWidget: Column(
            children: [
              Lottie.asset(AppImages.successCheckLottie,
                  height: Get.width * 0.4,
                  width: Get.width * 0.4,
                  repeat: false
              ),
              SizedBox(
                height: Dimensions.h10,
              ),
              Text(
                "🎉  Congrats! Your SOP has been successfully uploaded and processed by AI. Training and quizzes are now being prepared so your team can easily access and learn from it.",
                style: fontStyleMedium14,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Dimensions.h20,),

              MyButton(
                  title: "  <-  Go back",
                  textStyle: fontStyleMedium12.apply(color: Colors.black),
                  onPressed: () => Get.back())
            ],
          ));
    }
  }


  @override
  void onClose() {
    uploadAnimationController.dispose();
    super.onClose();
  }
}