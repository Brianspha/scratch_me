import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:scratch_me/classes/app_storage.dart';
import 'package:scratch_me/classes/token_manager.dart';
import 'package:scratch_me/locators/service_locator.dart';
import 'package:scratch_me/shared/ui/app_colors.dart';
import 'package:scratch_me/shared/ui/size_config.dart';
import 'package:scratch_me/widgets/buttons/scratch_me_outlined_button_widget.dart';
import 'package:scratch_me/widgets/container/scratch_me_base_container.dart';
import 'package:scratch_me/widgets/text/scratch_me_text_widget_15.dart';
import 'package:scratch_me/widgets/text/scratch_me_text_widget_17.dart';
import 'package:web3dart/credentials.dart';

class ScratchGameCollectionView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScratchGameCollectionViewState();
  }
}

class _ScratchGameCollectionViewState extends State<ScratchGameCollectionView> {
  bool _isLoading = false;
  List<dynamic> tokens = [];
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    locator
        .get<AppStorage>()
        .getStorageValue("address")
        .then((userAddress) async {
      if (userAddress != null) {
        var address = EthereumAddress.fromHex(userAddress);
        var tokenIds = await locator
            .get<TokenManager>()
            .query("getPlayerTokensIds", [address]);
        _isLoading = false;
        if (tokenIds != null && tokenIds.length > 0) {
          var tempTokenIds = tokenIds[0].length > 0 ? tokenIds[0] : [];
          for (var tokenIndex in tempTokenIds) {
            var tokenURI = await locator
                .get<TokenManager>()
                .query("getTokenURI", [tokenIndex]);
            print("tokenURI: ${tokenURI}");
            if(tokenURI.isNotEmpty){
              tokens.add(jsonDecode(tokenURI[0]));
            }

          }
          setState(() {
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
      });
      print("error getting user address: ${onError.toString()}");
    });
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LoadingOverlay(
        color: loadingIndicatorBackGroundColor,
        progressIndicator: Center(
          child: SpinKitDualRing(
            color: textInputColorWhite,
          ),
        ),
        isLoading: _isLoading,
        child: ScratchMeBaseContainer(
            allowBackPress: true,
            color: purple,
            child: Column(
              children: [
                Padding(
                  child: ScratchMeTextWidget17(
                    text: "My Collection",
                    fontColor: textInputColorWhite,
                  ),
                  padding:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 10),
                ),
                Padding(
                  child: Container(
                    child: tokens.isEmpty
                        ? Center(
                            child: ScratchMeTextWidget15(
                              text: "No Collectibles",
                              fontColor: textInputColorWhite,
                            ),
                          )
                        : ListView.builder(
                            itemCount: tokens.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  leading: Icon(Icons.ac_unit),
                                  trailing: ScratchMeTextWidget15(
                                    text: (index+1).toString(),
                                    fontColor: textInputColorWhite,
                                  ),
                                  title: ScratchMeTextWidget15(
                                    text: "Earned in",
                                    fontColor: textInputColorWhite,
                                  ),subtitle: ScratchMeTextWidget15(
                                text: tokens[index]["game"],
                                fontColor: textInputColorWhite,
                              ),);
                            }),
                    width: SizeConfig.safeBlockHorizontal * 100,
                    height: SizeConfig.safeBlockVertical * 40,
                  ),
                  padding: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical * 5,
                      bottom: SizeConfig.safeBlockVertical * 5),
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
                  padding:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 10),
                )
              ],
            )));
  }
}
