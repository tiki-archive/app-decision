/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:decision_sdk/src/decision_style.dart';
import 'package:flutter/material.dart';

class DecisionSdkSpamViewOpened extends StatelessWidget {
  final double? percent;
  final DecisionSdkStyle style;

  const DecisionSdkSpamViewOpened(this.percent, this.style, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("You've opened",
          style: TextStyle(
              fontFamily: style.textFont,
              fontWeight: FontWeight.w600,
              fontSize: style.text(10),
              color: const Color(0xFF00133F))),
      Container(
          margin: EdgeInsets.symmetric(vertical: style.size(8)),
          height: style.size(6),
          width: style.size(6),
          child: Stack(children: [
            Center(
                child: RichText(
                    text: TextSpan(
                        text: (percent! * 100).round().toString(),
                        //TODO FIX!
                        style: TextStyle(
                            color: _getProgressColor(percent! * 100),
                            fontFamily: style.bigTxtFontFamily,
                            fontSize: style.text(19),
                            fontWeight: FontWeight.bold),
                        children: [
                  TextSpan(
                    text: " ",
                    style: TextStyle(fontSize: style.text(6)),
                  ),
                  TextSpan(
                    text: "%",
                    style: TextStyle(
                        fontFamily: style.textFont,
                        fontSize: style.text(11.5),
                        fontWeight: FontWeight.w800),
                  )
                ]))),
            SizedBox(
              height: style.size(6),
              width: style.size(6),
              child: CircularProgressIndicator(
                  strokeWidth: style.size(1),
                  backgroundColor: const Color(0xFFC4C4C4),
                  value: percent,
                  color: _getProgressColor(percent! * 100)),
            )
          ])),
      Text("of their emails",
          style: TextStyle(
              fontFamily: style.textFont,
              fontWeight: FontWeight.w600,
              fontSize: style.text(10),
              color: const Color(0xFF00133F)))
    ]);
  }

  _getProgressColor(percent) {
    if (percent <= 50) {
      return const Color(0xFFE89933);
    } else {
      return const Color(0xFF00B272);
    }
  }
}
