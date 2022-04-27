import 'package:flutter/material.dart';
import 'package:tiki_style/tiki_style.dart';

class DecisionViewCard extends StatefulWidget {
  final Widget child;
  final Function onSwipeRight;
  final Function onSwipeLeft;
  final BoxConstraints constraints;

  const DecisionViewCard(
      {Key? key,
      required this.child,
      required this.onSwipeRight,
      required this.onSwipeLeft,
      required this.constraints,
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DecisionSdkCardViewState();
}

class _DecisionSdkCardViewState extends State<DecisionViewCard> {
  double delta = 0;
  double top = 0;
  double lastDx = 0;

  get angle => delta.abs() / SizeProvider.instance.size(375) > 45
      ? 45
      : -delta / SizeProvider.instance.size(375);

  double getopacityYes() {
    if (delta < 0) {
      return 0;
    }
    return delta.abs() * 3 / SizeProvider.instance.size(375) > 1
        ? 1.0
        : delta.abs() * 3 / SizeProvider.instance.size(375);
  }

  double getOpacityNo() {
    if (delta > 0) {
      return 0;
    }
    return delta.abs() * 3 / SizeProvider.instance.size(375) > 1
        ? 1.0
        : delta.abs() * 3 / SizeProvider.instance.size(375);
  }

  get left => delta;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: delta,
        top: top,
        child: Container(
            width: widget.constraints.maxWidth,
            height: widget.constraints.maxHeight,
            padding: EdgeInsets.only(
                left: SizeProvider.instance.size(7),
                right: SizeProvider.instance.size(7),
                bottom: SizeProvider.instance.size(7)),
            child: GestureDetector(
                onPanEnd: onDragEnd,
                onPanUpdate: onDragUpdate,
                child: Transform(
                    transform: Matrix4.rotationZ(angle),
                    alignment: FractionalOffset.topCenter,
                    child: Stack(clipBehavior: Clip.none, children: [
                      Container(
                          decoration: BoxDecoration(
                            boxShadow: angle.abs() > 0
                                ? [
                                    const BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        spreadRadius: 0,
                                        offset: Offset(-3, 4))
                                  ]
                                : [],
                            borderRadius: BorderRadius.all(
                                Radius.circular(SizeProvider.instance.size(15))),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                                Radius.circular(SizeProvider.instance.size(15))),
                            child: widget.child,
                          )),
                      Positioned(
                          left: -60,
                          top: 100,
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Opacity(
                                  opacity: getopacityYes(),
                                  child: SizedBox(
                                      height: SizeProvider.instance.size(240),
                                      child: ImgProvider.yesLabel)))),
                      Positioned(
                          right: -60,
                          top: 100,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Opacity(
                                opacity: getOpacityNo(),
                                child: SizedBox(
                                    height: SizeProvider.instance.size(240),
                                    child: ImgProvider.nopeLabel)))),
                    ])))));
  }

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      top += details.delta.dy;
      delta += details.delta.dx;
    });
  }

  void onDragEnd(DragEndDetails details) {
    if (delta > 100) {
      widget.onSwipeRight();
    } else if (delta < -100) {
      widget.onSwipeLeft();
    }
    setState(() {
      delta = 0;
      top = 0;
    });
  }
}
