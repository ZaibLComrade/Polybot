import 'package:flutter/material.dart';
import 'package:polybot/pages/change_password_page.dart';
import 'package:polybot/pages/edit_profile_page.dart';
import 'package:polybot/pages/notification_page.dart';
import 'package:provider/provider.dart';
import 'package:polybot/pages/chat_page.dart';
import 'package:polybot/pages/landing_page.dart';
import 'package:polybot/pages/login_page.dart';
import 'package:polybot/pages/register_page.dart';
import 'package:polybot/pages/pricing_page.dart';
import 'package:polybot/pages/user_page.dart';
import 'package:polybot/pages/models_page.dart';
import 'package:polybot/pages/settings_page.dart';
import 'package:polybot/pages/history_page.dart';
import 'package:polybot/pages/billing_page.dart';
import 'package:polybot/pages/help_page.dart';
import 'package:polybot/themes/app_theme.dart';
import 'package:polybot/providers/theme_provider.dart';
import 'package:polybot/providers/auth_provider.dart';
import 'package:polybot/providers/chat_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      title: "Polybot",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      showSemanticsDebugger: false,
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        // Add page transitions
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            switch (settings.name) {
              case '/':
                return const LandingPage();
              case '/login':
                return const LoginPage();
              case '/register':
                return const RegisterPage();
              case '/chat':
                return const ChatPage();
              case '/pricing':
                return const PricingPage();
              case '/profile':
                return const UserPage();
              case '/profile/change-password':
                return const ChangePasswordPage();
              case '/profile/edit-profile':
                return const EditProfilePage();
              case '/profile/notification':
                return const NotificationsPage();
              case '/models':
                return const ModelsPage();
              case '/settings':
                return const SettingsPage();
              case '/history':
                return const HistoryPage();
              case '/billing':
                return const BillingPage();
              case '/help':
                return const HelpPage();
              default:
                return const LandingPage();
            }
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
      },
    );
  }
}