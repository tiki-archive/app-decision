import 'package:flutter/material.dart';

import 'src/decision_service.dart';
import 'src/decision_style.dart';
import 'src/ui/decision_abstract_card.dart';

export 'src/ui/decision_abstract_card.dart';

class DecisionSdk {
  late final DecisionSdkService _service;

  dynamic apiAuthService;

  DecisionSdk({
    DecisionSdkStyle? style,
    bool isConnected = false,
    apiAppDataService,
    this.apiAuthService,
    apiEmailSenderService,
    apiEmailMsgService,
    dataFetchService,
  }) : _service = DecisionSdkService(
            style: style ?? DecisionSdkStyle(),
            isConnected: isConnected,
            apiAppDataService: apiAppDataService,
            apiAuthService: apiAuthService,
            apiEmailSenderService: apiEmailSenderService,
            apiEmailMsgService: apiEmailMsgService,
            dataFetchService: dataFetchService);

  Future<DecisionSdk> init() async {
    _service.model.isLinked = await apiAuthService.getAccount();
    await _service.addTests();
    return this;
  }

  Widget decisionWidget({bool example = false}) => _service.presenter.home();

  void addCards(List<DecisionSdkAbstractCard> cards) =>
      _service.addCards(cards);
}
