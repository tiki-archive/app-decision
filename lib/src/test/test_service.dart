/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_kv/tiki_kv.dart';
import 'package:uuid/uuid.dart';

import '../../tiki_decision_card.dart';
import 'card/test_card_model.dart';
import 'card/test_card_service.dart';

class TestService {
  static const String _testDoneKey = 'test_done_callback';

  final TikiKv _tikiKv;

  TestService(this._tikiKv);

  Future<void> tryDone(int cardNum) async {
    if (cardNum + 1 == 3) {
      await _tikiKv.upsert(_testDoneKey, 'true');
    }
  }

  Future<bool> isDone() async =>
      (await _tikiKv.read(_testDoneKey)) == 'true' ? true : false;

  Future<Map<String, TikiDecisionCard>> get() async {
    return await isDone()
        ? {}
        : Map.fromEntries(List<TikiDecisionCard>.generate(
                3, (index) => TestCardService(TestCardModel(index), this))
            .reversed
            .map((card) => MapEntry(const Uuid().v4(), card)));
  }
}
