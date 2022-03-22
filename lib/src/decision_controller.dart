import 'package:flutter/material.dart';

import 'decision_service.dart';

class DecisionSdkController {
  final DecisionSdkService service;

  DecisionSdkController(this.service);

  void removeCard(
      {required BuildContext context,
      required int index,
      Function(BuildContext context)? callback}) {
    if (callback != null) callback(context);
    service.removeCard(index);
  }
}
