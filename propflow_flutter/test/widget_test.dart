import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:propflow_flutter/main.dart';

void main() {
  testWidgets('Welcome screen shows headline and CTAs', (tester) async {
    await tester.pumpWidget(const PropFlowApp());

    expect(find.text('Welcome to the app'), findsOneWidget);
    expect(find.text('Property Management'), findsOneWidget);
    expect(find.text('Property Maintenance'), findsOneWidget);
  });
}
