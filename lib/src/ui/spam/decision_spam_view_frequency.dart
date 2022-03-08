import 'package:decision_sdk/src/decision_style.dart';
import 'package:flutter/material.dart';

class DecisionSdkSpamViewFrequency extends StatelessWidget {
  final String frequency;
  final String category;
  final DecisionSdkStyle style;

  const DecisionSdkSpamViewFrequency( this.frequency,  this.category, this.style, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("They send you emails",
            style: TextStyle(
                fontSize: style.size(90),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF00133F))),
        Padding(padding: EdgeInsets.only(top: style.size(6))),
        Text('${frequency[0].toUpperCase()}${frequency.substring(1)}',
            style: TextStyle(
                fontFamily: style.bigTxtFontFamily,
                fontSize: style.text(26),
                fontWeight: FontWeight.w800,
                color: _getTextColor(frequency))),
        Padding(padding: EdgeInsets.only(top: style.size(6))),
        _getCategory(category)
      ],
    );
  }

  _getTextColor(String frequency) {
    switch (frequency) {
      case "monthly":
        return const Color(0xFF00B272);
      case "daily":
        return const Color(0xFFB5002B);
      case "weekly":
        return const Color(0xFFE89933);
    }
  }

  _getCategory(category) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('in',
              style: TextStyle(
                  fontSize: style.text(10),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00133F))),
          Padding(
            padding: EdgeInsets.only(left: style.text(3)),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF545454), width: style.text(1)),
                  borderRadius: BorderRadius.circular(50)),
              padding: EdgeInsets.symmetric(vertical: style.text(3), horizontal: style.text(8)),
              child: Row(
                children: [
                  Icon(
                    Icons.sell,
                    color: const Color(0xFF545454),
                    size: style.text(12),
                  ),
                  Padding(padding: EdgeInsets.only(left: style.text(4))),
                  Text(
                      "${category[0].toUpperCase()}${category.substring(1).toLowerCase()}",
                      style: TextStyle(
                          fontSize: style.text(10),
                          color: const Color(0xFF545454),
                          fontWeight: FontWeight.w800))
                ],
              ))
        ]);
  }
}
