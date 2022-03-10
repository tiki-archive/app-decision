import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

import 'decision_spam_service.dart';
import 'model/decision_model.dart';
import 'decision_controller.dart';
import 'decision_presenter.dart';
import 'decision_style.dart';
import 'ui/decision_view_card_test.dart';

class DecisionSdkService extends ChangeNotifier {
  final Logger _log = Logger('DecisionSdkService');

  late final DecisionSdkModel model;
  late final DecisionSdkPresenter presenter;
  late final DecisionSdkController controller;
  late final DecisionSdkSpamService spam;
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
    spam = DecisionSdkSpamService(this);
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
    appiAppDataService.saveByStringKey('test_done_bool', 'true');
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

  Future<void> getCards() async {
    String? provider = (await apiAuthService.getAccount())?.provider;
    if(provider != null) {
      List senders = await apiEmailSenderService.getUnsubscribed();
      Map<String, List> messages = await apiEmailMsgService.getBySenders(senders);
      for (var sender in senders) {
        List? msgs = messages[sender.email!];
        if (msgs != null && msgs.isNotEmpty) {
          spam.addCards(
              messages: msgs,
              provider: provider);
        }
      }
    }
  }
}
