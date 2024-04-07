import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    await Provider.of<CustomerController>(context, listen: false)
        .customerView();
  }

  TextEditingController searchController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController street2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  String selectedState = 'Kerala';
  String selectedCountry = 'India';

  List<String> countryList = [
    'India',
    'US',
    'Australia',
    'New Zealand',
    'Argentina',
  ];

  List<String> statesList = [
    'Kerala',
    'Tamil Nadu',
    'Karnataka',
    'Andra Pradesh',
  ];

  String finalButton = "Submit";
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    var customerDetails = Provider.of<CustomerController>(context);
    var functionProvider =
        Provider.of<CustomerController>(context, listen: false);
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
                  finalButton = "Submit";
                  isEditing = false;
                  setState(() {});
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
                          InkWell(
                            onTap: () {
                              custmerAddBottomsheet(context);
                              finalButton = "Submit";
                              isEditing = false;
                              setState(() {});
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColors.primaryColor,
                              radius: 15,
                              child: Icon(
                                Icons.add,
                                size: 30, // Adjust size as needed
                                color: AppColors.primaryWhite,
                              ),
                            ),
                          ),
                          SizedBox(width: 8), // Add some space between icons
                        ],
                      ),
                    ),
                    onChanged: (value) {
                      functionProvider.searchCustomer(value);
                    },
                  )),
              customerDetails.customerModel.data?.length != 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: ListView.separated(
                        itemCount:
                            customerDetails.customerModel.data?.length ?? 0,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              isEditing = true;
                              custmerAddBottomsheet(context);
                              customerNameController.text = customerDetails
                                      .customerModel.data?[index].name ??
                                  "";
                              mobileController.text = customerDetails
                                      .customerModel
                                      .data?[index]
                                      .mobileNumber ??
                                  "";
                              emailController.text = customerDetails
                                      .customerModel.data?[index].email ??
                                  "";
                              streetController.text = customerDetails
                                      .customerModel.data?[index].street ??
                                  "";
                              street2Controller.text = customerDetails
                                      .customerModel.data?[index].streetTwo ??
                                  "";
                              cityController.text = customerDetails
                                      .customerModel.data?[index].city ??
                                  "";
                              pincodeController.text = customerDetails
                                      .customerModel.data?[index].pincode
                                      .toString() ??
                                  "";
                              // selectedCountry = customerDetails
                              //         .customerModel.data?[index].country ??
                              //     "";
                              // state = customerDetails
                              //         .customerModel.data?[index].state ??
                              //     "";
                              finalButton = "Edit";
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 5),
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
                                    width:
                                        MediaQuery.sizeOf(context).width * .25,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: customerDetails.customerModel
                                              .data?[index].profilePic ??
                                          "",
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(customerDetails.customerModel
                                                    .data?[index].name ??
                                                ""),
                                            Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.phone,
                                                  size: 16,
                                                  color: AppColors.phoneBlue,
                                                ),
                                                SizedBox(width: 10),
                                                FaIcon(
                                                  FontAwesomeIcons.whatsapp,
                                                  size: 20,
                                                  color:
                                                      AppColors.whatsappGreen,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text.rich(
                                          style: TextStyle(fontSize: 12),
                                          TextSpan(children: [
                                            TextSpan(text: "ID :"),
                                            TextSpan(
                                                text: customerDetails
                                                    .customerModel
                                                    .data?[index]
                                                    .id
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
                                                text: customerDetails
                                                    .customerModel
                                                    .data?[index]
                                                    .country),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text("No data"),
                    )
            ],
          ),
        ),
      ),
    );
  }

  final formKey = GlobalKey<FormState>();

  Future<dynamic> custmerAddBottomsheet(BuildContext context) {
    var functionProvider =
        Provider.of<CustomerController>(context, listen: false);
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Add Customer"),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.fadedText)),
                        padding: EdgeInsets.all(5),
                        child: InkWell(
                            onTap: () {
                              customerNameController.clear();
                              mobileController.clear();
                              emailController.clear();
                              streetController.clear();
                              street2Controller.clear();
                              cityController.clear();
                              pincodeController.clear();
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close_rounded)),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: customerNameController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      isDense: true,
                      labelText: "Customer Name",
                      labelStyle:
                          TextStyle(fontSize: 14, color: AppColors.fadedText),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: mobileController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      isDense: true,
                      labelText: "Mobile Number",
                      labelStyle:
                          TextStyle(fontSize: 14, color: AppColors.fadedText),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter mobile number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      isDense: true,
                      labelText: "Email",
                      labelStyle:
                          TextStyle(fontSize: 14, color: AppColors.fadedText),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  Text("Address"),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: streetController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            isDense: true,
                            labelText: "Street",
                            labelStyle: TextStyle(
                                fontSize: 14, color: AppColors.fadedText),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: TextFormField(
                          controller: street2Controller,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            isDense: true,
                            labelText: "Street2",
                            labelStyle: TextStyle(
                                fontSize: 14, color: AppColors.fadedText),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: cityController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            isDense: true,
                            labelText: "City",
                            labelStyle: TextStyle(
                                fontSize: 14, color: AppColors.fadedText),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: TextFormField(
                          controller: pincodeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            isDense: true,
                            labelText: "Pin Code",
                            labelStyle: TextStyle(
                                fontSize: 14, color: AppColors.fadedText),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        child: DropdownButtonFormField(
                          key: UniqueKey(),
                          style: TextStyle(
                              fontSize: 14, color: AppColors.fadedText),
                          hint: Text("Country"),
                          value: selectedCountry,
                          items: countryList
                              .map(
                                (String countryName) => DropdownMenuItem(
                                  value: countryName,
                                  child: Text(countryName),
                                ),
                              )
                              .toList(),
                          onChanged: (String? newValue) {
                            selectedCountry = newValue!;
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: DropdownButtonFormField(
                          style: TextStyle(
                              fontSize: 14, color: AppColors.fadedText),
                          hint: Text("State"),
                          value: selectedState,
                          items: statesList
                              .map(
                                (states) => DropdownMenuItem(
                                  child: Text(states.toString()),
                                  value: states,
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            selectedState = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.sizeOf(context).width * .1)),
                          backgroundColor:
                              MaterialStatePropertyAll(AppColors.primaryColor),
                          foregroundColor:
                              MaterialStatePropertyAll(AppColors.primaryWhite),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            Navigator.pop(context);
                            isEditing == false
                                ? await functionProvider.addCustomers(
                                    customerName: customerNameController,
                                    mobileNumber: mobileController,
                                    email: emailController,
                                    street: streetController,
                                    street2: street2Controller,
                                    city: cityController,
                                    pinCode: pincodeController,
                                    country: selectedCountry,
                                    state: selectedState)
                                : await functionProvider.editCustomers(
                                    customerName: customerNameController,
                                    mobileNumber: mobileController,
                                    email: emailController,
                                    street: streetController,
                                    street2: street2Controller,
                                    city: cityController,
                                    pinCode: pincodeController,
                                    country: selectedCountry,
                                    state: selectedState);
                          }
                          customerNameController.clear();
                          mobileController.clear();
                          emailController.clear();
                          streetController.clear();
                          street2Controller.clear();
                          cityController.clear();
                          pincodeController.clear();
                        },
                        child: Text(finalButton)),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
