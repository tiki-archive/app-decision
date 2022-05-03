/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/widgets.dart';

import '../../../tiki_decision_card.dart';
import '../test_service.dart';
import 'test_card_layout.dart';
import 'test_card_model.dart';

class TestCardService implements TikiDecisionCard {
  final TestCardModel model;
  final TestService _testService;

  const TestCardService(this.model, this._testService);

  @override
  Future<void> callbackNo() => _testService.tryDone(model.cardNum);

  @override
  Future<void> callbackYes() => _testService.tryDone(model.cardNum);

  @override
  Widget content() => TestCardLayout(model.cardNum);
}
