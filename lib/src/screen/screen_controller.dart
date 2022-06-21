/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'screen_service.dart';

class ScreenController {
  final ScreenService service;

  ScreenController(this.service);

  Future<void> swipeYes(
      {required String id, Future<void> Function()? callback}) async {
    if(service.amplitude != null && await service.testService.isDone()) {
      service.amplitude!.logEvent("SWIPE_YES");
    }
    _swipeToRemove(id: id, callback: callback);
  }

  Future<void> swipeNo(
      {required String id, Future<void> Function()? callback}) async {
    if(service.amplitude != null && await service.testService.isDone()) {
      service.amplitude!.logEvent("SWIPE_NO");
    }
    _swipeToRemove(id: id, callback: callback);
  }

  Future<void> _swipeToRemove(
      {required String id, Future<void> Function()? callback}) async {
    if (callback != null) callback();
    service.removeCard(id);
  }
}
