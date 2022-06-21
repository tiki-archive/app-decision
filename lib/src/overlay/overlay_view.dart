import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'overlay_service.dart';
import 'overlay_view_completed.dart';
import 'overlay_view_instructions.dart';

class OverlayView extends StatelessWidget{

  const OverlayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getChild(context)
    );
  }



  Widget _getChild(BuildContext context) {
    OverlayService service = Provider.of<OverlayService>(context);
    switch(service.current){
      case 1:
        return const OverlayViewInstructions();
      case 2:
        return const OverlayViewCompleted();
      default:
        return Container();
    }
  }
}