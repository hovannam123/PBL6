import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/database/DBHelper.dart';
import 'package:provider/provider.dart';

import '../../model/cart.dart';
import '../../provider/cartprovider.dart';
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


  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getData();
    itemCheck = List<bool>.filled(100, false);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return MaterialApp(
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
            child: Consumer<CartProvider>(
              builder: (context, value, child){
                final ValueNotifier<int?> totalPrice = ValueNotifier(null);
                for (var element in value.cart) {
                  totalPrice.value =
                      (element.productPrice! * element.quantity!.value) +
                          (totalPrice.value ?? 0);
                }
                return Row(
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
                    ValueListenableBuilder(
                        valueListenable: totalPrice,
                        builder: (context, value, child){
                          return Text('Tổng thanh toán: ${value.toString()}', style: AppTextStyle.heading4Light,);
                        }
                    )
                  ],
                );
              },
            ),
          ),
          body: Consumer<CartProvider>(
            builder: (context, provider, child){
              if(provider.cart.isEmpty){
                return const Center(
                  child: Text('Giỏ hàng trống',
                  style: AppTextStyle.heading4Black,
                  ));
              }
              else{
                return ListView.builder(
                  itemCount: provider.cart.length,
                  itemBuilder: (context, index){
                    return Card(
                      color: Colors.blueGrey,
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
                            Image.asset('assets/images/laptop.png', width: 100,),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          '${provider.cart[index].productName}',
                                          style: AppTextStyle.heading4Black,
                                        ),
                                      ),
                                      Text(
                                        'Đơn giá: ${provider.cart[index].productPrice}',
                                        style: AppTextStyle.heading4Black,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child: ValueListenableBuilder<int>(
                                      valueListenable: provider.cart[index].quantity!,
                                      builder: (context, val, child) {
                                        return PlusMinusButtons(
                                          addQuantity: () {
                                            cart.addQuantity(provider.cart[index].id!);
                                            DBHelper.instance.updateQuantity(
                                                Cart(
                                                  id: index,
                                                  productId: index.toString(),
                                                  productName: provider.cart[index].productName,
                                                  productPrice: provider.cart[index].productPrice,
                                                  quantity: ValueNotifier(provider.cart[index].quantity!.value),
                                                ))
                                                .then((value) {
                                                  setState(() {
                                                    cart.addTotalPrice(double.parse(
                                                        provider.cart[index].productPrice.toString()));
                                                  });
                                            });
                                          },
                                          deleteQuantity: () {
                                            cart.deleteQuantity(
                                                provider.cart[index].id!);
                                            cart.removeTotalPrice(double.parse(
                                                provider.cart[index].productPrice
                                                    .toString()));
                                          },
                                          text: val.toString(),
                                        );
                                      }),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        )
    );
  }
}
