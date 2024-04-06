import 'package:flutter/material.dart';
import 'package:technaureus_project/utils/app_colors.dart';
import 'package:technaureus_project/view/customer_screen/customer_screen.dart';
import 'package:technaureus_project/view/product_screen/product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> homeView = [
    {
      'title': 'Customers',
      'icon': Icon(Icons.groups),
      'page': CustomerScreen(),
    },
    {
      'title': 'Products',
      'icon': Icon(Icons.groups),
      'page': ProductScreen(),
    },
    {
      'title': 'New Order',
      'icon': Icon(Icons.groups),
      'page': ProductScreen(),
    },
    {
      'title': 'Return Order',
      'icon': Icon(Icons.groups),
      'page': ProductScreen(),
    },
    // {
    //   'title': 'Cart',
    //   'icon': Icon(Icons.groups),
    //   'page': ProductScreen(),
    // },
    // {
    //   'title': 'Customers',
    //   'icon': Icon(Icons.groups),
    //   'page': ProductScreen(),
    // },
    // {
    //   'title': 'Customers',
    //   'icon': Icon(Icons.groups),
    //   'page': ProductScreen(),
    // },
    // {
    //   'title': 'Customers',
    //   'icon': Icon(Icons.groups),
    //   'page': ProductScreen(),
    // },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primaryColor,
                ),
              ],
            ),
            // needs to be changed
            IconButton(onPressed: () {}, icon: Icon(Icons.menu))
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  itemCount: homeView.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 150,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => homeView[index]['page'],
                            ));
                      },
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: AppColors.primaryWhite,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[300]!,
                                  offset: Offset(1, 3),
                                  blurStyle: BlurStyle.normal,
                                  blurRadius: 3)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            homeView[index]['icon'],
                            Text(homeView[index]['title'])
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
