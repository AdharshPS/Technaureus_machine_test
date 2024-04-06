import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_project/controller/customer_controller.dart';
import 'package:technaureus_project/controller/product_controller.dart';
import 'package:technaureus_project/view/bottom_navigation_bar_screen/bottom_navigation_bar_screen.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CustomerController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavigationBarScreen(),
      ),
    );
  }
}
