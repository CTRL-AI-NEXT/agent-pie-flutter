import 'package:flutter/material.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';

import '../basic_features.dart';
import '../network/network_constant.dart';
import '../utils/logger_util.dart';
import '../widgets/custom_image.dart';

class GooglePlacesTextField extends StatelessWidget {
  final String? title;
  final String hintText;
  final String prefixIcon;
  final Color? prefixIconColor;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Function(Prediction prediction) onPlaceTap;
  final int? maxLine;
  final bool? isEnabled;
  final double? iconBottomPadding;
  final EdgeInsets? padding;

  const GooglePlacesTextField(
      {super.key,
      this.title,
      required this.hintText,
      required this.prefixIcon,
      required this.controller,
      this.onChanged,
      this.textInputType,
      this.textInputAction,
      this.maxLine,
      this.isEnabled,
      this.iconBottomPadding,
      this.padding,
      required this.onPlaceTap,
      this.prefixIconColor});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Title Text
      if (title != null)
        Container(
          padding: EdgeInsets.only(left: Dimensions.h10),
          alignment: Alignment.centerLeft,
          child: Text(title!,
              textAlign: TextAlign.center,
              style: fontStyleSemiBold15.apply(
                  color: Theme.of(context).colorScheme.textColor)),
        ),

      if (title != null)
        SizedBox(
          height: Dimensions.h3,
        ),

      Container(
        height: Dimensions.h40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.r10),
          color: Theme.of(context).colorScheme.textFieldColor,
        ),
        child: Center(
          child: GooglePlacesAutoCompleteTextFormField(
            textEditingController: controller,
            textInputAction: textInputAction ?? TextInputAction.next,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              // labelText: widget.showLabelText ? widget.hintText : null,
              hintStyle: fontStyleRegular14.apply(
                color: Get.theme.colorScheme.hintTextColor,
              ),
              isDense: true,
              prefixIconConstraints:
                  const BoxConstraints(minHeight: 0, minWidth: 0),
              suffixIconConstraints:
                  const BoxConstraints(minHeight: 0, minWidth: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              fillColor: Colors.transparent,
              filled: true,
              hintText: hintText,
              contentPadding: EdgeInsets.only(right: Dimensions.w10),
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  left: Dimensions.w6,
                  right: Dimensions.w8,
                ),
                child: CustomSvgAssetImage(
                  image: prefixIcon,
                  width: Dimensions.w25,
                  color: prefixIconColor ??
                      Theme.of(context).colorScheme.textColor,
                ),
              ),
            ),
            googleAPIKey: NetworkConstant.googleAPIKey,
            debounceTime: 400,
            // countries: ["de"], // optional, by default the list is empty (no restrictions)
            fetchCoordinates: true,
            onPlaceDetailsWithCoordinatesReceived: (prediction) {
              logger.t(
                "Coordinates: ${prediction.lat},${prediction.lng}\n${prediction.description}",
              );
              controller.text = prediction.description ?? '';

              controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: prediction.description!.length));

              onPlaceTap(prediction);
            },
            onSuggestionClicked: (_) {},
          ),
        ),
      )
    ]);
  }
}
