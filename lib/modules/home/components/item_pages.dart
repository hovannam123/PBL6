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

  late List<Category> categorys = [
    Category(id: 0, name: "Tất cả", optionGroup: "null")
  ];
  int? selectedIndex = 0;
  int? idCategory = 4;

  @override
  void initState() {
    super.initState();
    getData();
    displayItem = products;

    setState(() {
      userId = userController.id.value;
    });
  }

  bool containsElement(Category e) {
    for (Category element in categorys) {
      if (element.id.toString().compareTo(e.id.toString()) == 0) return true;
    }
    return false;
  }

  getData() {
    ApiService.instance.fetchProducts().then((products) => {
          products.forEach((element) {
            if (!containsElement(element.category!)) {
              setState(() {
                categorys.add(element.category!);
              });
            }
          })
        });
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
      results = products
          .where((element) => element.category!.id == idCategory)
          .toList();
    } else {
      results = displayItem
          .where((item) =>
              item.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      displayItem = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
              itemCount: categorys.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      idCategory = categorys[index].id;
                      displayItem = products
                          .where(
                              (element) => element.category?.id == idCategory)
                          .toList();
                    });
                    if (index == 0) {
                      setState(() {
                        displayItem = products;
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    alignment: Alignment.center,
                    width: 110,
                    decoration: selectedIndex == index
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.lightBlue)
                        : const BoxDecoration(color: Colors.transparent),
                    child: Text(
                      '${categorys[index].name}',
                      style: AppTextStyle.heading3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }),
        ),
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
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
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
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return const Text('ð¢');
                                },
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
                                  ApiService.instance
                                      .addToCart(displayItem[index].id ?? 0);
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
