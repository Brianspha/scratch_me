import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scratch_me/shared/ui/size_config.dart';

class ScratchMeBaseContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool allowBackPress;
  const ScratchMeBaseContainer(
      {Key? key,
      required this.child,
      required this.color,
      required this.allowBackPress});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return WillPopScope(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Container(
                color: color,
                width: SizeConfig.safeBlockHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 100,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal * 2.5),
                    child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(), child: child))),
          )),
      onWillPop: () {
        return Future.value(allowBackPress); // if true allow back else block it
      },
    );
  }
}
