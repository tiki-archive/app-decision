/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:amplitude_flutter/amplitude.dart';
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
    Amplitude? amplitude
  }) : _screenService = ScreenService(
          TestService(tikiKv),
          isLinked: isLinked,
          amplitude: amplitude
        );

  Future<TikiDecision> init() async {
    await _screenService.addTests();
    return this;
  }

  Widget get widget => _screenService.presenter.home();

  Widget get overlay => _screenService.presenter.overlay();

  void upsert(Map<String, TikiDecisionCard> cards) =>
      _screenService.upsert(cards);

  void clearWhere(bool Function({String? id, TikiDecisionCard? card}) where) =>
      _screenService.clearWhere(where);

  void setLinked(bool isLinked) => _screenService.setLinked(isLinked);
  void setPending(bool isPending) => _screenService.setPending(isPending);
  void addIndexedEmails(int count) => _screenService.addIndexedEmails(count);
  void addFetchedEmails(int count) => _screenService.addFetchedEmails(count);
}
