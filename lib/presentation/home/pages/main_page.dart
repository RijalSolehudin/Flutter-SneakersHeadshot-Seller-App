import 'package:ecommerce_seller_app/presentation/home/pages/dashboard_page.dart';
import 'package:ecommerce_seller_app/presentation/home/pages/live_streaming_create_page.dart';
import 'package:ecommerce_seller_app/presentation/home/pages/order_list_page.dart';
import 'package:ecommerce_seller_app/presentation/home/pages/product_page.dart';
import 'package:ecommerce_seller_app/presentation/home/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const DashboardPage(),
    const ProductPage(),
    const SizedBox(),
    const OrderListPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 68,
        height: 68,
        child: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: AppColors.primary,
          onPressed: () {
            context.push(const LiveStreamingCreatePage());
          },
          child: Assets.icons.liveStream.svg(
            width: 100,
            height: 100,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.home.svg(
              colorFilter: ColorFilter.mode(
                _selectedIndex == 0 ? AppColors.primary : AppColors.gray,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.product.svg(
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1 ? AppColors.primary : AppColors.gray,
                BlendMode.srcIn,
              ),
            ),
            label: 'Product',
          ),
          const BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.order.svg(
              colorFilter: ColorFilter.mode(
                _selectedIndex == 2 ? AppColors.primary : AppColors.gray,
                BlendMode.srcIn,
              ),
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.profile.svg(
              colorFilter: ColorFilter.mode(
                _selectedIndex == 3 ? AppColors.primary : AppColors.gray,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }
}
