import 'package:filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pbl6/config/app_color.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/getxcontroller/usercontroller.dart';
import 'package:pbl6/modules/detail/item_detail.dart';

import '../../../api/api_service.dart';
import '../../../api/api_service.dart';
import '../../../model/option.dart';
import '../../../model/product.dart';
import 'package:intl/intl.dart';

class ItemPages extends StatefulWidget {
  const ItemPages({Key? key}) : super(key: key);

  @override
  State<ItemPages> createState() => _ItemPagesState();
}

class _ItemPagesState extends State<ItemPages> {
  final NumberFormat decimalFormat = NumberFormat.decimalPattern();
  final List<Product> products = [];
  late Future<bool> addToCart;
  List<Product> displayItem = [];
  late List<Option> options = [];
  UserController userController = Get.put(UserController());
  late int userId;

  @override
  void initState() {
    super.initState();

    ApiService.instance.getOption().then((value) => {
          value.forEach((item) {
            setState(() {
              options.add(item);
            });
          })
        });

    ApiService.instance.fetchProducts().then((value) => {
          value.forEach((item) {
            setState(() {
              products.add(item);
            });
          })
        });
    displayItem = products;

    setState(() {
      userId = userController.id.value;
    });
  }

  void openFilterDialog() async {
    await FilterListDialog.display<Option>(
      context,
      listData: options,
      // selectedListData: selectedoptions,
      choiceChipLabel: (user) => user!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        // setState(() {
        //   selectedUserList = List.from(list!);
        // });
        // Navigator.pop(context);
      },
    );
  }

  void update_display(String enteredKeyword) {
    List<Product> results = [];
    if (enteredKeyword.isEmpty) {
      results = products;
    } else {
      results = products
          .where((item) =>
              item.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      displayItem = results;
    });
  }

  var a = [
    DropdownMenuItem(child: Text('dataaaa')),
    DropdownMenuItem(child: Text('dataaaa')),
    DropdownMenuItem(child: Text('dataaaa')),
    DropdownMenuItem(child: Text('dataaaa')),
    DropdownMenuItem(child: Text('dataaaa')),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: SizedBox(
            height: size.height / 15,
            child: Container(
              height: size.height / 15,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (text) => update_display(text),
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm',
                        hintStyle: AppTextStyle.heading4Light,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: SizedBox(
                                height: 400,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                            '${options[3].optionGroup![0].name}'),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    backgroundColor: Colors.blueGrey,
                    child: Image.asset('assets/images/filter.png'),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
            child: displayItem.isEmpty
                ? const Center(child: CircularProgressIndicator(),)
                : GridView.builder(
                    itemCount: displayItem.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.5 / 2.8,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemDetails(
                                      product: displayItem[index])));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: DarkTheme.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.network(
                                displayItem[index].productImgs![0],
                              ),
                              Text(
                                '${displayItem[index].name}',
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.heading3Black,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                  'Đơn giá: ${decimalFormat.format(displayItem[index].price)}',
                                  style: AppTextStyle.heading3Black),
                              FloatingActionButton.extended(
                                heroTag: null,
                                onPressed: () {
                                  ApiService.instance.addToCart(
                                      userId, displayItem[index].id ?? 0);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                      "Thêm vào giỏ hàng thành công",
                                      style: AppTextStyle.heading4Light,
                                    ),
                                    backgroundColor: Colors.grey,
                                  ));
                                },
                                backgroundColor: Colors.lightBlue,
                                label: const Text('Thêm vào giỏ'),
                                extendedTextStyle: AppTextStyle.heading4Black,
                                icon: const FaIcon(FontAwesomeIcons.cartPlus),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ))
      ],
    );
  }
}
