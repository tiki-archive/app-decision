import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

import 'decision_spam_service.dart';
import 'model/decision_model.dart';
import 'decision_controller.dart';
import 'decision_presenter.dart';
import 'decision_style.dart';
import 'ui/decision_abstract_card.dart';
import 'ui/decision_view_card_test.dart';

class DecisionSdkService extends ChangeNotifier {
  final Logger _log = Logger('DecisionSdkService');

  late final DecisionSdkModel model;
  late final DecisionSdkPresenter presenter;
  late final DecisionSdkController controller;
  late final DecisionSdkSpamService spam;
  late final DecisionSdkStyle style;
  late final Function _testDoneCallback;

  DecisionSdkService(
      {required this.style,
      bool isTestDone = false,
      bool isConnected = false,
      Function? testDoneCallback,
      List<DecisionSdkAbstractCard>? cards}) {
    presenter = DecisionSdkPresenter(this);
    model = DecisionSdkModel();
    controller = DecisionSdkController(this);
    spam = DecisionSdkSpamService(this);
    model.isTestDone = isTestDone;
    model.isLinked = isConnected;
    _testDoneCallback = testDoneCallback ?? () => _log.finest('test done');
    if (!model.isTestDone) _addTests();
    if (cards != null) addCards(cards);
  }

  Future<void> addCards(List<dynamic> cards) async {
    for (var card in cards) {
      if (!model.cards.contains(card)) {
        model.cards.add(card);
      }
    }
  }

  void removeAllCards() {
    model.cards = [];
    if (!model.isTestDone) _addTests();
    notifyListeners();
  }

  void removeCard(int index) {
    model.cards.removeAt(index);
    notifyListeners();
  }

  Future<void> testDone() async {
    model.isTestDone = true;
    _testDoneCallback();
  }

  Future<void> _addTests() async {
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
