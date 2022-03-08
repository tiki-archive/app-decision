import 'package:flutter/material.dart';

import '../../decision_style.dart';

class DecisionSdkSpamViewSeparator extends StatelessWidget {
  final DecisionSdkStyle style;
  const DecisionSdkSpamViewSeparator({Key? key, required this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: Container(
              margin: EdgeInsets.only(right: style.size(9)),
              height: 1,
              color: const Color(0xFFD8D8D8))),
      Image.asset("icon-email", height: style.size(16)),
      Expanded(
          child: Container(
              margin: EdgeInsets.only(left: style.size(10)),
              height: 1,
              color: const Color(0xFFD8D8D8))),
    ]);
  }
}
