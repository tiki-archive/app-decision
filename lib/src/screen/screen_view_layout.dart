/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screen_service.dart';
import 'screen_view_layout_empty.dart';
import 'screen_view_layout_link.dart';
import 'screen_view_layout_stack.dart';
import 'screen_view_widget_card.dart';

class ScreenViewLayout extends StatelessWidget {
  const ScreenViewLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenService service = Provider.of<ScreenService>(context);
    return service.model.isLinked
        ? LayoutBuilder(
            builder: (context, constraints) => ScreenViewLayoutStack(
                noCardsPlaceholder: const ScreenViewLayoutEmpty(),
                children: service.model.cards
                    .getRange(
                        0,
                        service.model.cards.length >= 3
                            ? 3
                            : service.model.cards.length)
                    .map((card) => ScreenViewWidgetCard(
                        constraints: constraints,
                        onSwipeRight: () => service.controller.removeCard(
                            context: context,
                            index: service.model.cards.indexOf(card),
                            callback: card.callbackYes),
                        onSwipeLeft: () => service.controller.removeCard(
                            context: context,
                            index: service.model.cards.indexOf(card),
                            callback: card.callbackNo),
                        child: card.content(context)))
                    .toList()))
        : const ScreenViewLayoutLink();
  }
}
