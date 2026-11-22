import 'package:flutter/material.dart';

import 'config.dart';
import 'screens/book_screen.dart';
import 'screens/home_screen.dart';
import 'screens/info_screen.dart';
import 'screens/prices_screen.dart';

void main() {
  runApp(const DoorStepFixApp());
}

class DoorStepFixApp extends StatelessWidget {
  const DoorStepFixApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0F766E),
      brightness: Brightness.light,
    );
    return MaterialApp(
      title: businessName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: scheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: scheme.primary,
          foregroundColor: Colors.white,
        ),
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  void _go(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(onBookTap: () => _go(2), onPricesTap: () => _go(1)),
      const PricesScreen(),
      const BookScreen(),
      const InfoScreen(),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text(businessName)),
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _go,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.price_check_outlined), selectedIcon: Icon(Icons.price_check), label: 'Prices'),
          NavigationDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: 'Book'),
          NavigationDestination(icon: Icon(Icons.info_outline), selectedIcon: Icon(Icons.info), label: 'Info'),
        ],
      ),
    );
  }
}
