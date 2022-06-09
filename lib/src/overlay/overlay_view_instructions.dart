import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_style/tiki_style.dart';

import 'overlay_controller.dart';
import 'overlay_service.dart';

class OverlayViewInstructions extends StatelessWidget {

  const OverlayViewInstructions({Key? key}) : super(key: key);

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
          _content()
        ]));
  }

  Widget _content() {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min, children: [
      ImgProvider.swipeCardSample,
      Container(
          margin: EdgeInsets.symmetric(vertical: SizeProvider.instance.height(12), horizontal: SizeProvider.instance.width(12)),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Unsubscribe from an email ',
                  style: TextStyle(
                      package: TextProvider.package,
                      color: ColorProvider.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: TextProvider.familyNunitoSans,
                      fontSize: SizeProvider.instance.text(12)),
                  children: const [
                    TextSpan(
                        text: 'list by swiping left, or\n',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: 'keep their emails coming ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: 'by swiping right.',
                        style: TextStyle(fontWeight: FontWeight.w600))
                  ]))),
      Container(
          margin: EdgeInsets.only(top: SizeProvider.instance.height(12), left: SizeProvider.instance.width(12), right: SizeProvider.instance.width(12)),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Unsubscribing will remove you from an email list.\n',
                  style: TextStyle(
                      package: TextProvider.package,
                      color: ColorProvider.tikiOrange,
                      fontWeight: FontWeight.w600,
                      fontFamily: TextProvider.familyNunitoSans,
                      fontSize: SizeProvider.instance.text(12)),
                  children: const [
                    TextSpan(
                        text:
                        'You can always re-subscribe by going back to their website.',
                        style: TextStyle(color: ColorProvider.white))
                  ])))
    ]);
  }
}
