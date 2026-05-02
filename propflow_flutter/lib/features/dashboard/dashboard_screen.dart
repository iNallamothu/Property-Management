import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/hero_tags.dart';
import '../../core/portfolio_mode.dart';
import '../../router/app_router.dart';
import '../../theme/theme.dart';
import '../../widgets/luxury_gradient_cta.dart';
import 'dashboard_providers.dart';

/// Command center — portfolio analytics, estates, and service ops (prototype data).
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key, required this.mode});

  final PortfolioMode mode;

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  static const _estates = [
    _Estate('Velvet Ridge Estate', 'Aspen · Mountain', '98%', Icons.villa_outlined),
    _Estate('Harbourlights Residence', 'Monaco · Waterfront', '100%', Icons.apartment_outlined),
    _Estate('Atlas Penthouse', 'New York · Sky', '94%', Icons.domain_outlined),
  ];

  static const _workOrders = [
    _WorkOrder('Elevator certification', 'Vendor scheduled · Feb 12', 'priority'),
    _WorkOrder('Landscape renewal — south terrace', 'Awaiting proposal', 'standard'),
    _WorkOrder('Generator inspection', 'Completed · Jan 28', 'done'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tab = ref.watch(dashboardTabIndexProvider);

    final gradient = widget.mode == PortfolioMode.management
        ? AppGradients.management
        : AppGradients.maintenance;

    final heroTag =
        widget.mode == PortfolioMode.management ? AppHeroTags.managementCta : AppHeroTags.maintenanceCta;

    return Scaffold(
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(decoration: BoxDecoration(gradient: AppGradients.studioBackdrop)),
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                stretch: true,
                expandedHeight: 168,
                backgroundColor: AppColors.midnight.withOpacity(0.92),
                surfaceTintColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  onPressed: () => context.go(AppRoutes.welcome),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 52, bottom: 14, right: 16),
                  title: Text(
                    'Command Center',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontFamily: theme.textTheme.headlineMedium?.fontFamily,
                      letterSpacing: -0.2,
                    ),
                  ),
                  background: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.midnight.withOpacity(0.1),
                          AppColors.midnight.withOpacity(0.92),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LuxuryGradientCta(
                        label: widget.mode.title,
                        gradient: gradient,
                        heroTag: heroTag,
                        onPressed: null,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.mode.tagline,
                        style: theme.textTheme.bodyMedium,
                      )
                          .animate()
                          .fadeIn(duration: 400.ms, delay: 60.ms)
                          .slideX(begin: -0.02),
                      const SizedBox(height: 28),
                      _KpiRow(mode: widget.mode)
                          .animate()
                          .fadeIn(duration: 450.ms, delay: 100.ms)
                          .slideY(begin: 0.06, curve: Curves.easeOutCubic),
                      const SizedBox(height: 28),
                      Text('Portfolio pulse', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 12),
                      _tabBody(theme, tab),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (i) => ref.read(dashboardTabIndexProvider.notifier).state = i,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Overview',
          ),
          NavigationDestination(
            icon: Icon(Icons.castle_outlined),
            selectedIcon: Icon(Icons.villa_rounded),
            label: 'Estates',
          ),
          NavigationDestination(
            icon: Icon(Icons.handyman_outlined),
            selectedIcon: Icon(Icons.construction_rounded),
            label: 'Service',
          ),
        ],
      ),
    );
  }

  Widget _tabBody(ThemeData theme, int tab) {
    switch (tab) {
      case 0:
        return _OverviewTab(theme: theme, estates: _estates, workOrders: _workOrders, mode: widget.mode);
      case 1:
        return _EstatesList(estates: _estates);
      default:
        return _ServiceTab(workOrders: _workOrders);
    }
  }
}

class _KpiRow extends StatelessWidget {
  const _KpiRow({required this.mode});

  final PortfolioMode mode;

