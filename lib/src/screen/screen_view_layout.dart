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
                children: service
                    .get(3)
                    .entries
                    .map((entry) => ScreenViewWidgetCard(
                        constraints: constraints,
                        onSwipeRight: () => service.controller.removeCard(
                            id: entry.key, callback: entry.value.callbackYes),
                        onSwipeLeft: () => service.controller.removeCard(
                            id: entry.key, callback: entry.value.callbackNo),
                        child: entry.value.content()))
                    .toList()
                    .reversed
                    .toList()))
        : const ScreenViewLayoutLink();
  }
}
