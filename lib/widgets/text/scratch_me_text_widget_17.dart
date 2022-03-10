import 'package:flutter/cupertino.dart';
import 'package:scratch_me/shared/ui/size_config.dart';

class ScratchMeTextWidget17 extends StatelessWidget {
  late final String text;
  late final Color fontColor;

  ScratchMeTextWidget17({required this.text, required this.fontColor});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      this.text,
      style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 10, color: this.fontColor),
    );
  }
}
