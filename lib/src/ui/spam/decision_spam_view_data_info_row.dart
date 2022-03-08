import 'package:flutter/material.dart';

import '../../decision_style.dart';
import 'decision_spam_view_opened.dart';
import 'decision_spam_view_sent.dart';

class DecisionSdkSpamViewDataInfoRow extends StatelessWidget {

  final String? sinceYear;
  final int? totalEmails;
  final double? opened;

  final DecisionSdkStyle style;

  const DecisionSdkSpamViewDataInfoRow(
      this.sinceYear, this.totalEmails, this.opened, this.style, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: style.size(150),
              child:
                  DecisionSdkSpamViewSent(totalEmails, sinceYear, style: style,)),
          Container(width: 1, height: style.size(120), color: const Color(0xFFD8D8D8)),
          SizedBox(
              width: style.size(150), child: DecisionSdkSpamViewOpened(opened, style))
        ]);
  }
}