  @override
  Widget build(BuildContext context) {
    final isMgmt = mode == PortfolioMode.management;
    return Row(
      children: [
        Expanded(
          child: _KpiCard(
            label: isMgmt ? 'Net operating income' : 'Mean time to restore',
            value: isMgmt ? '↑ 12.4%' : '18h',
            caption: isMgmt ? 'Trailing quarter' : 'Rolling 90 days',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _KpiCard(
            label: isMgmt ? 'Occupancy' : 'Open work orders',
            value: isMgmt ? '97%' : '4',
            caption: isMgmt ? 'Blended portfolio' : 'Across vendors',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _KpiCard(
            label: isMgmt ? 'Resident NPS' : 'Preventative coverage',
            value: isMgmt ? '74' : '92%',
            caption: isMgmt ? 'Luxury cohort' : 'Critical systems',
          ),
        ),
      ],
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.label,
    required this.value,
    required this.caption,
  });

  final String label;
  final String value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        gradient: LinearGradient(
          colors: [
            AppColors.slate.withOpacity(0.55),
            AppColors.graphite.withOpacity(0.55),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11, height: 1.25),
            ),
            const SizedBox(height: 10),
            Text(value, style: theme.textTheme.headlineMedium?.copyWith(fontSize: 22)),
            const SizedBox(height: 6),
            Text(
              caption,
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({
    required this.theme,
    required this.estates,
    required this.workOrders,
    required this.mode,
  });

  final ThemeData theme;
  final List<_Estate> estates;
  final List<_WorkOrder> workOrders;
  final PortfolioMode mode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 156,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: estates.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) {
              final e = estates[i];
              return _EstateCard(estate: e, index: i);
            },
          ),
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              mode == PortfolioMode.management ? 'Revenue trajectory' : 'Field readiness',
              style: theme.textTheme.titleMedium,
            ),
            Text(
              'Live',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.champagne,
                fontSize: 11,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...workOrders.asMap().entries.map((e) {
          final i = e.key;
          final w = e.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _WorkOrderTile(order: w),
          )
              .animate()
              .fadeIn(duration: 380.ms, delay: (120 + i * 70).ms)
              .slideY(begin: 0.05, curve: Curves.easeOutCubic);
        }),
      ],
    );
  }
}

class _Estate {
  const _Estate(this.title, this.subtitle, this.score, this.icon);

  final String title;
  final String subtitle;
  final String score;
  final IconData icon;
}

class _EstateCard extends StatelessWidget {
  const _EstateCard({required this.estate, required this.index});

  final _Estate estate;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 240,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          color: AppColors.graphite.withOpacity(0.65),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(estate.icon, color: AppColors.champagne.withOpacity(0.85)),
              const Spacer(),
              Text(estate.title, style: theme.textTheme.titleMedium?.copyWith(fontSize: 15)),
              const SizedBox(height: 6),
              Text(estate.subtitle, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('Serenity', style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: Colors.white.withOpacity(0.06),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: Text(
                      estate.score,
                      style: theme.textTheme.labelLarge?.copyWith(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 420.ms, delay: (80 + index * 90).ms)
        .slideX(begin: 0.06, curve: Curves.easeOutCubic);
  }
}

class _EstatesList extends StatelessWidget {
  const _EstatesList({required this.estates});

  final List<_Estate> estates;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: estates.asMap().entries.map((e) {
        final i = e.key;
        final estate = e.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: Colors.white.withOpacity(0.08)),
            ),
            tileColor: AppColors.graphite.withOpacity(0.45),
            leading: Icon(estate.icon, color: AppColors.champagne.withOpacity(0.9)),
            title: Text(estate.title, style: theme.textTheme.titleMedium?.copyWith(fontSize: 15)),
            subtitle: Text(estate.subtitle, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12)),
            trailing: Icon(Icons.chevron_right_rounded, color: Colors.white.withOpacity(0.35)),
          ),
        )
            .animate()
            .fadeIn(duration: 380.ms, delay: (60 + i * 70).ms)
            .slideY(begin: 0.04);
      }).toList(),
    );
  }
}

class _WorkOrder {
  const _WorkOrder(this.title, this.subtitle, this.bucket);

  final String title;
  final String subtitle;
  final String bucket;
}

class _WorkOrderTile extends StatelessWidget {
  const _WorkOrderTile({required this.order});

  final _WorkOrder order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = switch (order.bucket) {
      'priority' => AppColors.maintRose.withOpacity(0.85),
      'done' => AppColors.mgmtCyan.withOpacity(0.85),
      _ => AppColors.mist.withOpacity(0.65),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        color: AppColors.graphite.withOpacity(0.55),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: LinearGradient(
                  colors: [accent, accent.withOpacity(0.2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.title, style: theme.textTheme.titleMedium?.copyWith(fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(order.subtitle, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.more_horiz_rounded, color: Colors.white.withOpacity(0.35)),
          ],
        ),
      ),
    );
  }
}

class _ServiceTab extends StatelessWidget {
  const _ServiceTab({required this.workOrders});

  final List<_WorkOrder> workOrders;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dispatch queue',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        ...workOrders.map(
          (w) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _WorkOrderTile(order: w),
          ),
        ),
      ],
    );
  }
}
