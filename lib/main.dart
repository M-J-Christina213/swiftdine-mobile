import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftdine_mobile/views/login_screen.dart';
import 'package:swiftdine_mobile/views/orders_screen.dart';
import 'package:swiftdine_mobile/views/splash_screen.dart';
import 'package:swiftdine_mobile/views/widgets/profile/address_screen.dart';
import 'package:swiftdine_mobile/views/widgets/profile/favourites.dart';
import 'package:swiftdine_mobile/views/widgets/profile/payment_screen.dart';
import 'package:swiftdine_mobile/views/widgets/profile/settings.dart';
import 'package:swiftdine_mobile/views/widgets/profile/support_screen.dart';
import 'themes/app_theme.dart';
import 'views/widgets/bottom_nav_bar_screen.dart';
import 'views/providers/cart_provider.dart'; 

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()), // <-- add CartProvider
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
      debugShowCheckedModeBanner: false,
      title: 'SwiftDine',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const BottomNavBarScreen(),
        '/orders': (context) => const OrderScreen(),
        '/favorites': (context) => const FavoritesScreen(),
        '/payments': (context) => const PaymentsScreen(),
        '/addresses': (context) => const AddressScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/support': (context) => const SupportScreen(),
      },
      home: const BottomNavBarScreen(),
    );
  }
}

// Provider to manage light/dark theme
class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
