import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../themes/app_theme.dart';
import '../../main.dart';
import '../home_screen.dart';
import '../menu_screen.dart';
import '../offers_screen.dart';
import '../orders_screen.dart';
import '../profile_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const MenuScreen(),
    const OfferScreen(
      isLoggedIn: true,
      isBirthdayMonth: true,
      userName: 'Christina',
      birthdayCountdown: Duration(days: 3, hours: 2, minutes: 45),
    ),
    const OrderScreen(),
    const ProfileScreen(token: '',),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SwiftDine'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      drawer: isLandscape
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: AppTheme.primaryColor),
                    child: Text('SwiftDine',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      setState(() => _currentIndex = 0);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.restaurant_menu),
                    title: const Text('Menu'),
                    onTap: () {
                      setState(() => _currentIndex = 1);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.local_offer),
                    title: const Text('Offers'),
                    onTap: () {
                      setState(() => _currentIndex = 2);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.receipt_long),
                    title: const Text('Orders'),
                    onTap: () {
                      setState(() => _currentIndex = 3);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () {
                      setState(() => _currentIndex = 4);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          : null,
      body: _screens[_currentIndex],
      bottomNavigationBar: isLandscape
          ? null
          : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppTheme.primaryColor,
              unselectedItemColor: AppTheme.descriptionColor,
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.restaurant_menu), label: 'Menus'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.local_offer), label: 'Offers'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.receipt_long), label: 'Orders'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
    );
  }
}
