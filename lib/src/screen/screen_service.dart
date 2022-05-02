/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';

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

  void addCards(List<dynamic> cards) {
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
    await _testCardService.done();
    notifyListeners();
  }

  Future<void> addTests() async {
    model.cards.addAll(await _testCardService.get());
    model.testCardsAdded = true;
    model.isPending = true;
  }

  void setLinked(bool isLinked) {
    model.isLinked = isLinked;
    notifyListeners();
  }
}
