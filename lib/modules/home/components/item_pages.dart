import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/config/app_color.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/modules/detail/detail.dart';
import 'package:provider/provider.dart';

import '../../../database/DBHelper.dart';
import '../../../model/cart.dart';
import '../../../model/laptop.dart';
import '../../../provider/cartprovider.dart';

class ItemPages extends StatefulWidget {
  const ItemPages({Key? key}) : super(key: key);
  @override
  State<ItemPages> createState() => _ItemPagesState();
}

class _ItemPagesState extends State<ItemPages> {

  List<Cart> listCartShopping = [];

  List<Laptop> laps = [
    new Laptop(id: 1, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: 50),
    new Laptop(id: 2, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: 60),
    new Laptop(id: 3, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: 70),
    new Laptop(id: 4, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: 80),
    new Laptop(id: 5, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: 90),
    new Laptop(id: 6, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: 100),
    new Laptop(id: 7, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: 110),
    new Laptop(id: 8, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: 120),
    new Laptop(id: 8, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: 130),
    new Laptop(id: 10, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: 140),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    void saveData(int index) async{
      cart.addCounter();
      cart.addTotalPrice(laps[index].price!.toDouble());
      await DBHelper.instance.insert(
        Cart(
          id: index,
          productId: index.toString(),
          productName: laps[index].name,
          productPrice: laps[index].price,
          quantity: ValueNotifier(1),
        ),
      );
    }

    void checkDataContain(int index) async{
      List<Cart> list = await DBHelper.instance.getCartList();

      if(list.isEmpty){
        saveData(index);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sản phẩm đã được thêm vào giỏ hàng', style: AppTextStyle.heading4Light,)),
        );
      }
      else{
        for(var cart in list){
          if(cart.id == index){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sản phẩm đã có sẵn trong giỏ hàng', style: AppTextStyle.heading4Light,)),
            );
            break;
          }
          else{
            saveData(index);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sản phẩm đã được thêm vào giỏ hàng', style: AppTextStyle.heading4Light,)),
            );
            break;
          }
        }
      }
    }

    void deleteData(){
      DBHelper.instance.deleteDatabase();
      cart.delete();
    }

    return GridView.builder(
      itemCount: laps.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        childAspectRatio: 1.5/2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index){
        return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemDetails(lap: laps[index],)));
          },
          child: Container(
              decoration: BoxDecoration(
                color: DarkTheme.darkGrey,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/images/laptop.png', width: 90, height: 100,),
                  Text('${laps[index].name}', style: AppTextStyle.heading3Light, textAlign: TextAlign.center,),
                  Text('Đơn giá: ${laps[index].price}đ',style: AppTextStyle.heading3Light),

                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: () {
                      checkDataContain(index);
                      // deleteData();
                    },
                    backgroundColor: Colors.blueGrey,
                    label: Text('Thêm vào giỏ'),
                    extendedTextStyle: AppTextStyle.heading4Light,
                    icon: Icon(Icons.add_shopping_cart_rounded),
                  ),
                ],
              ),
          ),
        );
      },
    );
  }
}

