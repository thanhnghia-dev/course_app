import 'package:course_app/views/dashboard/classroom_screen.dart';
import 'package:course_app/views/home/schedule_screen.dart';
import 'package:course_app/views/profile/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:course_app/core/theme/app_colors.dart';
import 'package:course_app/views/home/home_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0; // Default Home Tab

  // Each tab has its own NavigatorKey
  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
      4, (index) => GlobalKey<NavigatorState>());

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Page roots of each tab
  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => _getRootPage(index),
          );
        },
      ),
    );
  }

  Widget _getRootPage(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ScheduleScreen();
      case 2:
        return const ClassroomScreen();
      case 3:
        return const AccountScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: List.generate(4, (index) => _buildOffstageNavigator(index)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.navigationBar,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primary,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0 ? const Icon(Icons.home_rounded) : const Icon(Icons.home_outlined), 
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1 ? const Icon(Icons.calendar_month_rounded) : const Icon(Icons.calendar_month_outlined), 
            label: 'Lịch',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2 ? const Icon(Icons.class_rounded) : const Icon(Icons.class_outlined), 
            label: 'Lớp học',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3 ? const Icon(Icons.person_rounded) : const Icon(Icons.person_outline), 
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}
