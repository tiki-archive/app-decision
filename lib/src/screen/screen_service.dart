/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter/cupertino.dart';

import '../../tiki_decision_card.dart';
import '../overlay/overlay_service.dart';
import '../test/test_service.dart';
import 'screen_controller.dart';
import 'screen_model.dart';
import 'screen_presenter.dart';

class ScreenService extends ChangeNotifier {
  late final ScreenModel model;
  late final ScreenPresenter presenter;
  late final ScreenController controller;
  late final OverlayService overlay;

  final TestService testService;

  Amplitude? amplitude;

  ScreenService(this.testService, {
    bool? isLinked,
    int? indexedEmails,
    int? fetchedEmails,
    this.amplitude}) {
    presenter = ScreenPresenter(this);
    controller = ScreenController(this);
    overlay = OverlayService();
    model = ScreenModel(
        isLinked: isLinked ?? false,
        isPending: false,
        indexedEmails: indexedEmails ?? 0,
        fetchedEmails: fetchedEmails ?? 0);
  }

  void upsert(Map<String, TikiDecisionCard> cards) {
    model.cards.addAll(cards);
    cards.removeWhere((id, card) => model.stack.contains(id));
    model.stack.addAll(cards.keys);
    notifyListeners();
  }

  void removeCardAt(int index) => removeCard(model.stack.elementAt(index));

  void removeCard(String id) {
    model.cards.remove(id);
    model.stack.remove(id);
    notifyListeners();
  }

  Future<void> addTests() async {
    if(!(await testService.isDone())) {
      upsert(await testService.get());
      model.isPending = true;
    }
    notifyListeners();
  }

  Future<void> setLinked(bool isLinked) async {
    model.isLinked = isLinked;
    if(!(await testService.isDone())) { overlay.setInstructions(); }
    notifyListeners();
  }

  void addIndexedEmails(int count) {
    model.indexedEmails += count;
    notifyListeners();
  }

  void addFetchedEmails(int count) {
    if(model.fetchedEmails + count > model.indexedEmails) {
      model.fetchedEmails = model.indexedEmails;
    }else{
      model.fetchedEmails += count;
    }
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
    model.indexedEmails = 0;
    model.fetchedEmails = 0;
    notifyListeners();
  }

  void setPending(bool isPending) {
    model.isPending = isPending;
    notifyListeners();
  }

  void clearWhere(bool Function({String? id, TikiDecisionCard? card}) where) {
    List<String> removeKeys = [];
    model.cards.forEach((key, value) {
      if(where(id: key, card:value)) removeKeys.add(key);
    });
    for (var key in removeKeys) {
      model.cards.remove(key);
    }
    notifyListeners();
  }
}
