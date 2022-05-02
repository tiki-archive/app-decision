/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../screen/screen_service.dart';
import 'test_card_service.dart';

class TestCardController {
  final TestCardService _service;

  TestCardController(this._service);

  void done(BuildContext context, int num) {
    if (num + 1 == 3) {
      Provider.of<ScreenService>(context, listen: false).testDone();
    }
  }
}
