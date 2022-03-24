import 'package:flutter/cupertino.dart';
import 'package:tiki_kv/tiki_kv.dart';

import 'decision_controller.dart';
import 'decision_presenter.dart';
import 'decision_style.dart';
import 'model/decision_model.dart';
import 'model/decision_tiki_kv_keys.dart';
import 'ui/decision_view_card_test.dart';

class DecisionSdkService extends ChangeNotifier {
  late final DecisionSdkModel model;
  late final DecisionSdkPresenter presenter;
  late final DecisionSdkController controller;
  late final DecisionSdkStyle style;

  final TikiKv? tikiKv;

  DecisionSdkService({
    required this.style,
    required this.tikiKv,
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
    if (tikiKv != null) {
      tikiKv!.upsert(DecisionTikiKvKeys.test_done_callback.name, 'true');
    }
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
