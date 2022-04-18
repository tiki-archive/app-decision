import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../decision_service.dart';
import 'decision_view_card.dart';
import 'decision_view_empty.dart';
import 'decision_view_link.dart';
import 'decision_view_stack.dart';

class DecisionLayout extends StatelessWidget {
  const DecisionLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DecisionService service = Provider.of<DecisionService>(context);
    return service.model.isLinked
        ? LayoutBuilder(
            builder: (context, constraints) => DecisionViewStack(
                noCardsPlaceholder: const DecisionViewEmpty(),
                children: service.model.cards
                    .getRange(
                        0,
                        service.model.cards.length >= 3
                            ? 3
                            : service.model.cards.length)
                    .map((card) => DecisionViewCard(
                        constraints: constraints,
                        onSwipeRight: () => service.controller.removeCard(
                            context: context,
                            index: service.model.cards.indexOf(card),
                            callback: card.callbackYes),
                        onSwipeLeft: () => service.controller.removeCard(
                            context: context,
                            index: service.model.cards.indexOf(card),
                            callback: card.callbackNo),
                        style: service.style,
                        child: card.content(context)))
                    .toList()))
        : const DecisionViewLink();
  }
}
