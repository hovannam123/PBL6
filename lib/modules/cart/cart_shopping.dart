
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:provider/provider.dart';

import '../../api/api_request.dart';
import '../../model/cart.dart';
import '../../model/product.dart';
import '../../provider/cartprovider.dart';
import '../detail/detail.dart';

class CartShopping extends StatefulWidget {
  const CartShopping( {Key? key,
  }) : super(key: key);

  @override
  State<CartShopping> createState() => _CartShoppingState();
}

class _CartShoppingState extends State<CartShopping> {
  bool? allCheck = false;
  late List<bool>? itemCheck;
  late Future<List<Cart>> cart;
  final ValueNotifier<int> quantity = ValueNotifier<int>(0);
  final NumberFormat decimalFormat = NumberFormat.decimalPattern();



  @override
  void initState(){
    super.initState();
    cart = NetworkRequest.getCart(4);
    itemCheck = List<bool>.filled(100, false);
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
                    // ValueListenableBuilder(
                    //     valueListenable: quantity,
                    //     builder: (context, value, child){
                    //       return Text('Tổng thanh toán: ${value.toString()}', style: AppTextStyle.heading4Light,);
                    //     }
                    // )
                     Text('Tổng thanh toán: 0đ', style: AppTextStyle.heading4Light,)
                  ],
                )
            ),
          body: FutureBuilder<List<Cart>>(
            future: cart,
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=> ItemDetails(product: snapshot.data![index].product!)));
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
                              Image.network('${snapshot.data![index].product?.productImgs?[0]}', width: 100,),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width/1.7,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${snapshot.data![index].product?.name}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: AppTextStyle.heading3Black,
                                          textAlign: TextAlign.left,),
                                        SizedBox(height: 5,),
                                        Text(
                                          'Đơn giá: ${decimalFormat.format(snapshot.data![index].product!.price)}VNĐ',
                                          style: AppTextStyle.heading4Black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   child: ValueListenableBuilder<int>(
                                  //       valueListenable: provider.cart[index].quantity!,
                                  //       builder: (context, val, child) {
                                  //         return PlusMinusButtons(
                                  //           addQuantity: () {
                                  //             cart.addQuantity(provider.cart[index].id!);
                                  //             DBHelper.instance.updateQuantity(
                                  //                 Cart(
                                  //                   id: index,
                                  //                   productId: index.toString(),
                                  //                   productName: provider.cart[index].productName,
                                  //                   productPrice: provider.cart[index].productPrice,
                                  //                   quantity: ValueNotifier(provider.cart[index].quantity!.value),
                                  //                 ))
                                  //                 .then((value) {
                                  //               setState(() {
                                  //                 cart.addTotalPrice(double.parse(
                                  //                     provider.cart[index].productPrice.toString()));
                                  //               });
                                  //             });
                                  //           },
                                  //           deleteQuantity: () {
                                  //             cart.deleteQuantity(
                                  //                 provider.cart[index].id!);
                                  //             cart.removeTotalPrice(double.parse(
                                  //                 provider.cart[index].productPrice
                                  //                     .toString()));
                                  //           },
                                  //           text: val.toString(),
                                  //         );
                                  //       }),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
    );
  }
}



