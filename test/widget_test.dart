// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/data/localservices/cache_local_services.dart';
import 'package:restaurant/firebase_options.dart';
import 'package:restaurant/view/screens/home_screen.dart';
import 'package:restaurant/view/screens/login_screen.dart';

import '../lib/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();

    Widget pushNext;
    SharedCache.cacheInit();
    String uid = SharedCache.getLastLoggedIn('lastUser') ?? '';
    if (uid != '') {
      pushNext = LoginPage();
    } else {
      pushNext = HomeScreen();
    }

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    runApp(MyApp(
      pushNext: pushNext,
    ));
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      pushNext: pushNext,
    ));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
