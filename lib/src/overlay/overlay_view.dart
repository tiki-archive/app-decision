import 'package:flutter/material.dart';

class OverlayView extends StatelessWidget{
  final Widget child;

  const OverlayView(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child
    );
  }

}