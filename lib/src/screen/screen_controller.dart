/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'screen_service.dart';

class ScreenController {
  final ScreenService service;

  ScreenController(this.service);

  Future<void> removeCard(
      {required String id, Future<void> Function()? callback}) async {
    if (callback != null) await callback();
    service.removeCard(id);
  }
}
