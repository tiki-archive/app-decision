/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:decision_sdk/src/decision_style.dart';
import 'package:flutter/material.dart';

class SecurityScoreModalViewButton extends StatelessWidget {
  static const String _text = 'OK, got it';
  final DecisionSdkStyle style;

  const SecurityScoreModalViewButton({Key? key, required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: const Color(0xFFFF521C),
        padding: EdgeInsets.symmetric(vertical: style.size(14)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(style.size(10)))),
      ),
      child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: style.text(26),
          child: Text(_text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: style.text(13),
                  fontWeight: FontWeight.bold,
                  fontFamily: style.textFont))),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
