import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ticketing_app/core/assets/assets.gen.dart';
import 'package:ticketing_app/core/constants/colors.dart';
import 'package:ticketing_app/core/extensions/build_context_ext.dart';
import 'package:ticketing_app/presentation/home/pages/history_page.dart';
import 'package:ticketing_app/presentation/home/pages/order_page.dart';
import 'package:ticketing_app/presentation/home/pages/setting_page.dart';
import 'package:ticketing_app/presentation/home/pages/setting_printer_page.dart';
import 'package:ticketing_app/presentation/home/pages/ticket_page.dart';
import 'package:ticketing_app/presentation/home/widget/nav_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Setting biar ke Index utama
  int _selectedIndex = 0;
  final _pages = [OrderPage(), TicketPage(), HistoryPage(), SettingPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -2),
              blurRadius: 30,
              blurStyle: BlurStyle.outer,
              color: AppColors.black.withOpacity(0.1),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              iconPath: Assets.icons.nav.home.path,
              label: "Home",
              isActive: _selectedIndex == 0,
              // Ngejalanin fungsi index 0
              onTap: () => _onItemTapped(0),
            ),
            NavItem(
              iconPath: Assets.icons.nav.ticket.path,
              label: "Ticket",
              isActive: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            NavItem(
              iconPath: Assets.icons.nav.history.path,
              label: "History",
              isActive: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            NavItem(
              iconPath: Assets.icons.nav.setting.path,
              label: "Setting",
              isActive: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
      // GestureDetector fungisnya lebih ke fungsi
      floatingActionButton: GestureDetector(
        onTap: () => context.push(SettingPrinterPage()),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
          child: Assets.icons.nav.scan.svg(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Ini fungsi atau logic untuk si onItemTapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
