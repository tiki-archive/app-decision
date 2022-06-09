import 'package:flutter/material.dart';
import 'package:tiki_decision/tiki_decision.dart';
import 'package:tiki_style/tiki_style.dart';

class Widgety extends StatelessWidget {
  final TikiDecision decision;

  const Widgety(this.decision, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TikiStyle.init(context);
    return decision.widget;
  }
}