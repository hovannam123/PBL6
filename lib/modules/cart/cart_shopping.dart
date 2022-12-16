
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/getxcontroller/cartcontroller.dart';
import 'package:pbl6/getxcontroller/usercontroller.dart';
import 'package:provider/provider.dart';

import '../../api/api_request.dart';
import '../../model/cart.dart';
import '../../model/product.dart';
import '../../provider/cartprovider.dart';
import '../detail/detail.dart';
import 'components/plusminusbuttons.dart';

class CartShopping extends StatefulWidget {
  const CartShopping( {Key? key,
  }) : super(key: key);

  @override
  State<CartShopping> createState() => _CartShoppingState();
}

class _CartShoppingState extends State<CartShopping> {
  bool? allCheck = false;
  late List<bool>? itemCheck;
  final List<Cart> listCart = [];
  final ValueNotifier<int> quantity = ValueNotifier<int>(0);
  final NumberFormat decimalFormat = NumberFormat.decimalPattern();
  final UserController userController = Get.put(UserController());
  final cartController = Get.put(CartController());

  @override
  void initState(){
    super.initState();
    NetworkRequest.getCart(userController.id.value).then((carts) => {
      carts.forEach((item) {
        setState((){
          listCart.add(item);
        });
      }),
    cartController.count = listCart.length.obs
    });
    itemCheck = List<bool>.filled(100, false);
  }

  double getTotal(){
    double totalPrice = 0;
    listCart.forEach((carts) {
      totalPrice += carts.amount!*(int.parse('${carts.product!.price}'));
    });
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Giỏ hàng', style: AppTextStyle.heading3Light,),
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white,size: 27,),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended (
            elevation: 4.0,
            icon: const Icon(Icons.add),
            label: const Text('Đặt hàng', style: AppTextStyle.heading4Light,),
            onPressed: () {},
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
                        Text('Tất cả', style: AppTextStyle.heading4Light,)
                      ],
                    ),
                    SizedBox(width: 20,),
                    Text('Tổng thanh toán: ${getTotal()}')

                  ],
                )
            ),
          body: ListView.builder(
            itemCount: listCart.length,
            itemBuilder: (context, index){
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=> ItemDetails(product: listCart[index].product!)));
                },
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      children: [
                        Checkbox(
                          value: itemCheck![index],
                          onChanged: (bool? value){
                            setState((){
                              itemCheck![index] = value!;
                            });
                          },
                        ),
                        Image.network('${listCart[index].product?.productImgs?[0]}', width: 100,),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width/1.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text('${cartController.listCart[index].brand}'),
                                  Text(
                                    '${listCart[index].product?.name}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: AppTextStyle.heading3Black,
                                    textAlign: TextAlign.left,),
                                  SizedBox(height: 5,),
                                  Text(
                                    'Đơn giá: ${decimalFormat.format(listCart[index].product!.price)}VNĐ',
                                    style: AppTextStyle.heading4Black,
                                  ),
                                  ValueListenableBuilder(
                                      valueListenable: quantity,
                                      builder: (context, value, child){
                                        return PlusMinusButtons(
                                            addQuantity: (){
                                              quantity.value++;
                                            },
                                            deleteQuantity: (){
                                              if(quantity.value > 1){
                                                quantity.value--;
                                              }
                                            },
                                            text: value.toString()
                                        );
                                      }
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ),
    );
  }
}



