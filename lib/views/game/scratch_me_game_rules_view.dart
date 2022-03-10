import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scratch_me/shared/ui/app_colors.dart';
import 'package:scratch_me/shared/ui/size_config.dart';
import 'package:scratch_me/widgets/buttons/scratch_me_outlined_button_widget.dart';
import 'package:scratch_me/widgets/container/scratch_me_base_container.dart';
import 'package:scratch_me/widgets/text/scratch_me_text_widget_15.dart';
import 'package:scratch_me/widgets/text/scratch_me_text_widget_17.dart';

class ScratchMeGameRulesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScratchMeBaseContainer(
        child: new Column(
          children: <Widget>[
            Padding(
              child: ScratchMeTextWidget17(
                text: "Scratch Me Rules",
                fontColor: textInputColorWhite,
              ),
              padding: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical * 10,
                  bottom: SizeConfig.safeBlockVertical * 10),
            ),
            ScratchMeTextWidget15(
              text:
                  "- You use your finger to scratch the designated area on the screen to reveal the symbols, cards or money values.",
              fontColor: textInputColorWhite,
            ),
            SizedBox(height: SizeConfig.safeBlockVertical*3,),
            ScratchMeTextWidget15(
              text:
                  "- This game allows the user to select any 5 block from the total 35 present out of which only one has the prize.",
              fontColor: textInputColorWhite,
            ),
            SizedBox(height: SizeConfig.safeBlockVertical*3,),

            ScratchMeTextWidget15(
              text:
                  "- If you figure out which block it is on or before 5th try then you win, else you lose and the game will reset itself after 2 seconds.",
              fontColor: textInputColorWhite,
            ),
            Padding(
              child: ScratchMeOutlinedButtonWidget(
                buttonTitle: "Back",
                buttonColor: textInputColorWhiteLight,
                onTap: () {
                  Navigator.pop(context);
                },
                width: SizeConfig.safeBlockHorizontal * 60,
                height: SizeConfig.safeBlockVertical * 6,
              ),
              padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 10),
            )
          ],
        ),
        color: purple,
        allowBackPress: true);
  }
}
