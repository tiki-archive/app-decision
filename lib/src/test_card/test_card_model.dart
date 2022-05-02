/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_style/tiki_style.dart';

import '../../tiki_decision_card.dart';
import 'test_card_service.dart';

class TestCardModel implements TikiDecisionCard {
  static const double _fontSizeText = 12.5;
  static const String _test = "Test card\n";
  static const String _testHow =
      "Test how the Unsubscribe feature works\nby swiping this card.\n";
  static const String _rememberThat = "Remember that, ";
  static const String _unsubscribe = "once you unsubscribe from\nan email, ";
  static const String _undo =
      "you can only undo your action by\ngoing to the email list’s website.";
  static const String _testCardBarText = 'TEST CARD #';

  final int cardnum;

  TestCardModel(this.cardnum);

  @override
  Future<void> callbackNo(BuildContext context) => _testDone(context);

  @override
  Future<void> callbackYes(BuildContext context) => _testDone(context);

  @override
  Widget content(BuildContext context) {
    SizeProvider style = SizeProvider.instance;
    final icons = [
      ImgProvider.testCardWatermelon,
      ImgProvider.testCardPineapple,
      ImgProvider.testCardLemon,
    ];
    return Container(
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  color: const Color(0xFF00B272),
                  width: double.maxFinite,
                  padding: EdgeInsets.all(style.width(16)),
                  child: Center(
                      child: Text(_testCardBarText + (cardnum + 1).toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: TextProvider.familyNunitoSans,
                              package: 'style',
                              fontWeight: FontWeight.bold,
                              fontSize: style.text(15))))),
              Expanded(
                  child: Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(child: icons[cardnum], height: style.size(120)),
                Container(
                    margin: EdgeInsets.only(top: style.size(40)),
                    child: Text(
                      _test,
                      style: TextStyle(
                          color: const Color(0xFF00133F),
                          fontFamily: TextProvider.familyKoara,
                          package: 'style',
                          fontSize: style.text(25),
                          fontWeight: FontWeight.bold),
                    )),
                Text(
                  _testHow,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: const Color(0xFF00133F),
                      fontFamily: TextProvider.familyNunitoSans,
                      package: 'style',
                      fontSize: style.text(_fontSizeText),
                      fontWeight: FontWeight.w600),
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: _rememberThat,
                        style: TextStyle(
                            color: const Color(0xFF00133F),
                            fontFamily: TextProvider.familyNunitoSans,
                            package: 'style',
                            fontSize: style.text(_fontSizeText),
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: _unsubscribe,
                            style: TextStyle(
                              color: const Color(0xFF00133F),
                              fontFamily: TextProvider.familyNunitoSans,
                              package: 'style',
                              fontSize: style.text(_fontSizeText),
                            ),
                          ),
                          const TextSpan(
                              text: _undo,
                              style: TextStyle(color: Color(0xFFFF521C))),
                        ])),
              ])))
            ]));
  }

  Future<void> _testDone(context) async {
    if (cardnum + 1 == 3) {
      Provider.of<TestCardService>(context, listen: false)
          .controller
          .done(context, cardnum);
    }
  }
}
