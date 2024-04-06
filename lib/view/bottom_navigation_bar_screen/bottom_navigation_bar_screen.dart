import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:technaureus_project/view/cart_screen/cart_screen.dart';
import 'package:technaureus_project/view/customer_screen/customer_screen.dart';
import 'package:technaureus_project/view/home_screen/home_screen.dart';
import 'package:technaureus_project/view/new_order_screen/new_order_screen.dart';
import 'package:technaureus_project/view/return_order_screen/return_order_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  List<Widget> screens = [
    HomeScreen(),
    NewOrderScreen(),
    CartScreen(),
    ReturnOrderScreen(),
    CustomerScreen(),
  ];
  int screenNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: screenNumber,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          screenNumber = value;
          setState(() {});
        },
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 24,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "New Order"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(
              icon: FaIcon(Icons.add), label: "Return Order"),
          BottomNavigationBarItem(
              icon: FaIcon(Icons.groups), label: "Customers"),
        ],
      ),
      body: screens[screenNumber],
    );
  }
}
