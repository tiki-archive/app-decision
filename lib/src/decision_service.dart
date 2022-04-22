import 'package:flutter/cupertino.dart';
import 'package:tiki_kv/tiki_kv.dart';

import 'decision_controller.dart';
import 'decision_presenter.dart';
import 'model/decision_model.dart';
import 'model/decision_tiki_kv_keys.dart';
import 'ui/decision_view_card_test.dart';

class DecisionService extends ChangeNotifier {
  late final DecisionModel model;
  late final DecisionPresenter presenter;
  late final DecisionController controller;

  final TikiKv? tikiKv;

  DecisionService({
    required this.tikiKv,
    bool isConnected = false,
  }) {
    presenter = DecisionPresenter(this);
    model = DecisionModel();
    controller = DecisionController(this);
  }

  Future<void> addCards(List<dynamic> cards) async {
    for (var card in cards) {
      if (!model.cards.contains(card)) {
        model.cards.add(card);
      }
    }
    if (model.cards.isNotEmpty && model.cards.length <= 3) {
      notifyListeners();
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
      model.cards.addAll(List<DecisionViewCardTest>.generate(
          3, (index) => DecisionViewCardTest(index)).reversed.toList());
      model.testCardsAdded = true;
      model.isPending = true;
    }
  }

  setLinked(bool isLinked){
    model.isLinked = isLinked;
    notifyListeners();
  }
}
