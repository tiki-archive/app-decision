import 'package:flutter/material.dart';

import 'src/decision_service.dart';
import 'src/decision_style.dart';
import 'src/ui/decision_abstract_card.dart';

export 'src/ui/decision_abstract_card.dart';
export 'src/model/decision_card_spam_model.dart';

class DecisionSdk {
  late final DecisionSdkService _service;

  DecisionSdk(
      {DecisionSdkStyle? style,
      bool isTestDone = false,
      bool isConnected = false,
      Function? testDoneCallback,
      List<DecisionSdkAbstractCard>? cards})
      : _service = DecisionSdkService(
            style: style ?? DecisionSdkStyle(),
            isTestDone: isTestDone,
            isConnected: isConnected,
            testDoneCallback: testDoneCallback,
            cards: cards);

  Widget home({bool example = false}) => _service.presenter.home();

  Future<void> addSpamCards({
    required String provider,
    required List<dynamic> messages,
    required Function(int) unsubscribeCallback,
    required Function(int) keepCallback}) =>
      _service.spam.addCards(
          provider: provider,
          unsubscribeCallback: unsubscribeCallback,
          messages: messages,
          keepCallback: keepCallback);
}
