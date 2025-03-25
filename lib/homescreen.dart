import 'package:flutter/material.dart';
import 'package:funkypanda/cart.dart';
import 'package:funkypanda/cart2.dart';
import 'package:funkypanda/morescreen.dart';
import 'package:funkypanda/offers.dart';
import 'package:funkypanda/orderscreen.dart';
import 'package:funkypanda/screen1.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    HomeScreen(setIndexCallback: (int index) {}, setIndex: (int) {}),
    const OrderScreen(),
    const Offers(),
    const MoreScreen(),
  ];

  // 🔹 Change index with animation
  void _setIndex(int index) {
    if (index == _selectedIndex) return; // No animation if index is same

    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _setIndex, // Handles navigation animation
        selectedItemColor: Color.fromRGBO(255, 180, 204, 1),
        unselectedItemColor: Colors.black54,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.note_alt_outlined), label: 'Order'),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), label: 'Offers'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}
