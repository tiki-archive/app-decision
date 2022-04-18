import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../decision_service.dart';
import '../decision_style.dart';
import 'decision_abstract_card.dart';

class DecisionViewCardTest implements DecisionAbstractCard {
  static const double _fontSizeText = 12.5;
  static const String _test = "Test card\n";
  static const String _testHow =
      "Test how the Unsubscribe feature works\nby swiping this card.\n";
  static const String _rememberThat = "Remember that, ";
  static const String _unsubscribe = "once you unsubscribe from\nan email, ";
  static const String _undo =
      "you can only undo your action by\ngoing to the email list’s website.";
  static const String _testCardBarText = 'TEST CARD #';

  final icons = [
    "test-card-watermelon",
    "test-card-pineapple",
    "test-card-lemon",
  ];

  final int cardnum;
  final DecisionStyle style;

  DecisionViewCardTest(this.cardnum, this.style);

  @override
  Future<void> callbackNo(BuildContext context) => _testDone(context);

  @override
  Future<void> callbackYes(BuildContext context) => _testDone(context);

  @override
  Widget content(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  color: const Color(0xFF00B272),
                  width: double.maxFinite,
                  padding: EdgeInsets.all(style.size(16)),
                  child: Center(
                      child: Text(_testCardBarText + (cardnum + 1).toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: style.textFont,
                              fontWeight: FontWeight.bold,
                              fontSize: style.text(15))))),
              Expanded(
                  child: Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                Image.asset("res/images/${icons[cardnum]}.png",
                    height: style.size(120), package: 'decision'),
                Container(
                    margin: EdgeInsets.only(top: style.size(40)),
                    child: Text(
                      _test,
                      style: TextStyle(
                          color: const Color(0xFF00133F),
                          fontFamily: style.bigTxtFontFamily,
                          fontSize: style.text(25),
                          fontWeight: FontWeight.bold),
                    )),
                Text(
                  _testHow,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: const Color(0xFF00133F),
                      fontFamily: style.textFont,
                      fontSize: style.text(_fontSizeText),
                      fontWeight: FontWeight.w600),
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: _rememberThat,
                        style: TextStyle(
                            color: const Color(0xFF00133F),
                            fontFamily: style.textFont,
                            fontSize: style.text(_fontSizeText),
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: _unsubscribe,
                            style: TextStyle(
                              color: const Color(0xFF00133F),
                              fontFamily: style.textFont,
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
    if (cardnum + 1 == icons.length) {
      var service = Provider.of<DecisionService>(context, listen: false);
      service.testDone();
    }
  }
}
