import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scratch_me/shared/ui/app_colors.dart';
import 'package:scratch_me/widgets/text/scratch_me_text_widget_15.dart';

class ScratchMeOutlinedButtonWidget extends StatelessWidget {
  late final VoidCallback onTap;
  late final buttonTitle;
  late final Color buttonColor;
  late final double width, height;
  ScratchMeOutlinedButtonWidget(
      {required this.onTap,
      required this.buttonColor,
      required this.buttonTitle,
      required this.width,
      required this.height});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
        width: width,
        height: height,
        child: OutlinedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(this.buttonColor),
              foregroundColor:
                  MaterialStateProperty.all<Color>(buttonColor)),
          onPressed: onTap,
          child: Center(
              child: ScratchMeTextWidget15(
                  text: buttonTitle, fontColor: textInputColorWhiteLight)),
        ));
  }
}
