import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  testWidgets('SettingsView displays profile inputs and news switch', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsView()));

    expect(find.text('Customer Profile'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(Switch), findsOneWidget);
    expect(find.text('Save Settings'), findsOneWidget);
  });

  testWidgets('Editing profile and saving displays a confirmation', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsView()));

    await tester.enterText(find.widgetWithText(TextField, 'Full name'), 'Alex Smith');
    await tester.enterText(
      find.widgetWithText(TextField, 'Email address'),
      'alex@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Phone number'),
      '07000000000',
    );
    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);

    await tester.tap(find.text('Save Settings'));
    await tester.pump();
    expect(find.text('Settings saved for Alex Smith'), findsOneWidget);
  });
}
