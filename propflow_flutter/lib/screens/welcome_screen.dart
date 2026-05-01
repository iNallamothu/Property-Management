import 'package:flutter/material.dart';

import '../widgets/gradient_button.dart';

/// PropFlow Welcome — matches wireframe roles: headline, subcopy, blue management CTA,
/// purple maintenance CTA with diagonal gradients.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const LinearGradient _managementGradient = LinearGradient(
    colors: [
      Color(0xFF1D4ED8),
      Color(0xFF38BDF8),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient _maintenanceGradient = LinearGradient(
    colors: [
      Color(0xFF7C3AED),
      Color(0xFFEC4899),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to the app',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                  letterSpacing: -0.25,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Choose what you’d like to manage today.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: const Color(0xFF475569),
                ),
              ),
              const Spacer(),
              GradientButton(
                label: 'Property Management',
                gradient: _managementGradient,
                onPressed: () {
                  // Navigate to Property Management flow
                },
              ),
              const SizedBox(height: 16),
              GradientButton(
                label: 'Property Maintenance',
                gradient: _maintenanceGradient,
                onPressed: () {
                  // Navigate to Property Maintenance flow
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
