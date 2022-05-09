/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:tiki_kv/tiki_kv.dart';

import 'src/screen/screen_service.dart';
import 'src/test/test_service.dart';
import 'tiki_decision_card.dart';

class TikiDecision {
  late final ScreenService _screenService;

  TikiDecision({
    required TikiKv tikiKv,
    bool isLinked = false,
  }) : _screenService = ScreenService(
          TestService(tikiKv),
          isLinked: isLinked,
        );

  Future<TikiDecision> init() async {
    await _screenService.addTests();
    return this;
  }

  Widget get widget => _screenService.presenter.home();

  void upsert(Map<String, TikiDecisionCard> cards) =>
      _screenService.upsert(cards);

  void setLinked(bool isLinked) => _screenService.setLinked(isLinked);
}
