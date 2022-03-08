import 'package:decision_sdk/src/model/security_score_modal_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../src/decision_service.dart';
import 'ui/decision_layout.dart';
import 'ui/security_score_modal/security_score_modal_layout.dart';

class DecisionSdkPresenter {
  final DecisionSdkService service;

  DecisionSdkPresenter(this.service);

  ChangeNotifierProvider<DecisionSdkService> home() {
    return ChangeNotifierProvider.value(
        value: service, child: const DecisionSdkLayout());
  }

  Future<void> showModal(BuildContext context, SecurityScoreModalModel model) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(service.style.size(26)))),
        builder: (BuildContext context) =>
            SecurityScoreModalLayout(model, service.style));
  }
}
