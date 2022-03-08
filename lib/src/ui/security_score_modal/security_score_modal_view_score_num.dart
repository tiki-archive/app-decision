/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:decision_sdk/src/decision_style.dart';
import 'package:flutter/material.dart';

class SecurityScoreModalViewScoreNum extends StatelessWidget {
  final int? score;
  final String label;
  final DecisionSdkStyle style;

  SecurityScoreModalViewScoreNum(
      {Key? key, double? score, required this.label, required this.style})
      : score = score != null ? ((1 - score) * 10).floor() : null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      score != null
          ? Text("$score / 10",
              style: TextStyle(
                  color: _getColor(score!),
                  fontSize: style.text(30),
                  fontWeight: FontWeight.bold))
          : Text("? / 10",
              style: TextStyle(
                  color: const Color(0xFFAFAFAF),
                  fontSize: style.text(30),
                  fontWeight: FontWeight.bold)),
      Text(label,
          style: TextStyle(
              color: const Color(0xFF797979),
              fontSize: style.text(11.5),
              fontFamily: style.textFont,
              fontWeight: FontWeight.bold))
    ]);
  }

  Color _getColor(int score) {
    if (score < 4) {
      return const Color(0xFFC73000);
    } else if (score < 7) {
      return const Color(0xFFE89933);
    } else {
      return const Color(0xFF00B272);
    }
  }
}
