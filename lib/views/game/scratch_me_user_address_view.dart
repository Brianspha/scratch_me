import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scratch_me/classes/app_storage.dart';
import 'package:scratch_me/locators/service_locator.dart';
import 'package:scratch_me/shared/ui/app_colors.dart';
import 'package:scratch_me/shared/ui/size_config.dart';
import 'package:scratch_me/views/game/scratch_me_game_view.dart';
import 'package:scratch_me/widgets/buttons/scratch_me_outlined_button_widget.dart';
import 'package:scratch_me/widgets/container/scratch_me_base_container.dart';
import 'package:scratch_me/widgets/text/scratch_me_text_widget_15.dart';
import 'package:scratch_me/widgets/text/scratch_me_text_widget_17.dart';

class ScatchMeUserAddressView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScatchMeUserAddressViewState();
  }
}

class _ScatchMeUserAddressViewState extends State<ScatchMeUserAddressView> {
  final _formKey = GlobalKey<FormState>();
  String _userAddress = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScratchMeBaseContainer(
      allowBackPress: false,
      color: purple,
      child: Column(
        children: [
          Padding(
            child: ScratchMeTextWidget15(
              text: "Please enter your Ethereum Address below",
              fontColor: textInputColorWhite,
            ),
            padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 10),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Form(
              child: TextFormField(
                onChanged: (address) {
                  setState(() {
                    _userAddress = address;
                  });
                },
                validator: (String? address) {
                  if (address == null ||
                      address.isEmpty ||
                      address.length < 42) {
                    return "Invalid eth address";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide:
                          const BorderSide(color: textInputColorWhite, width: 2.0)),
                  labelText: 'Eth address',
                ),
              ),
              key: _formKey,
            ),
          ),
          Padding(
            child: ScratchMeOutlinedButtonWidget(
              buttonTitle: "Start",
              buttonColor: textInputColorWhiteLight,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    locator
                        .get<AppStorage>()
                        .writeStorageValue("address", _userAddress);
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (_) => new ScratchMeGameView()));
                  });
                }
              },
              width: SizeConfig.safeBlockHorizontal * 60,
              height: SizeConfig.safeBlockVertical * 6,
            ),
            padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 40),
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
            padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5),
          )
        ],
      ),
    );
  }
}
