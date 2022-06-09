import 'package:flutter/material.dart';

import 'overlay_controller.dart';
import 'overlay_model.dart';
import 'overlay_presenter.dart';

class OverlayService extends ChangeNotifier{
  late final OverlayModel _model;
  late final OverlayController controller;
  late final OverlayPresenter presenter;

  OverlayService(){
        _model = OverlayModel();
        controller = OverlayController(this);
        presenter = OverlayPresenter(this);
  }

  get current => _model.current;

  setCompleted(){
    _model.current = OverlayModel.completed;
    notifyListeners();
  }

  setInstructions(){
    _model.current = OverlayModel.instructions;
    notifyListeners();
  }

  void dismiss() {
    _model.current = 0;
    notifyListeners();
  }
}