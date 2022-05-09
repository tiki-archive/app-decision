/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:tiki_style/tiki_style.dart';

class TestCardLayout extends StatelessWidget {
  static const double _fontSizeText = 12.5;
  static const String _test = "Test card\n";
  static const String _testHow =
      "Test how the Unsubscribe feature works\nby swiping this card.\n";
  static const String _rememberThat = "Remember that, ";
  static const String _unsubscribe = "once you unsubscribe from\nan email, ";
  static const String _undo =
      "you can only undo your action by\ngoing to the email list’s website.";
  static const String _testCardBarText = 'TEST CARD #';

  final int cardNum;

  const TestCardLayout(this.cardNum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeProvider style = SizeProvider.instance;
    final icons = [
      ImgProvider.watermelonHappy,
      ImgProvider.pineappleHappyAlt,
      ImgProvider.lemon,
    ];
    return Container(
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  color: ColorProvider.green,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(style.width(16)),
                  child: Center(
                      child: Text(_testCardBarText + (cardNum + 1).toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: TextProvider.familyNunitoSans,
                              package: TextProvider.package,
                              fontWeight: FontWeight.bold,
                              fontSize: style.text(15))))),
              Expanded(
                  child: Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(child: icons[cardNum], height: style.size(120)),
                Container(
                    margin: EdgeInsets.only(top: style.size(40)),
                    child: Text(
                      _test,
                      style: TextStyle(
                          color: ColorProvider.tikiBlue,
                          fontFamily: TextProvider.familyKoara,
                          package: TextProvider.package,
                          fontSize: style.text(25),
                          fontWeight: FontWeight.bold),
                    )),
                Text(
                  _testHow,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorProvider.tikiBlue,
                      fontFamily: TextProvider.familyNunitoSans,
                      package: TextProvider.package,
                      fontSize: style.text(_fontSizeText),
                      fontWeight: FontWeight.w600),
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: _rememberThat,
                        style: TextStyle(
                            color: ColorProvider.tikiBlue,
                            fontFamily: TextProvider.familyNunitoSans,
                            package: TextProvider.package,
                            fontSize: style.text(_fontSizeText),
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: _unsubscribe,
                            style: TextStyle(
                              color: ColorProvider.tikiBlue,
                              fontFamily: TextProvider.familyNunitoSans,
                              package: TextProvider.package,
                              fontSize: style.text(_fontSizeText),
                            ),
                          ),
                          const TextSpan(
                              text: _undo,
                              style: TextStyle(color: ColorProvider.orange)),
                        ])),
              ])))
            ]));
  }
}
