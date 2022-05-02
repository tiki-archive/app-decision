/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:tiki_kv/tiki_kv.dart';

import 'src/screen/screen_service.dart';
import 'src/test_card/test_card_service.dart';
import 'tiki_decision_card.dart';

class TikiDecision {
  late final ScreenService _screenService;

  TikiDecision({
    required TikiKv tikiKv,
    bool isConnected = false,
  }) : _screenService = ScreenService(
          TestCardService(tikiKv),
          isConnected: isConnected,
        );

  Future<TikiDecision> init() async {
    await _screenService.addTests();
    return this;
  }

  Widget get widget => _screenService.presenter.home();

  void addCards(List<TikiDecisionCard> cards) => _screenService.addCards(cards);

  void setLinked(bool isLinked) => _screenService.setLinked(isLinked);
}
