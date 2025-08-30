import 'dart:io';
import 'dart:math';

import 'package:cropperx/cropperx.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../basic_features.dart';

class ImageCropScreen extends StatefulWidget {
  final String image;
  final double aspectRatio;

  const ImageCropScreen(
      {super.key, required this.image, required this.aspectRatio});

  @override
  State<ImageCropScreen> createState() => _ImageCropScreenState();
}

class _ImageCropScreenState extends State<ImageCropScreen> {
  late String image = widget.image;
  final GlobalKey _cropperKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          Get.back(result: "");
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.blackColor,
        body: Column(
          children: [
            Expanded(
                child: Cropper(
                    cropperKey: _cropperKey,
                    overlayColor: AppColors.blackColor.withValues(alpha: 0.6),
                    backgroundColor: AppColors.blackColor,
                    overlayType: OverlayType.rectangle,
                    aspectRatio: widget.aspectRatio,
                    image: Image.file(
                      File(widget.image),
                      fit: BoxFit.fill,
                    ))),
            SafeArea(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: Dimensions.h25,
                    top: Dimensions.h12,
                    left: Dimensions.commonPaddingForScreen,
                    right: Dimensions.commonPaddingForScreen),
                decoration: BoxDecoration(
                  color: const Color(0xf0161616)
                      .withValues(alpha: 0.9985939860343933),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x29ffffff),
                      offset: Offset(0, -0.5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Cancel
                    InkWell(
                      onTap: () => Get.back(result: ""),
                      child: Text(
                        AppString.cancel,
                        style: fontStyleRegular16.apply(color: Colors.blue),
                      ),
                    ),

                    // Upload New
                    // InkWell(
                    //   onTap: () {
                    //     setState(() {
                    //       selectImageFromSystem();
                    //     });
                    //   },
                    //   // child: CustomTextWidget.regularSFProText(
                    //   //   text: AppString.uploadNew,
                    //   //   fontSize: Dimensions.sp17,
                    //   //   fontWeight: FontWeight.normal,
                    //   //   color: ColorConst.cupertinoBlue,
                    //   // ),
                    //   child: Text(
                    //     "Upload New",
                    //     style: fontStyleRegular16.apply(color: Colors.blue),
                    //   ),
                    // ),

                    // Done
                    InkWell(
                      onTap: () {
                        changeToDisplayImage();
                        EasyLoading.show();
                      },
                      // child: CustomTextWidget.regularSFProText(
                      //   text: AppString.done,
                      //   fontSize: Dimensions.sp17,
                      //   fontWeight: FontWeight.normal,
                      //   color: ColorConst.cupertinoBlue,
                      // ),
                      child: Text(
                        "Done",
                        style: fontStyleRegular16.apply(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // void changeToDisplayImage() async {
  //   final dynamic croppedImageBytes = await Cropper.crop(
  //     cropperKey: _cropperKey,
  //   );
  //
  //   // Saving Cropped Image
  //   final Directory dir = await getApplicationDocumentsDirectory();
  //   final croppedImagePath = "${dir.path}/fHb_${Random().nextInt(100000)}.jpg";
  //   final File croppedImageFile = File(croppedImagePath);
  //   await croppedImageFile.create(recursive: true);
  //   await croppedImageFile.writeAsBytes(croppedImageBytes);
  //
  //   int fileSizeInBytes = croppedImageFile.lengthSync();
  //   double fileSizeInKB = fileSizeInBytes / 1024; // Convert bytes to KB
  //   logger.t("Before Compression: $fileSizeInKB KB");
  //   logger.t("Before Compression Name: ${croppedImageFile.path}");
  //
  //
  //   final compressedImagePath =
  //       await AppUtils.getCompressionImage(croppedImagePath);
  //   final File compressedImageFile = File(compressedImagePath);
  //   await compressedImageFile.create(recursive: true);
  //   await compressedImageFile.writeAsBytes(croppedImageBytes);
  //   logger.t("After Compression Name: ${compressedImageFile.path}");
  //   logger.t(
  //       "After Compression: ${compressedImageFile.lengthSync() / 1024} KB\n\nGap >> ${fileSizeInKB - compressedImageFile.lengthSync() / 1024}");
  //
  //   // Going Back With Cropped Image Path
  //   EasyLoading.dismiss();
  //   Get.back(result: croppedImagePath);
  // }

  void changeToDisplayImage() async {
    final dynamic croppedImageBytes = await Cropper.crop(
      cropperKey: _cropperKey,
    );

    // Saving Cropped Image
    final Directory dir = await getApplicationDocumentsDirectory();
    final croppedImagePath = "${dir.path}/fHb_${Random().nextInt(100000)}.jpg";
    final File croppedImageFile = File(croppedImagePath);
    await croppedImageFile.create(recursive: true);
    await croppedImageFile.writeAsBytes(croppedImageBytes);

    final compressedImagePath =
        await AppUtils.getCompressedImage(croppedImagePath);

    // Going Back With Cropped Image Path
    EasyLoading.dismiss();
    Get.back(result: compressedImagePath);
  }

  // Image Picker
  Future<void> selectImageFromSystem() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      image = (pickedImage.path.toString());
      setState(() {});
    }
  }
}
