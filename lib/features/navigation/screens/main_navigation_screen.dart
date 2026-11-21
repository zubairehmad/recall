import 'package:flutter/material.dart';

import '../../home/screens/home_screen.dart';
import '../../information/screens/information_list_screen.dart';
import '../../statistics/screens/statistics_screen.dart';
import '../../backup/screens/backup_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  static const _screens = [
    HomeScreen(),
    InformationListScreen(),
    StatisticsScreen(),
    BackupScreen(),
  ];

  final _controller = PageController();
  int _selectedIdx = 0;

  void _onDestinationSelected(int index) {
    _controller.jumpToPage(
      index,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIdx = index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: _onPageChanged,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIdx,
        onDestinationSelected: _onDestinationSelected,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        overlayColor: WidgetStateColor.transparent,
        indicatorColor: Colors.transparent,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 30,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.library_books_outlined),
            selectedIcon: Icon(
              Icons.library_books_outlined,
              color: Colors.white,
              size: 30,
            ),
            label: 'Library',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(
              Icons.bar_chart_outlined,
              color: Colors.white,
              size: 30,
            ),
            label: 'Statistics',
          ),
          NavigationDestination(
            icon: Icon(Icons.backup_rounded),
            selectedIcon: Icon(
              Icons.backup_rounded,
              color: Colors.white,
              size: 30,
            ),
            label: 'Backup',
          ),
        ],
      ),
    );
  }
}
