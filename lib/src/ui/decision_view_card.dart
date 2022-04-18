import 'package:flutter/material.dart';

import '../decision_style.dart';

class DecisionViewCard extends StatefulWidget {
  final Widget child;
  final Function onSwipeRight;
  final Function onSwipeLeft;
  final BoxConstraints constraints;
  final DecisionStyle style;

  const DecisionViewCard(
      {Key? key,
      required this.child,
      required this.onSwipeRight,
      required this.onSwipeLeft,
      required this.constraints,
      required this.style})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DecisionSdkCardViewState();
}

class _DecisionSdkCardViewState extends State<DecisionViewCard> {
  double delta = 0;
  double top = 0;
  double lastDx = 0;

  get angle => delta.abs() / widget.style.size(375) > 45
      ? 45
      : -delta / widget.style.size(375);

  double getopacityYes() {
    if (delta < 0) {
      return 0;
    }
    return delta.abs() * 3 / widget.style.size(375) > 1
        ? 1.0
        : delta.abs() * 3 / widget.style.size(375);
  }

  double getOpacityNo() {
    if (delta > 0) {
      return 0;
    }
    return delta.abs() * 3 / widget.style.size(375) > 1
        ? 1.0
        : delta.abs() * 3 / widget.style.size(375);
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
                left: widget.style.size(7),
                right: widget.style.size(7),
                bottom: widget.style.size(7)),
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
                                Radius.circular(widget.style.size(15))),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                                Radius.circular(widget.style.size(15))),
                            child: widget.child,
                          )),
                      Positioned(
                          left: -60,
                          top: 100,
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Opacity(
                                  opacity: getopacityYes(),
                                  child: Image.asset('res/images/yes-label.png',
                                      height: widget.style.size(240),
                                      package: 'decision')))),
                      Positioned(
                          right: -60,
                          top: 100,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Opacity(
                                opacity: getOpacityNo(),
                                child: Image.asset('res/images/nope-label.png',
                                    height: widget.style.size(240),
                                    package: 'decision')),
                          ))
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
