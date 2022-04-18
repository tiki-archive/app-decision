import 'package:flutter/material.dart';

import 'decision_service.dart';

class DecisionController {
  final DecisionService service;

  DecisionController(this.service);

  void removeCard(
      {required BuildContext context,
      required int index,
      Function(BuildContext context)? callback}) {
    if (callback != null) callback(context);
    service.removeCard(index);
  }
}
