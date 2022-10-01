
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/config/app_color.dart';
import 'package:pbl6/config/app_text_style.dart';

import '../../../model/laptop.dart';

class Item extends StatefulWidget {
  const Item({Key? key}) : super(key: key);
  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {

  List<Laptop> laps = [
    new Laptop(id: 1, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: '50'),
    new Laptop(id: 2, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: '50'),
    new Laptop(id: 3, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: '50'),
    new Laptop(id: 4, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: '50'),
    new Laptop(id: 5, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: '50'),
    new Laptop(id: 6, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: '50'),
    new Laptop(id: 7, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: '50'),
    new Laptop(id: 8, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: '50'),
    new Laptop(id: 8, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: '50'),
    new Laptop(id: 10, name: 'MSI GF65 Thin 11SC 662VN', amount: 13, price: '50'),
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: laps.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        childAspectRatio: 1.5/2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index){
        return Container(
            decoration: BoxDecoration(
              color: DarkTheme.darkGrey,
              borderRadius: BorderRadius.circular(8)
            ),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Image.asset('assets/images/laptop.png', width: 90, height: 100,),
                SizedBox(height: 10,),
                Center(
                  child: Text('${laps[index].name}', style: AppTextStyle.heading3Light,),
                ),
                Text('Đơn giá: ${laps[index].price}',style: AppTextStyle.heading4Light),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.small(
                      onPressed: (){},
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.add),
                    ),
                    Text(' Add to cart', style: AppTextStyle.heading4Light,)
                  ],
                )
              ],
            ),
        );
      },
    );
  }
}
