import 'package:flutter/material.dart';
import 'package:tiki_kv/tiki_kv.dart';

import 'src/decision_service.dart';
import 'src/decision_style.dart';
import 'src/ui/decision_abstract_card.dart';

export 'src/ui/decision_abstract_card.dart';

class DecisionSdk {
  late final DecisionSdkService _service;

  dynamic apiAuthService;

  DecisionSdk({
    DecisionSdkStyle? style,
    TikiKv? tikiKv,
    bool isConnected = false,
  }) : _service = DecisionSdkService(
          style: style ?? DecisionSdkStyle(),
          tikiKv: tikiKv,
          isConnected: isConnected,
        );

  Future<DecisionSdk> init() async {
    await _service.addTests();
    return this;
  }

  Widget decisionWidget({bool example = false}) => _service.presenter.home();

  void addCards(List<DecisionSdkAbstractCard> cards) =>
      _service.addCards(cards);
}
