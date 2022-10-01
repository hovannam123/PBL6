

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/config/app_color.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/model/genres.dart';
import 'package:pbl6/modules/home/components/category_bar.dart';
import 'package:pbl6/modules/home/components/search_bar.dart';

import 'components/item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
          CategoryBar(),
          SearchBar(),
          Expanded(
            child: Item()
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
          title: Text('PBL6: HTTT', style: AppTextStyle.heading4Light,),
          titleSpacing: 6,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){},
          ),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.person_outline)),
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
            IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined))
          ],
          backgroundColor: DarkTheme.purple,
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
