/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';

import '../../tiki_decision_card.dart';
import '../test_card/test_card_service.dart';
import 'screen_controller.dart';
import 'screen_model.dart';
import 'screen_presenter.dart';

class ScreenService extends ChangeNotifier {
  final ScreenModel model = ScreenModel();
  late final ScreenPresenter presenter;
  late final ScreenController controller;

  final TestCardService _testCardService;

  ScreenService(
    this._testCardService, {
    bool isConnected = false,
  }) {
    presenter = ScreenPresenter(this);
    controller = ScreenController(this);
  }

  void upsert(Map<String, TikiDecisionCard> cards) {
    model.cards.addAll(cards);
    cards.removeWhere((id, card) => model.stack.contains(id));
    model.stack.addAll(cards.keys);
  }

  void removeCardAt(int index) => removeCard(model.stack.elementAt(index));

  void removeCard(String id) {
    model.cards.remove(id);
    model.stack.remove(id);
    notifyListeners();
  }

  Future<void> testDone() async {
    model.isTestDone = true;
    await _testCardService.done();
    notifyListeners();
  }

  Future<void> addTests() async {
    upsert(await _testCardService.get());
    model.testCardsAdded = true;
    model.isPending = true;
  }

  void setLinked(bool isLinked) {
    model.isLinked = isLinked;
    notifyListeners();
  }

  Map<String, TikiDecisionCard> get(int num) {
    Iterable<String> ids = model.stack
        .getRange(0, model.stack.length >= num ? num : model.stack.length);
    Map<String, TikiDecisionCard> cards = {};
    for (String id in ids) {
      if (model.cards.containsKey(id)) cards[id] = model.cards[id]!;
    }
    return cards;
  }
}
