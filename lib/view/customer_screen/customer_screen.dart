import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_project/controller/customer_controller.dart';
import 'package:technaureus_project/utils/app_colors.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    await Provider.of<CustomerController>(context, listen: false).cutomerView();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var customerDetails = Provider.of<CustomerController>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // needs to be changed
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios)),
            Text("Customers", style: TextStyle(fontSize: 18)),

            IconButton(onPressed: () {}, icon: Icon(Icons.menu))
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      hintText: "Search",
                      hintStyle:
                          TextStyle(fontSize: 12, color: AppColors.fadedText),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.fadedText,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Ensure the Row takes minimum space
                        children: [
                          Icon(
                            Icons.qr_code,
                            color: AppColors.fadedText,
                          ),
                          SizedBox(width: 8), // Add some space between icons
                          CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            radius: 15,
                            child: Icon(
                              Icons.add,
                              size: 30, // Adjust size as needed
                              color: AppColors.primaryWhite,
                            ),
                          ),
                          SizedBox(width: 8), // Add some space between icons
                        ],
                      ),
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: ListView.separated(
                  itemCount: customerDetails.customerModel.data?.length ?? 0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      decoration: BoxDecoration(
                          color: AppColors.primaryWhite,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.fadedText,
                                blurRadius: 5,
                                offset: Offset(1, 2))
                          ]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: MediaQuery.sizeOf(context).width * .25,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: customerDetails
                                      .customerModel.data?[index].profilePic ??
                                  "",
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/image/user_asset.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 1,
                            height: 100,
                            color: AppColors.fadedText,
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(customerDetails
                                        .customerModel.data?[index].name ??
                                    ""),
                                Text.rich(
                                  style: TextStyle(fontSize: 12),
                                  TextSpan(children: [
                                    TextSpan(text: "ID :"),
                                    TextSpan(
                                        text: customerDetails
                                            .customerModel.data?[index].id
                                            .toString()),
                                  ]),
                                ),
                                Text.rich(
                                  style: TextStyle(fontSize: 12),
                                  TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "${customerDetails.customerModel.data?[index].city}, "),
                                    TextSpan(
                                        text:
                                            "${customerDetails.customerModel.data?[index].state}, "),
                                    TextSpan(
                                        text: customerDetails.customerModel
                                            .data?[index].country),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
