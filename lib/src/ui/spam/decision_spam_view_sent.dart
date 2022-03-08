/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:decision_sdk/src/decision_style.dart';
import 'package:flutter/material.dart';

class DecisionSdkSpamViewSent extends StatelessWidget {
  final int? totalEmails;
  final String? sinceYear;
  final DecisionSdkStyle style;

  const DecisionSdkSpamViewSent(this.totalEmails, this.sinceYear, {Key? key, required this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("They've sent you",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF00133F),
                fontSize: style.text(10))),
        Padding(padding: EdgeInsets.only(bottom: style.size(2))),
        Text(
          totalEmails.toString(),
          style: TextStyle(
              fontFamily: style.bigTxtFontFamily,
              fontSize: style.text(45),
              fontWeight: FontWeight.bold),
        ),
        Text(
            totalEmails != null && totalEmails! > 1
                ? "emails"
                : "email",
            style: TextStyle(
                height: 0.5, fontWeight: FontWeight.w800, fontSize: style.text(10))),
        Padding(padding: EdgeInsets.only(bottom: style.size(14))),
        ClipRRect(
            borderRadius: BorderRadius.circular(style.size(5)),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: style.size(8), horizontal: style.size(7)),
                color: const Color(0xFF00133F),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        child: Icon(Icons.calendar_today,
                            color: Colors.white, size: style.text(9)),
                        padding: EdgeInsets.only(right: style.size(15))),
                    Text(
                      " since ${sinceYear.toString()}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: style.text(10),
                          fontWeight: FontWeight.w800),
                    )
                  ],
                )))
      ],
    );
  }
}
