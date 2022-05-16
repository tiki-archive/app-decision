/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';

import '../../tiki_decision_card.dart';
import '../test/test_service.dart';
import 'screen_controller.dart';
import 'screen_model.dart';
import 'screen_presenter.dart';

class ScreenService extends ChangeNotifier {
  late final ScreenModel model;
  late final ScreenPresenter presenter;
  late final ScreenController controller;

  final TestService testService;

  ScreenService(this.testService, {bool isLinked = false}) {
    presenter = ScreenPresenter(this);
    controller = ScreenController(this);
    model = ScreenModel(isLinked: isLinked);
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

  Future<void> addTests() async {
    upsert(await testService.get());
    model.isPending = true;
    notifyListeners();
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

  void clear() {
    model.stack = [];
    model.cards = {};
    notifyListeners();
  }
}
