import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:propflow_flutter/app.dart';

void main() {
  testWidgets('Welcome shows branded headline and CTAs', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: PropFlowApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Welcome'), findsOneWidget);
    expect(find.text('Property Management'), findsOneWidget);
    expect(find.text('Property Maintenance'), findsOneWidget);
  });
}
