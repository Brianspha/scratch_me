import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scratch_me/classes/app_storage.dart';
import 'package:scratch_me/locators/service_locator.dart';
import 'package:scratch_me/shared/ui/app_colors.dart';
import 'package:scratch_me/shared/ui/size_config.dart';
import 'package:scratch_me/views/game/scratch_me_game_collection_view.dart';
import 'package:scratch_me/views/game/scratch_me_game_rules_view.dart';
import 'package:scratch_me/views/game/scratch_me_game_view.dart';
import 'package:scratch_me/views/game/scratch_me_user_address_view.dart';
import 'package:scratch_me/widgets/buttons/scratch_me_outlined_button_widget.dart';
import 'package:scratch_me/widgets/container/scratch_me_base_container.dart';
import 'package:scratch_me/widgets/text/scratch_me_text_widget_15.dart';
import 'package:scratch_me/widgets/text/scratch_me_text_widget_17.dart';

class ScratchMeMenuView extends StatefulWidget {
  const ScratchMeMenuView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScratchMeMenuViewState();
  }
}

class _ScratchMeMenuViewState extends State<ScratchMeMenuView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return ScratchMeBaseContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              child: ScratchMeTextWidget17(
                text: "Scratch Me",
                fontColor: textInputColorWhite,
              ),
              padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 10),
            ),
            Padding(
              child: ScratchMeTextWidget15(
                text: "(Kovan Testnetwork)",
                fontColor: textInputColorWhite,
              ),
              padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3),
            ),
            Padding(
              child: ScratchMeOutlinedButtonWidget(
                buttonTitle: "Play",
                buttonColor: textInputColorWhiteLight,
                onTap: () async {
                  var userAddress = await locator
                      .get<AppStorage>()
                      .getStorageValue("address");
                  if (userAddress == null) {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (_) => new ScatchMeUserAddressView()));
                  } else {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (_) => new ScratchMeGameView()));
                  }
                },
                width: SizeConfig.safeBlockHorizontal * 60,
                height: SizeConfig.safeBlockVertical * 6,
              ),
              padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 20),
            ),
            Padding(
              child: ScratchMeOutlinedButtonWidget(
                buttonTitle: "Game Rules",
                buttonColor: textInputColorWhiteLight,
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (_) => new ScratchMeGameRulesView()));
                },
                width: SizeConfig.safeBlockHorizontal * 60,
                height: SizeConfig.safeBlockVertical * 6,
              ),
              padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5),
            ),
            Padding(
              child: ScratchMeOutlinedButtonWidget(
                buttonTitle: "My Collections",
                buttonColor: textInputColorWhiteLight,
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (_) => new ScratchGameCollectionView()));
                },
                width: SizeConfig.safeBlockHorizontal * 60,
                height: SizeConfig.safeBlockVertical * 6,
              ),
              padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5),
            )
          ],
        ),
        color: purple,
        allowBackPress: false);
  }
}
