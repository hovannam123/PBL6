import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:provider/provider.dart';

import '../../model/cart.dart';
import '../../provider/cartprovider.dart';

class CartShopping extends StatefulWidget {
  const CartShopping( {Key? key,
  }) : super(key: key);

  @override
  State<CartShopping> createState() => _CartShoppingState();
}

class _CartShoppingState extends State<CartShopping> {
  bool? checkboxAll = false;
  late List<bool>? _isChecked;


  @override
  void initState() {
    super.initState();
    context.read<CartProvider>().getData();
    _isChecked = List<bool>.filled(100, false);
  }

  @override
  Widget build(BuildContext context) {
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
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: checkboxAll,
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxAll = value;
                        });
                      },
                    ),
                    Text('Tất cả', style: AppTextStyle.heading4Black,)
                  ],
                ),
                SizedBox(width: 20,),
                Text('Tổng thanh toán: 10d', style: AppTextStyle.heading4Black,)
              ],
            ),
          ),
          body: Consumer<CartProvider>(
            builder: (context, provider, child){
              if(provider.cart.isEmpty){
                return const Center(
                  child: Text('Your Cart is Empty',
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
                              value: _isChecked![index],
                              onChanged: (bool? value){
                                setState((){
                                  _isChecked![index] = value!;
                                });
                              },
                            ),
                            Image.asset('assets/images/laptop.png', width: 100,),
                            SizedBox(width: 10,),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: AutoSizeText(
                                      '${provider.cart[index].productName}',
                                       style: AppTextStyle.heading4Black,
                                      minFontSize: 18,
                                      maxLines: 2,
                                    ),
                                    width: 150,
                                  ),
                                  AutoSizeText(
                                    'Đơn giá: ${provider.cart[index].productPrice}',
                                    style: AppTextStyle.heading4Black,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  // IconButton(
                                  //   onPressed: (){},
                                  //   icon: FaIcon(FontAwesomeIcons.gamepad),
                                  // ),
                                  Text('${provider.cart[index].quantity}', style: AppTextStyle.heading4Black,),
                                  // IconButton(
                                  //   onPressed: (){},
                                  //   icon: FaIcon(FontAwesomeIcons.gamepad),
                                  // ),
                                ],
                              ),
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
