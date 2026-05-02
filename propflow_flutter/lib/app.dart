import 'package:flutter/material.dart';

import 'router/app_router.dart';
import 'theme/theme.dart';

class PropFlowApp extends StatelessWidget {
  const PropFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'PropFlow',
      theme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
