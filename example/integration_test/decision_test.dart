/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:example/widgety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:tiki_decision/tiki_decision.dart';
import 'package:tiki_decision/src/test/card/test_card_layout.dart';
import 'package:tiki_kv/tiki_kv.dart';
import 'package:uuid/uuid.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Decision Tests', () {
    testWidgets('Test decision screen with email count', (WidgetTester tester) async {
      int totalEmails = 1000;
      int indexedEmails = 0;
      int fetchedEmails = 0;
      WidgetsFlutterBinding.ensureInitialized();
      Database database = await openDatabase('${const Uuid().v4()}.db');
      TikiKv tikiKv = await TikiKv(database: database).init();
      TikiDecision decision = await TikiDecision(tikiKv: tikiKv, isLinked: false).init();

      Future<void> fetchEmail() async {
        while(fetchedEmails < indexedEmails){
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
      await Future.delayed(const Duration(seconds:2));
      decision.setLinked(true);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds:1));
      Finder cards = find.byType(TestCardLayout);
      for(int i = 0; i < 3; i++){
        Finder card = cards.first;
        await tester.drag(card, const Offset(500.0, 0.0));
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds:1));
      }
      while(indexedEmails < totalEmails) {
        await indexEmail();
        await tester.pumpAndSettle(const Duration(milliseconds:1));
      }
      await fetchEmail();
      decision.setPending(false);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 3));
      expect(indexedEmails, totalEmails);
      expect(fetchedEmails, totalEmails);
    });
  });
}

