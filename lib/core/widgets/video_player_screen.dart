import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../basic_features.dart';
import 'custom_image.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;

  const VideoPlayerScreen({super.key, required this.url});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final VideoPlayerController videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    initializePlayer();
    super.initState();
  }

  initializePlayer() async {
    if (widget.url.contains('http')) {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.url));
    } else {
      videoPlayerController = VideoPlayerController.file(
        File(widget.url),
      );
    }

    await videoPlayerController.initialize();
    _chewieController = ChewieController(
      showControls: false,
      fullScreenByDefault: false,
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      autoPlay: true,
      looping: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );

    if (_chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            iconSize: Dimensions.w28,
            icon: CustomSvgAssetImage(
                image: AppImages.icBackArrowNav,
                width: Dimensions.w28,
                height: Dimensions.h28,
                color: Theme.of(context).colorScheme.textColor),
            onPressed: () => Get.back(),
          ),
        ),
        body: _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? Center(
                child: AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: Chewie(
                    controller: _chewieController!,
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: CupertinoActivityIndicator(
                      radius: 10,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: Dimensions.h20),
                  Text(
                    AppString.loading,
                    style: fontStyleSemiBold13.copyWith(
                        color: Get.theme.colorScheme.hintTextColor),
                  )
                ],
              ));
  }
}
