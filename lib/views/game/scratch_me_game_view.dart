import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:scratch_me/classes/app_storage.dart';
import 'package:scratch_me/classes/token_manager.dart';
import 'package:scratch_me/locators/service_locator.dart';
import 'package:scratch_me/shared/ui/app_colors.dart';
import 'package:scratch_me/shared/ui/size_config.dart';
import 'package:scratch_me/widgets/buttons/scratch_me_elevated_button_widget.dart';
import 'package:scratch_me/widgets/buttons/scratch_me_outlined_button_widget.dart';
import 'package:scratch_me/widgets/container/scratch_me_base_container.dart';
import 'package:scratch_me/widgets/text/scratch_me_text_widget_15.dart';
import 'package:scratch_me/widgets/text/scratch_me_text_widget_17.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:web3dart/credentials.dart';

class ScratchMeGameView extends StatefulWidget {
  @override
  _ScratchMeGameViewState createState() => _ScratchMeGameViewState();
}

//@dev contains unstructed code :( too little time to format
class _ScratchMeGameViewState extends State<ScratchMeGameView> {
  AssetImage blank = const AssetImage("assets/images/blank.png");
  AssetImage unlucky = const AssetImage("assets/images/sad.png");
  AssetImage lucky = AssetImage("assets/images/money.png");
  late List<String> itemArray;
  late int luckyNumber, numberOfTokensWon = 0;
  int count = 0;
  String message = "Let the game begin";
  bool _isLoading = false, gameOver = false;
  generateRandomNumber() {
    int random = Random().nextInt(35);
    setState(() {
      luckyNumber = random;
      print("luckyNumber: $luckyNumber");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemArray = List<String>.generate(35, (index) => "empty");
    generateRandomNumber();
  }

  displayMessage() {
    message = "You have reached maximum tries 😢😢";
    Delay();
  }

  Delay() {
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        this.resetGame();
        gameOver = false;
        count = 0;
      });
    });
  }

  resetGame() {
    setState(() {
      itemArray = List<String>.filled(35, "empty");
      this.message = "Let the game begin";
      this.count = 0;
      gameOver=false;
    });
    generateRandomNumber();
  }

  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
    }
    return blank;
  }

  playGame(int index) {
    if (luckyNumber == index) {
      setState(() {
        itemArray[index] = "lucky";
        this.message = "Yup you got it🎉🎉";
        this.numberOfTokensWon++;
        Delay();
      });
    } else if (luckyNumber != index && count <= 5) {
      setState(() {
        itemArray[index] = "unlucky";
        count++;
      });
      if (count == 5) {
        setState(() {
          gameOver = true;
        });
      }
      if (count == 4) {
        this.message = "Last chance🥺🥺";
      }
      if (count == 3) {
        this.message = "Two more left😳😳 ";
      }
      if (count == 2) {
        this.message = "Stay calm,You can win😌😌 ";
      }
      if (count == 1) {
        this.message = "There is a long way to go🥱🥱";
      }
    }
  }

  showAll() {
    setState(() {
      itemArray = List<String>.filled(35, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    child: ScratchMeTextWidget15(
                      text: "Scratch Me",
                      fontColor: textInputColorWhite,
                    ),
                    padding:
                        EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 100,
                  height: SizeConfig.safeBlockVertical * 65,
                  child: GridView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: 35,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 5,
                        childAspectRatio: 1),
                    itemBuilder: (context, i) => ScratchMeElevatedButtonWidget(
                      width: SizeConfig.safeBlockHorizontal * 10,
                      height: SizeConfig.safeBlockVertical * 10,
                      child: Image(
                        image: this.getImage(i),
                        width: SizeConfig.safeBlockHorizontal * 10,
                        height: SizeConfig.safeBlockVertical * 10,
                      ),
                      onTap: gameOver
                          ? () {}
                          : () {
                              playGame(i);
                            },
                      buttonColor: textInputColorWhiteLight,
                    ),
                  ),
                ),
                Center(
                  child: ScratchMeTextWidget15(
                    text: message,
                    fontColor: textInputColorWhite,
                  ),
                ),
                Center(
                  child: ScratchMeTextWidget15(
                    text: "Number of Tokens Collected: ${numberOfTokensWon}",
                    fontColor: textInputColorWhite,
                  ),
                ),
                Padding(
                  child: ScratchMeOutlinedButtonWidget(
                    buttonTitle: "Start Again",
                    buttonColor: darkGrey,
                    onTap: () {
                      this.resetGame();
                      setState(() {
                        numberOfTokensWon = 0;
                      });
                    },
                    width: SizeConfig.safeBlockHorizontal * 20,
                    height: SizeConfig.safeBlockVertical * 6,
                  ),
                  padding:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3),
                ),
                if (gameOver)
                  Padding(
                    child: ScratchMeOutlinedButtonWidget(
                      buttonTitle: "Claim Tokens",
                      buttonColor: darkGrey,
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        bool hasError = false;
                        var userAddress = await locator
                            .get<AppStorage>()
                            .getStorageValue("address");
                        var redeemedTokens = 0;
                        for (redeemedTokens = 0;
                            redeemedTokens < this.numberOfTokensWon;
                            redeemedTokens++) {
                          try{
                            var address = EthereumAddress.fromHex(userAddress!);
                            await locator
                                .get<TokenManager>()
                                .submit("mintTokenToPlayer", [
                              address,
                              jsonEncode({
                                "date": DateTime.now().millisecondsSinceEpoch,
                                "owner": userAddress,
                                "game": "ScratchMe"
                              })
                            ]);
                          }
                          catch(error){
                            showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  textStyle: TextStyle(
                                      fontSize:
                                      SizeConfig.safeBlockHorizontal * 2.6,
                                      color: textInputColorWhite),
                                  messagePadding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                                  backgroundColor: purpleColorBrightSadu,
                                  message: "Error redeeming tokens",
                                ),
                                displayDuration: Duration(seconds: 6));
                            setState(() {
                              _isLoading = false;
                              hasError=true;
                            });
                            this.resetGame();
                            print("error sending tx: ${error.toString()}");
                          }

                        }
                        if (redeemedTokens == numberOfTokensWon && !hasError) {
                          showTopSnackBar(
                              context,
                              CustomSnackBar.error(
                                textStyle: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 2.6,
                                    color: textInputColorWhite),
                                messagePadding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                backgroundColor: purpleColorBrightSadu,
                                message: "Tokens successfully redeemed",
                              ),
                              displayDuration: Duration(seconds: 6));
                          setState(() {
                            _isLoading = false;
                            numberOfTokensWon=0;
                          });
                          this.resetGame();
                        } else {
                          showTopSnackBar(
                              context,
                              CustomSnackBar.error(
                                textStyle: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 2.6,
                                    color: textInputColorWhite),
                                messagePadding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                backgroundColor: purpleColorBrightSadu,
                                message: "Not all tokens were redeemed",
                              ),
                              displayDuration: Duration(seconds: 6));
                          setState(() {
                            _isLoading = false;
                            numberOfTokensWon-=redeemedTokens;
                          });
                          this.resetGame();
                        }
                      },
                      width: SizeConfig.safeBlockHorizontal * 20,
                      height: SizeConfig.safeBlockVertical * 6,
                    ),
                    padding:
                        EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3),
                  ),
                Padding(
                  child: ScratchMeOutlinedButtonWidget(
                    buttonTitle: "Back",
                    buttonColor: darkGrey,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    width: SizeConfig.safeBlockHorizontal * 20,
                    height: SizeConfig.safeBlockVertical * 6,
                  ),
                  padding:
                      EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
                )
              ],
            )));
  }
}
