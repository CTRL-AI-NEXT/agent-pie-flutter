import 'package:agent_pie/core/utils/shimmer_effect.dart';
import 'package:flutter/material.dart';
import '../basic_features.dart';


class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final BorderRadiusGeometry? borderRadius;
  final Color? baseColor;
  final bool showTrailing;
  final Color? highlightColor;

  const ShimmerContainer(
      {super.key,
      required this.width,
      required this.height,
      this.borderRadius,
      this.showTrailing = false,
      this.margin = EdgeInsets.zero,
      this.padding = EdgeInsets.zero,
      this.baseColor,
      this.highlightColor});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.shimmerBaseColor,
      highlightColor: highlightColor ?? AppColors.shimmerHighLightColor,
      child: Container(
          margin: margin,
          padding: padding,
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius:
                  borderRadius ?? BorderRadius.circular(Dimensions.r8)),
          child: showTrailing
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      const SizedBox(),
                      Padding(
                          padding: EdgeInsets.only(right: Dimensions.w25),
                          child: CircleAvatar(
                            radius: Dimensions.r15,
                          ))
                    ])
              : const SizedBox()),
    );
  }
}

class ShimmerChatSearchBar extends StatelessWidget {
  const ShimmerChatSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return formUI();
  }

  formUI() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighLightColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
            child: Container(
              height: Dimensions.h33,
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
              decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(Dimensions.r10)),
            ),
          ),
          SizedBox(height: Dimensions.h8),
        ],
      ),
    );
  }
}


class ShimmerChattingScreen extends StatelessWidget {
  const ShimmerChattingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Shimmer.fromColors(
        baseColor: AppColors.shimmerBaseColor,
        highlightColor: AppColors.shimmerHighLightColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
          child: Column(
            children: [
              // Her
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    width: Dimensions.w200,
                    height: Dimensions.h60,
                    margin: EdgeInsets.only(top: Dimensions.h10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.r5),
                          bottomLeft: Radius.circular(Dimensions.r15),
                          topRight: Radius.circular(Dimensions.r15),
                          bottomRight: Radius.circular(Dimensions.r15)),
                    )),
              ),

              // Mine
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: Dimensions.w180,
                  height: Dimensions.h35,
                  margin: EdgeInsets.only(
                      right: Dimensions.w10,
                      bottom: Dimensions.h14,
                      top: Dimensions.h13),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.r15),
                        bottomLeft: Radius.circular(Dimensions.r15),
                        topRight: Radius.circular(Dimensions.r5),
                        bottomRight: Radius.circular(Dimensions.r15)),
                  ),
                ),
              ),

              // Her
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    width: Dimensions.w200,
                    height: Dimensions.h60,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.r5),
                          bottomLeft: Radius.circular(Dimensions.r15),
                          topRight: Radius.circular(Dimensions.r15),
                          bottomRight: Radius.circular(Dimensions.r15)),
                    )),
              ),
              // Her
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    width: Dimensions.w150,
                    height: Dimensions.h35,
                    margin: EdgeInsets.only(top: Dimensions.h5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.r5),
                          bottomLeft: Radius.circular(Dimensions.r15),
                          topRight: Radius.circular(Dimensions.r15),
                          bottomRight: Radius.circular(Dimensions.r15)),
                    )),
              ),

              // Mine
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: Dimensions.w200,
                  height: Dimensions.h60,
                  margin: EdgeInsets.only(
                      right: Dimensions.w10, top: Dimensions.h13),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.r15),
                        bottomLeft: Radius.circular(Dimensions.r15),
                        topRight: Radius.circular(Dimensions.r5),
                        bottomRight: Radius.circular(Dimensions.r15)),
                  ),
                ),
              ),
              // Mine
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: Dimensions.w180,
                  height: Dimensions.h35,
                  margin: EdgeInsets.only(
                      right: Dimensions.w10,
                      bottom: Dimensions.h14,
                      top: Dimensions.h5),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.r15),
                        bottomLeft: Radius.circular(Dimensions.r15),
                        topRight: Radius.circular(Dimensions.r5),
                        bottomRight: Radius.circular(Dimensions.r15)),
                  ),
                ),
              ),

              // Her
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    width: Dimensions.w150,
                    height: Dimensions.h35,
                    margin: EdgeInsets.only(top: Dimensions.h5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.r5),
                          bottomLeft: Radius.circular(Dimensions.r15),
                          topRight: Radius.circular(Dimensions.r15),
                          bottomRight: Radius.circular(Dimensions.r15)),
                    )),
              ),
              // Her
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    width: Dimensions.w200,
                    height: Dimensions.h60,
                    margin: EdgeInsets.only(top: Dimensions.h5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.r5),
                          bottomLeft: Radius.circular(Dimensions.r15),
                          topRight: Radius.circular(Dimensions.r15),
                          bottomRight: Radius.circular(Dimensions.r15)),
                    )),
              ),

              // Mine
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: Dimensions.w180,
                  height: Dimensions.h35,
                  margin: EdgeInsets.only(
                      right: Dimensions.w10, top: Dimensions.h10),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.r15),
                        bottomLeft: Radius.circular(Dimensions.r15),
                        topRight: Radius.circular(Dimensions.r5),
                        bottomRight: Radius.circular(Dimensions.r15)),
                  ),
                ),
              ),
              // Mine
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: Dimensions.w200,
                  height: Dimensions.h35,
                  margin: EdgeInsets.only(
                      right: Dimensions.w10,
                      bottom: Dimensions.h14,
                      top: Dimensions.h5),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.r15),
                        bottomLeft: Radius.circular(Dimensions.r15),
                        topRight: Radius.circular(Dimensions.r5),
                        bottomRight: Radius.circular(Dimensions.r15)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
