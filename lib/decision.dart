import 'package:flutter/material.dart';
import 'package:tiki_kv/tiki_kv.dart';

import 'src/decision_service.dart';
import 'src/decision_style.dart';
import 'src/ui/decision_abstract_card.dart';

export 'src/ui/decision_abstract_card.dart';

class Decision {
  late final DecisionService _service;

  Decision({
    DecisionStyle? style,
    TikiKv? tikiKv,
    bool isConnected = false,
  }) : _service = DecisionService(
          style: style ?? DecisionStyle(),
          tikiKv: tikiKv,
          isConnected: isConnected,
        );

  Future<Decision> init() async {
    await _service.addTests();
    return this;
  }

  Widget decisionWidget({bool example = false}) => _service.presenter.home();

  void addCards(List<DecisionAbstractCard> cards) => _service.addCards(cards);

  void setLinked(bool isLinked) {
    _service.model.isLinked = isLinked;
    _service.notifyListeners();
  }
}
