class UserPreferences {
  final bool pushNotifications;
  final bool emailNotifications;
  final bool messageNotifications;
  final bool updateNotifications;
  final bool marketingNotifications;
  final String preferredLanguage;
  final String preferredTheme;
  final bool autoDeleteMessages;
  final int messageHistoryDays;
  final bool allowDataCollection;
  final bool allowThirdPartyIntegration;

  UserPreferences({
    this.pushNotifications = true,
    this.emailNotifications = true,
    this.messageNotifications = true,
    this.updateNotifications = true,
    this.marketingNotifications = false,
    this.preferredLanguage = 'en',
    this.preferredTheme = 'system',
    this.autoDeleteMessages = false,
    this.messageHistoryDays = 30,
    this.allowDataCollection = false,
    this.allowThirdPartyIntegration = false,
  });

  UserPreferences copyWith({
    bool? pushNotifications,
    bool? emailNotifications,
    bool? messageNotifications,
    bool? updateNotifications,
    bool? marketingNotifications,
    String? preferredLanguage,
    String? preferredTheme,
    bool? autoDeleteMessages,
    int? messageHistoryDays,
    bool? allowDataCollection,
    bool? allowThirdPartyIntegration,
  }) {
    return UserPreferences(
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      messageNotifications: messageNotifications ?? this.messageNotifications,
      updateNotifications: updateNotifications ?? this.updateNotifications,
      marketingNotifications: marketingNotifications ?? this.marketingNotifications,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      preferredTheme: preferredTheme ?? this.preferredTheme,
      autoDeleteMessages: autoDeleteMessages ?? this.autoDeleteMessages,
      messageHistoryDays: messageHistoryDays ?? this.messageHistoryDays,
      allowDataCollection: allowDataCollection ?? this.allowDataCollection,
      allowThirdPartyIntegration:
          allowThirdPartyIntegration ?? this.allowThirdPartyIntegration,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pushNotifications': pushNotifications,
      'emailNotifications': emailNotifications,
      'messageNotifications': messageNotifications,
      'updateNotifications': updateNotifications,
      'marketingNotifications': marketingNotifications,
      'preferredLanguage': preferredLanguage,
      'preferredTheme': preferredTheme,
      'autoDeleteMessages': autoDeleteMessages,
      'messageHistoryDays': messageHistoryDays,
      'allowDataCollection': allowDataCollection,
      'allowThirdPartyIntegration': allowThirdPartyIntegration,
    };
  }

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      pushNotifications: json['pushNotifications'] ?? true,
      emailNotifications: json['emailNotifications'] ?? true,
      messageNotifications: json['messageNotifications'] ?? true,
      updateNotifications: json['updateNotifications'] ?? true,
      marketingNotifications: json['marketingNotifications'] ?? false,
      preferredLanguage: json['preferredLanguage'] ?? 'en',
      preferredTheme: json['preferredTheme'] ?? 'system',
      autoDeleteMessages: json['autoDeleteMessages'] ?? false,
      messageHistoryDays: json['messageHistoryDays'] ?? 30,
      allowDataCollection: json['allowDataCollection'] ?? false,
      allowThirdPartyIntegration: json['allowThirdPartyIntegration'] ?? false,
    );
  }
}