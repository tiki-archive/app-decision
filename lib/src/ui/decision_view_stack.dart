import 'package:flutter/material.dart';
import 'package:style/style.dart';

class DecisionViewStack extends StatelessWidget {
  final List<Widget> children;
  final Widget noCardsPlaceholder;

  const DecisionViewStack(
      {Key? key, required this.noCardsPlaceholder, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(SizeProvider.instance.size(15)))),
        width: double.infinity,
        child: Stack(clipBehavior: Clip.none, children: [
          noCardsPlaceholder,
          ...children,
        ]));
  }
}
