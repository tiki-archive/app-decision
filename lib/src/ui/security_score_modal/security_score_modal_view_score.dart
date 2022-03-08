/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:decision_sdk/src/decision_style.dart';
import 'package:flutter/material.dart';
import 'security_score_modal_view_score_num.dart';

class SecurityScoreModalViewScore extends StatelessWidget {
  static const String _leadIn =
      'The security score is determined by two ratings:';
  static const String _labelSensitivity = 'SENSITIVITY';
  static const String _labelHacking = 'HACKING';
  final double? hacking;
  final double? sensitivity;
  final double? security;
  final DecisionSdkStyle style;

  const SecurityScoreModalViewScore(
      {Key? key,
      this.hacking,
      this.sensitivity,
      this.security,
      required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(_leadIn,
          style: TextStyle(
              color: const Color(0xFF00133F),
              fontFamily: style.textFont,
              fontSize: style.text(11.5),
              fontWeight: FontWeight.w600)),
      if (security != null)
        Container(
            margin: EdgeInsets.only(top: style.size(25)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SecurityScoreModalViewScoreNum(
                    score: sensitivity,
                    label: _labelSensitivity,
                    style: style,
                  ),
                  Container(
                    width: 1,
                    height: style.size(65),
                    color: const Color(0xFFAFAFAF),
                  ),
                  SecurityScoreModalViewScoreNum(
                    score: hacking,
                    label: _labelHacking,
                    style: style,
                  ),
                ])),
    ]);
  }
}
