import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';

void main() {
  runApp(const PropFlowApp());
}

class PropFlowApp extends StatelessWidget {
  const PropFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PropFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
