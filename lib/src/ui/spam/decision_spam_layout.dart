import 'package:decision_sdk/decision.dart';
import 'package:flutter/material.dart';

import '../../decision_spam_service.dart';
import 'decision_spam_layout_content.dart';

class DecisionSdkSpamLayout implements DecisionSdkAbstractCard {
  final DecisionSdkSpamModel cardSpamModel;
  final DecisionSdkSpamService service;

  DecisionSdkSpamLayout(this.service, this.cardSpamModel);

  @override
  Future<void> callbackNo(BuildContext context) async =>
      cardSpamModel.unsubscribeCallback != null ?
      cardSpamModel.unsubscribeCallback!(cardSpamModel.senderId) : null;

  @override
  Future<void> callbackYes(BuildContext context) async =>
      cardSpamModel.keepCallback != null ?
      cardSpamModel.keepCallback!(cardSpamModel.senderId) : null;

  @override
  Widget content(BuildContext context) {
    var shareKey = GlobalKey();
    return Container(
        key: shareKey,
        color: Colors.white,
        child: DecisionSdkSpamLayoutContent(
            shareKey, service, cardSpamModel));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DecisionSdkSpamLayout &&
          runtimeType == other.runtimeType &&
          cardSpamModel == other.cardSpamModel &&
          service == other.service;

  @override
  int get hashCode => cardSpamModel.hashCode ^ service.hashCode;
}
