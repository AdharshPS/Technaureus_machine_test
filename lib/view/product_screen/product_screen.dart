import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technaureus_project/controller/product_controller.dart';
import 'package:technaureus_project/utils/app_colors.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    fetchProduct();
    super.initState();
  }

  fetchProduct() async {
    await Provider.of<ProductController>(context, listen: false).productView();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductController>(context);
    var functionProvider =
        Provider.of<ProductController>(context, listen: false);

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
              Text("Nesto Hypermarket", style: TextStyle(fontSize: 18)),

              IconButton(onPressed: () {}, icon: Icon(Icons.menu))
            ],
          ),
        ),
        body: SingleChildScrollView(
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
                          Container(
                            width: 1,
                            height: 30,
                            color: AppColors.fadedText,
                          ),
                          SizedBox(width: 8), // Add some space between icons
                          Text(
                            "Fruits",
                            style: TextStyle(color: AppColors.fadedText),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.fadedText,
                          )
                        ],
                      ),
                    ),
                    onChanged: (value) {
                      functionProvider.searchProduct(value);
                    },
                  )),
              productProvider.productModel.data?.length != 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: GridView.builder(
                          itemCount:
                              productProvider.productModel.data?.length ?? 0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent:
                                MediaQuery.sizeOf(context).height * .20,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) => ContainerWidget(
                                index: index,
                              )),
                    )
                  : Center(
                      child: Text("No Products"),
                    ),
            ],
          ),
        ));
  }
}

class ContainerWidget extends StatefulWidget {
  const ContainerWidget({super.key, required this.index});
  final int index;

  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  int itemCount = 0;
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductController>(context);
    var functionProvider =
        Provider.of<ProductController>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.primaryWhite,
          boxShadow: [
            BoxShadow(
                color: AppColors.fadedText, blurRadius: 2, offset: Offset(1, 1))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 65,
            child: LayoutBuilder(builder: (context, constraints) {
              return Center(
                child: CachedNetworkImage(
                  imageUrl:
                      productProvider.productModel.data?[widget.index].image ??
                          "",
                  width: constraints.maxWidth,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/image/no_product_asset.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              );
            }),
          ),
          Expanded(
            flex: 35,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productProvider
                                  .productModel.data?[widget.index].name ??
                              "",
                          style: TextStyle(fontSize: 12),
                          maxLines: 1,
                        ),
                        Text.rich(
                            TextSpan(style: TextStyle(fontSize: 12), children: [
                          TextSpan(text: '\$ '),
                          TextSpan(
                            text: productProvider
                                    .productModel.data?[widget.index].price
                                    .toString() ??
                                "",
                          ),
                        ])),
                        // Text(
                        //   productProvider.productModel.data?[widget.index].price
                        //           .toString() ??
                        //       "",
                        //   style: TextStyle(fontSize: 12),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  Container(
                    width: 1,
                    height: 40,
                    color: AppColors.fadedText,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 40,
                    child: itemCount == 0
                        ? InkWell(
                            onTap: () async {
                              print(widget.index);
                              await functionProvider.addProduct(itemCount);
                              itemCount = productProvider.count;
                              await functionProvider.orderProduct(
                                productId: productProvider
                                        .productModel.data?[widget.index].id ??
                                    0,
                                quantity: itemCount,
                                productPrice: productProvider.productModel
                                        .data?[widget.index].price ??
                                    0,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              height: 35,
                              child: Center(
                                  child: Text(
                                "add",
                                style: TextStyle(fontSize: 12),
                              )),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            height: 35,
                            child: Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    functionProvider
                                        .decrementProduct(itemCount);
                                    itemCount = productProvider.count;
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    size: 18,
                                  ),
                                )),
                                Text(itemCount.toString()),
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    functionProvider
                                        .incrementProduct(itemCount);
                                    itemCount = productProvider.count;
                                  },
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                  ),
                                )),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
