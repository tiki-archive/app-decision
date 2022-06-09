import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_style/tiki_style.dart';

import 'overlay_controller.dart';
import 'overlay_service.dart';

class OverlayViewCompleted extends StatelessWidget{

  OverlayViewCompleted();


  @override
  Widget build(BuildContext context) {
    OverlayController controller =
        Provider.of<OverlayService>(context, listen: false).controller;
    return GestureDetector(
        onTap: () => controller.dismiss(),
        behavior: HitTestBehavior.translucent,
        child: Stack(
            alignment: Alignment.center,
            children: [
              Image(
                image: ImgProvider.overlayBg.image,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Image(
                image: ImgProvider.confetti.image,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
              Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Well done!',
                style: TextStyle(
                    package: TextProvider.package,
                    color: ColorProvider.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: TextProvider.familyKoara,
                    fontSize: SizeProvider.instance.text(42)),),
                Padding(padding: EdgeInsets.symmetric(vertical: SizeProvider.instance.height(12))),
                Padding(padding: EdgeInsets.symmetric(horizontal: SizeProvider.instance.width(42)),
                    child: Text('You’ve made all your data decisions for today.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      package: TextProvider.package,
                      color: ColorProvider.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: TextProvider.familyNunitoSans,
                      fontSize: SizeProvider.instance.text(22)),),
                )])
            ]));
  }
}