import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'home_screen.dart';
import 'statistic_screen.dart';
import 'profile_screen.dart';
import 'add_expense_screen.dart';
import 'wallet_screen.dart'; // will create this next

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const StatisticScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
          );
        },
        backgroundColor: AppTheme.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_filled, 0),
              _buildNavItem(Icons.bar_chart, 1),
              const SizedBox(width: 40), // Empty space for FAB
              _buildNavItem(Icons.account_balance_wallet, 2),
              _buildNavItem(Icons.person, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _currentIndex == index;
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? AppTheme.primary : Colors.grey.shade400,
        size: 28,
      ),
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
