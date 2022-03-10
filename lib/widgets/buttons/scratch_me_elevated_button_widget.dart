import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scratch_me/shared/ui/app_colors.dart';
import 'package:scratch_me/widgets/text/scratch_me_text_widget_15.dart';

class ScratchMeElevatedButtonWidget extends StatelessWidget {
  late final VoidCallback onTap;
  late final buttonTitle;
  late final Color buttonColor;
  late final double width, height;
  late Widget child;
  ScratchMeElevatedButtonWidget(
      {required this.onTap,
      required this.buttonColor,
      required this.width,
      required this.height,
        required this.child});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(this.buttonColor),
              foregroundColor:
                  MaterialStateProperty.all<Color>(buttonColor)),
          onPressed: onTap,
          child: child));
  }
}
