/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:amplitude_flutter/amplitude.dart';
import 'package:example/widgety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:tiki_decision/tiki_decision.dart';
import 'package:tiki_decision/src/test/card/test_card_layout.dart';
import 'package:tiki_decision/tiki_decision_card.dart';
import 'package:tiki_decision/src/screen/screen_view_widget_card.dart';
import 'package:tiki_kv/tiki_kv.dart';
import 'package:uuid/uuid.dart';

void main() {

  group('Decision Tests', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets(
        'Test decision screen with email count', (WidgetTester tester) async {
      int totalEmails = 1000;
      int indexedEmails = 0;
      int fetchedEmails = 0;
      WidgetsFlutterBinding.ensureInitialized();
      Database database = await openDatabase('${const Uuid().v4()}.db');
      TikiKv tikiKv = await TikiKv(database: database).init();
      TikiDecision decision = await TikiDecision(
          tikiKv: tikiKv, isLinked: false).init();

      Future<void> fetchEmail() async {
        while (fetchedEmails < indexedEmails) {
          fetchedEmails += 1;
          decision.addFetchedEmails(1);
          await tester.pumpAndSettle(const Duration(microseconds: 10));
        }
      }

      Future<void> indexEmail() async {
        indexedEmails += 500;
        decision.addIndexedEmails(500);
      }

      runApp(MaterialApp(
        title: 'Decision Example',
        theme: ThemeData(),
        home: Scaffold(
          body: Widgety(decision),
        ),
      ));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      decision.setLinked(true);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 1));
      Finder cards = find.byType(TestCardLayout);
      for (int i = 0; i < 3; i++) {
        Finder card = cards.first;
        await tester.drag(card, const Offset(500.0, 0.0));
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 1));
      }
      while (indexedEmails < totalEmails) {
        await indexEmail();
        await tester.pumpAndSettle(const Duration(milliseconds: 1));
      }
      await fetchEmail();
      decision.setPending(false);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 3));
      expect(indexedEmails, totalEmails);
      expect(fetchedEmails, totalEmails);
    });

    testWidgets(
        'Test done, no cards, empty screen', (WidgetTester tester) async {
      WidgetsFlutterBinding.ensureInitialized();
      Database database = await openDatabase('${const Uuid().v4()}.db');
      TikiKv tikiKv = await TikiKv(database: database).init();
      await tikiKv.upsert('test_done_callback', 'true');
      TikiDecision decision = await TikiDecision(tikiKv: tikiKv, isLinked: true)
          .init();
      runApp(MaterialApp(
        title: 'Decision Example',
        theme: ThemeData(),
        home: Scaffold(
          body: Widgety(decision),
        ),
      ));
      await tester.pumpAndSettle();
      Finder cardsWidgets = find.byType(ScreenViewWidgetCard);
      int count = tester
          .widgetList<ScreenViewWidgetCard>(cardsWidgets)
          .length;
      expect(count, 0);
    });

    testWidgets(
        'Add cards for 2 accounts. Remove cards for one account.  ', (WidgetTester tester) async {
      WidgetsFlutterBinding.ensureInitialized();
      Database database = await openDatabase('${const Uuid().v4()}.db');
      TikiKv tikiKv = await TikiKv(database: database).init();
      await tikiKv.upsert('test_done_callback', 'true');
      TikiDecision decision = await TikiDecision(tikiKv: tikiKv, isLinked: true)
          .init();
      Map<String, TikiDecisionCard> cards = _generateCards();
      decision.upsert(cards);
      runApp(MaterialApp(
        title: 'Decision Example',
        theme: ThemeData(),
        home: Scaffold(
          body: Widgety(decision),
        ),
      ));
      await tester.pumpAndSettle();
      Finder cardsWidgets = find.byType(ScreenViewWidgetCard);
      int count = tester.widgetList<ScreenViewWidgetCard>(cardsWidgets).length;
      expect(count, 3);
      decision.clearWhere(({card, id}) => card is TestSpamCard && card.accountId == 0);
      await tester.pumpAndSettle();
      count = tester.widgetList<ScreenViewWidgetCard>(cardsWidgets).length;
      expect(count, 1);
    });

    testWidgets(
        'Make 2 decisions and log in amplitude (needs manual confirmation)', (WidgetTester tester) async {
      WidgetsFlutterBinding.ensureInitialized();
      Database database = await openDatabase('${const Uuid().v4()}.db');
      TikiKv tikiKv = await TikiKv(database: database).init();
      await tikiKv.upsert('test_done_callback', 'true');
      Amplitude amplitude = Amplitude.getInstance(instanceName: "App-test");
      await amplitude.init("6f52993a138d9209786c76a03c4e25cf");
      await amplitude.enableCoppaControl();
      await amplitude.setUserId(null);
      await amplitude.trackingSessionEvents(true);
      TikiDecision decision = await TikiDecision(
          tikiKv: tikiKv,
          isLinked: true,
          amplitude: amplitude)
          .init();
      Map<String, TikiDecisionCard> cards = _generateCards();
      decision.upsert(cards);
      runApp(MaterialApp(
        title: 'Decision Example',
        theme: ThemeData(),
        home: Scaffold(
          body: Widgety(decision),
        ),
      ));
      await tester.pumpAndSettle();
      Finder cardsWidgets = find.byType(ScreenViewWidgetCard);
      int count = tester.widgetList<ScreenViewWidgetCard>(cardsWidgets).length;
      expect(count, 3);
      for (int i = 0; i < 2; i++) {
        Finder card = cardsWidgets.first;
        await tester.drag(card, const Offset(500.0, 0.0));
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 1));
      }
    });
  });
}

Map<String, TikiDecisionCard> _generateCards() {
  Map<String, TikiDecisionCard> cards = {};
  for(int i = 0; i < 3; i++){
    cards[i.toString()] = TestSpamCard(i%2);
  }
  return cards;
}

class TestSpamCard extends TikiDecisionCard {
  final int accountId;

  TestSpamCard(this.accountId);

  @override
  Future<void> callbackNo() async {
    // do nothing
  }

  @override
  Future<void> callbackYes() async {
    // do nothing
  }

  @override
  Widget content(){
    return const Center(child:Text('test spam card'));
  }
}

