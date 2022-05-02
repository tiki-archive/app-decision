/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:tiki_kv/tiki_kv.dart';

import 'test_card_controller.dart';
import 'test_card_model.dart';

class TestCardService {
  static const String _testDoneKey = 'test_done_callback';
  final TikiKv _tikiKv;
  late final TestCardController controller;

  TestCardService(this._tikiKv) {
    controller = TestCardController(this);
  }

  Future<void> done() => _tikiKv.upsert(_testDoneKey, 'true');

  List<TestCardModel> get() =>
      List<TestCardModel>.generate(3, (index) => TestCardModel(index))
          .reversed
          .toList();
}
