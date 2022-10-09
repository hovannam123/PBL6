

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/config/app_color.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/model/genres.dart';
import 'package:pbl6/modules/home/components/category_bar.dart';
import 'package:pbl6/modules/home/components/search_bar.dart';

import '../../model/user.dart';
import 'components/item_pages.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final tabs = [
    Container(
      child: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            child: Column(
              children: [
                SizedBox(height: 10,),
                CategoryBar(),
                SearchBar(),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white)
            ),
          ),
          Expanded(
            child: ItemPages()
          )
        ],
      ),
    ),
    Container(
      child: Center(
        child: Text('cua hang'),
      ),
    ),
    Container(
      child: Center(
        child: Text('ho tro'),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PBL6: HTTT', style: AppTextStyle.heading4Light,),
          titleSpacing: 6,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: (){},
          ),
          actions: [
            IconButton(onPressed: (){print(widget.user.name);}, icon: Icon(Icons.person_outline)),
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
            IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined))
          ],
          backgroundColor: Colors.blueGrey,
          elevation: 20,
        ),
        body: Container(child: tabs[_selectedIndex],),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 25,
          selectedLabelStyle: AppTextStyle.heading3,
          unselectedLabelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits),
              label: 'Sản phẩm',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop),
              label: 'Cửa hàng'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.support),
                label: 'Hỗ trợ'
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: (index){
            setState((){
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
