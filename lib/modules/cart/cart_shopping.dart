import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/getxcontroller/usercontroller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/api_service.dart';
import '../../model/cart.dart';
import '../detail/item_detail.dart';
import 'components/plusminusbuttons.dart';

class CartShopping extends StatefulWidget {
  const CartShopping({
    Key? key,
  }) : super(key: key);

  @override
  State<CartShopping> createState() => _CartShoppingState();
}

class _CartShoppingState extends State<CartShopping> {
  bool? allCheck = true;
  late List<Cart> listCart = [];
  late List<int> listIdCart = [];
  final NumberFormat decimalFormat = NumberFormat.decimalPattern();
  final UserController userController = Get.put(UserController());
  String url = '';

  @override
  void initState() {
    super.initState();
    getData();
    getTotal();
  }

  getData() {
    ApiService.instance.getCart().then((value) => {
          value.forEach((element) {
            setState(() {
              listCart.add(element);
              listIdCart.add(element.id!);
            });
          })
        });
  }

  getTotal() {
    double totalPrice = 0;
    listCart.forEach((carts) {
      totalPrice += carts.amount * (int.parse('${carts.product!.price}'));
    });
    return totalPrice;
  }

  Future<void> _launchUrl(String url) async {
    if (await launchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.platformDefault);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Giỏ hàng',
            style: AppTextStyle.heading3Light,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
              size: 27,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 4.0,
          icon: const Icon(Icons.add),
          label: const Text(
            'Đặt hàng',
            style: AppTextStyle.heading4Light,
          ),
          onPressed: () {
            ApiService.instance.paypal(getTotal() / 24000, listIdCart).then(
                (url) => {
                      _launchUrl(url.split('"')[1].split('"')[0]),
                    }, onError: (err) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Lỗi thanh toán",
                  style: AppTextStyle.heading4Light,
                ),
                backgroundColor: Colors.grey,
              ));
            });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomAppBar(
            color: Colors.blue,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      checkColor: Colors.black,
                      activeColor: Colors.white,
                      value: allCheck,
                      onChanged: (bool? value) {
                        setState(() {
                          allCheck = value;
                        });
                      },
                    ),
                    const Text(
                      'Tất cả',
                      style: AppTextStyle.heading4Light,
                    )
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Tổng sản phẩm: ${decimalFormat.format(getTotal())}đ',
                  style: AppTextStyle.heading4Light,
                )
              ],
            )),
        body: listCart.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: listCart.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemDetails(
                                  product: listCart[index].product!)));
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Image.network(
                              '${listCart[index].product?.productImgs?[0]}',
                              width: 100,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${listCart[index].product?.name}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: AppTextStyle.heading3Black,
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Đơn giá: ${decimalFormat.format(listCart[index].product!.price)}VNĐ',
                                        style: AppTextStyle.heading4Black,
                                      ),
                                      PlusMinusButtons(
                                          addQuantity: () {
                                            ApiService.instance.addToCart(
                                                listCart[index].product?.id
                                                    as int);
                                            setState(() {
                                              listCart[index].amount++;
                                            });
                                          },
                                          deleteQuantity: () {
                                            ApiService.instance.subItemFromCart(
                                                listCart[index].product?.id
                                                    as int);
                                            setState(() {
                                              listCart[index].amount--;
                                              if (listCart[index].amount == 0) {
                                                setState(() {
                                                  listCart.removeAt(index);
                                                });
                                              }
                                            });
                                          },
                                          amount: '${listCart[index].amount}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  ApiService.instance.deleteProductFromCart(
                                      listCart[index].id as int);
                                  setState(() {
                                    listCart.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
