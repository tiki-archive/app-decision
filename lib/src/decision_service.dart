import 'package:flutter/cupertino.dart';

import 'decision_controller.dart';
import 'decision_presenter.dart';
import 'decision_style.dart';
import 'model/decision_model.dart';
import 'ui/decision_view_card_test.dart';

class DecisionSdkService extends ChangeNotifier {
  late final DecisionSdkModel model;
  late final DecisionSdkPresenter presenter;
  late final DecisionSdkController controller;
  late final DecisionSdkStyle style;

  final dynamic apiAppDataService;
  final dynamic apiEmailSenderService;
  final dynamic apiAuthService;
  final dynamic dataFetchService;
  final dynamic apiEmailMsgService;

  DecisionSdkService({
    required this.style,
    required this.apiAppDataService,
    required this.apiEmailSenderService,
    required this.apiAuthService,
    required this.dataFetchService,
    required this.apiEmailMsgService,
    bool isConnected = false,
  }) {
    presenter = DecisionSdkPresenter(this);
    model = DecisionSdkModel();
    controller = DecisionSdkController(this);
  }

  Future<void> addCards(List<dynamic> cards) async {
    for (var card in cards) {
      if (!model.cards.contains(card)) {
        model.cards.add(card);
      }
    }
  }

  void removeCard(int index) {
    model.cards.removeAt(index);
    notifyListeners();
  }

  Future<void> testDone() async {
    model.isTestDone = true;
    apiAppDataService.saveByStringKey('test_done_bool', 'true');
    notifyListeners();
  }

  Future<void> addTests() async {
    if (!model.isTestDone && !model.testCardsAdded) {
      model.cards.addAll(List<DecisionSdkViewCardTest>.generate(
              3, (index) => DecisionSdkViewCardTest(index, style))
          .reversed
          .toList());
      model.testCardsAdded = true;
      model.isPending = true;
    }
  }
}
