import 'package:flutter/material.dart';

import 'src/decision_service.dart';
import 'src/decision_style.dart';

export 'src/ui/decision_abstract_card.dart';
export 'src/model/decision_card_spam_model.dart';

class DecisionSdk {
  late final DecisionSdkService _service;

  dynamic apiAuthService;

  DecisionSdk({
    DecisionSdkStyle? style,
    bool isConnected = false,
    appiAppDataService,
    this.apiAuthService,
    apiEmailSenderService,
    apiEmailMsgService,
    dataFetchService,
    }) : _service = DecisionSdkService(
      style: style ?? DecisionSdkStyle(),
      isConnected: isConnected,
      appiAppDataService: appiAppDataService,
      apiAuthService: apiAuthService,
      apiEmailSenderService: apiEmailSenderService,
      apiEmailMsgService: apiEmailMsgService,
      dataFetchService: dataFetchService
  );

  Future<DecisionSdk> init() async{
    _service.model.isLinked = await apiAuthService.getAccount();
    await _service.addTests();
    await _service.getCards();
    return this;
  }

  Widget home({bool example = false}) => _service.presenter.home();

}
