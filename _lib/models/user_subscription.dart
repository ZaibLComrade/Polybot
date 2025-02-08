enum SubscriptionTier { free, pro, enterprise }

class UserSubscription {
  final SubscriptionTier tier;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isActive;
  final int tokensUsed;
  final int tokensLimit;
  final List<String> features;
  final double price;

  UserSubscription({
    required this.tier,
    this.startDate,
    this.endDate,
    this.isActive = true,
    this.tokensUsed = 0,
    required this.tokensLimit,
    required this.features,
    required this.price,
  });

  bool get isExpired => endDate != null && endDate!.isBefore(DateTime.now());
  double get tokenUsagePercentage => tokensUsed / tokensLimit;

  UserSubscription copyWith({
    SubscriptionTier? tier,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    int? tokensUsed,
    int? tokensLimit,
    List<String>? features,
    double? price,
  }) {
    return UserSubscription(
      tier: tier ?? this.tier,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      tokensUsed: tokensUsed ?? this.tokensUsed,
      tokensLimit: tokensLimit ?? this.tokensLimit,
      features: features ?? this.features,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tier': tier.toString(),
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isActive': isActive,
      'tokensUsed': tokensUsed,
      'tokensLimit': tokensLimit,
      'features': features,
      'price': price,
    };
  }

  factory UserSubscription.fromJson(Map<String, dynamic> json) {
    return UserSubscription(
      tier: SubscriptionTier.values.firstWhere(
        (e) => e.toString() == json['tier'],
        orElse: () => SubscriptionTier.free,
      ),
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isActive: json['isActive'] ?? true,
      tokensUsed: json['tokensUsed'] ?? 0,
      tokensLimit: json['tokensLimit'] ?? 0,
      features: List<String>.from(json['features'] ?? []),
      price: json['price']?.toDouble() ?? 0.0,
    );
  }
}