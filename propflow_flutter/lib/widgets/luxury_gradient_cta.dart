import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Primary call-to-action with diagonal gradients from the wireframe.
///
/// [heroTag] enables continuity into [DashboardScreen] via [Hero].
class LuxuryGradientCta extends StatelessWidget {
  const LuxuryGradientCta({
    super.key,
    required this.label,
    required this.gradient,
    required this.heroTag,
    this.onPressed,
  });

  final String label;
  final LinearGradient gradient;
  final Object heroTag;
  final VoidCallback? onPressed;

  static const double _height = 56;
  static const double _radius = 18;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Colors.white,
          letterSpacing: 0.5,
          fontSize: 15,
        );

    final core = SizedBox(
      height: _height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_radius),
                gradient: AppGradients.panelShimmer,
              ),
            ),
          ),
          Text(label, style: labelStyle),
        ],
      ),
    );

    final gradientBox = DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: [
          BoxShadow(
            color: gradient.colors.first.withOpacity(0.35),
            blurRadius: 28,
            spreadRadius: -4,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            blurRadius: 22,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: onPressed != null
          ? InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(_radius),
              splashColor: Colors.white.withOpacity(0.18),
              highlightColor: Colors.white.withOpacity(0.06),
              child: core,
            )
          : core,
    );

    return Hero(
      tag: heroTag,
      flightShuttleBuilder: (
        flightContext,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ) {
        return Material(
          color: Colors.transparent,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(_radius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: SizedBox(
              height: _height,
              width: double.infinity,
              child: Center(
                child: Text(
                  label,
                  style: labelStyle,
                ),
              ),
            ),
          ),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: gradientBox,
      ),
    );
  }
}
