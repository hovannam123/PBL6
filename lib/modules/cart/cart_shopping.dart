import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/getxcontroller/cartcontroller.dart';
import 'package:pbl6/getxcontroller/usercontroller.dart';
import 'package:provider/provider.dart';

import '../../api/api_service.dart';
import '../../model/cart.dart';
import '../../model/product.dart';
import '../../provider/cartprovider.dart';
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
  final NumberFormat decimalFormat = NumberFormat.decimalPattern();
  final UserController userController = Get.put(UserController());


  @override
  void initState() {
    super.initState();
    getData();
    getTotal();
  }

  getData() {
    ApiService.instance.getCart(userController.id.value).then((value) =>
    {
      value.forEach((element) {
        setState(() {
          listCart.add(element);
        });
      })
    });
  }

  getTotal(){
    double totalPrice = 0;
    listCart.forEach((carts) {
      totalPrice += carts.amount*(int.parse('${carts.product!.price}'));
    });
    return decimalFormat.format(totalPrice);
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
                  'Tổng sản phẩm: ${getTotal()}đ',
                  style: AppTextStyle.heading4Light,
                )
              ],
            )),
        body: listCart.isEmpty
            ? const Center(
          child: CircularProgressIndicator()
        )
            : ListView.builder(
          itemCount: listCart.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ItemDetails(
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
                            MediaQuery
                                .of(context)
                                .size
                                .width / 1.7,
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
                                  'Đơn giá: ${decimalFormat.format(
                                      listCart[index].product!.price)}VNĐ',
                                  style: AppTextStyle.heading4Black,
                                ),
                                PlusMinusButtons(
                                    addQuantity: () {
                                      ApiService.instance
                                          .addToCart(
                                          userController.id.value,
                                          listCart[index].product?.id as int
                                      );
                                      setState(() {
                                        listCart[index].amount ++;
                                      });
                                    },
                                    deleteQuantity: () {
                                      ApiService.instance
                                          .subItemFromCart(
                                          userController.id.value,
                                          listCart[index].product?.id as int
                                      );
                                      setState(() {
                                        listCart[index].amount --;
                                        if (listCart[index].amount == 0) {
                                          setState(() {
                                            listCart.removeAt(
                                                index);
                                          });
                                        }
                                      });
                                    },
                                    amount:
                                    '${listCart[index].amount}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            ApiService.instance
                                .deleteProductFromCart(
                                listCart[index].id as int
                            );
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
        // body: FutureBuilder<List<Cart>>(
        //   future: _futureListCart,
        //   builder: (context, snapshot){
        //     if(snapshot.hasData){
        //       return ListView.builder(
        //         itemCount: snapshot.data!.length,
        //         itemBuilder: (context, index){
        //           return InkWell(
        //             onTap: (){
        //               print('ontap');
        //               Navigator.push(context, MaterialPageRoute(
        //                   builder: (context)=> ItemDetails(product: snapshot.data![index].product!)));
        //             },
        //             child: Card(
        //               color: Colors.white,
        //               elevation: 5,
        //               child: Padding(
        //                 padding: EdgeInsets.symmetric(vertical: 15),
        //                 child: Row(
        //                   children: [
        //                     Image.network('${snapshot.data![index].product?.productImgs?[0]}', width: 100,),
        //                     SizedBox(width: 10,),
        //                     Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         SizedBox(
        //                           width: MediaQuery.of(context).size.width/1.7,
        //                           child: Column(
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             children: [
        //                               Text(
        //                                 '${snapshot.data![index].product?.name}',
        //                                 overflow: TextOverflow.ellipsis,
        //                                 maxLines: 2,
        //                                 style: AppTextStyle.heading3Black,
        //                                 textAlign: TextAlign.left,),
        //                               SizedBox(height: 5,),
        //                               Text(
        //                                 'Đơn giá: ${decimalFormat.format(snapshot.data![index].product!.price)}VNĐ',
        //                                 style: AppTextStyle.heading4Black,
        //                               ),
        //                               PlusMinusButtons(
        //                                   addQuantity: (){},
        //                                   deleteQuantity: (){
        //                                     setState(() {
        //                                       ApiService.instance.subItemFromCart(userController.id.value, snapshot.data![index].product?.id as int);
        //
        //                                     });
        //                                   },
        //                                   amount: "${snapshot.data![index].amount}"
        //                               ),
        //
        //                             ],
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                     IconButton(
        //                         onPressed: (){
        //                           setState(() {
        //                             ApiService.instance.deleteProductFormCart(snapshot.data![index].id as int);
        //                           });
        //                         },
        //                         icon: Icon(Icons.delete,)
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           );
        //         },
        //       );
        //     }
        //     return const Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   }
        // )
      ),
    );
  }
}
