import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/hero_tags.dart';
import '../../core/portfolio_mode.dart';
import '../../router/app_router.dart';
import '../../theme/theme.dart';
import '../../widgets/luxury_gradient_cta.dart';

/// Entry screen — elevated beyond the wireframe: editorial typography, staggered
/// reveal, and [Hero] continuity into the command center.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(decoration: BoxDecoration(gradient: AppGradients.studioBackdrop)),
          Positioned(
            top: -120,
            right: -80,
            child: IgnorePointer(
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.champagne.withOpacity(0.14),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(26, 36, 26, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: Colors.white.withOpacity(0.12)),
                          color: Colors.white.withOpacity(0.04),
                        ),
                        child: Text(
                          'PropFlow Atelier',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppColors.champagne,
                            fontSize: 11,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 420.ms, curve: Curves.easeOutCubic)
                      .slideX(begin: -0.04, curve: Curves.easeOutCubic),
                  const SizedBox(height: 28),
                  Text(
                    'Welcome to\nthe experience',
                    style: theme.textTheme.displayLarge,
                  )
                      .animate()
                      .fadeIn(duration: 520.ms, delay: 80.ms, curve: Curves.easeOutCubic)
                      .slideY(begin: 0.12, curve: Curves.easeOutCubic),
                  const SizedBox(height: 16),
                  Text(
                    'Select how you’d like to orchestrate your portfolio today — '
                    'operations and stewardship, tuned to a single standard.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.mist.withOpacity(0.92),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 520.ms, delay: 160.ms, curve: Curves.easeOutCubic)
                      .slideY(begin: 0.08, curve: Curves.easeOutCubic),
                  const Spacer(),
                  LuxuryGradientCta(
                    label: 'Property Management',
                    gradient: AppGradients.management,
                    heroTag: AppHeroTags.managementCta,
                    onPressed: () {
                      context.go(AppRoutes.dashboard, extra: PortfolioMode.management);
                    },
                  )
                      .animate()
                      .fadeIn(duration: 520.ms, delay: 380.ms, curve: Curves.easeOutCubic)
                      .slideY(begin: 0.12, curve: Curves.easeOutCubic)
                      .shimmer(
                        delay: 900.ms,
                        duration: 1200.ms,
                        color: Colors.white.withOpacity(0.18),
                      ),
                  const SizedBox(height: 14),
                  LuxuryGradientCta(
                    label: 'Property Maintenance',
                    gradient: AppGradients.maintenance,
                    heroTag: AppHeroTags.maintenanceCta,
                    onPressed: () {
                      context.go(AppRoutes.dashboard, extra: PortfolioMode.maintenance);
                    },
                  )
                      .animate()
                      .fadeIn(duration: 520.ms, delay: 520.ms, curve: Curves.easeOutCubic)
                      .slideY(begin: 0.14, curve: Curves.easeOutCubic),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      'Private · Secure · Composed',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        letterSpacing: 1.6,
                        fontSize: 11,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 640.ms, curve: Curves.easeOut),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
