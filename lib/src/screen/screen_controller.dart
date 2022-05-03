/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'screen_service.dart';

class ScreenController {
  final ScreenService service;

  ScreenController(this.service);

  void removeCard({required String id, Function()? callback}) {
    if (callback != null) callback();
    service.removeCard(id);
  }
}
