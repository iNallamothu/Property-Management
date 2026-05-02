/// How the user entered the product experience (from the wireframe CTAs).
enum PortfolioMode {
  /// Property management — trust / operations (blue-cyan gradient).
  management,

  /// Property maintenance — service / care (violet-rose gradient).
  maintenance,
}

extension PortfolioModeX on PortfolioMode {
  String get title => switch (this) {
        PortfolioMode.management => 'Property Management',
        PortfolioMode.maintenance => 'Property Maintenance',
      };

  String get tagline => switch (this) {
        PortfolioMode.management => 'Operations, revenue, and resident experience.',
        PortfolioMode.maintenance => 'Service, vendors, and work orders at a glance.',
      };
}
