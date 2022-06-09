import 'overlay_service.dart';

class OverlayController{
  final OverlayService service;

  OverlayController(this.service);

  void dismiss(){
    service.dismiss();
  }
}