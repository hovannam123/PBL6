import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pbl6/config/app_color.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/model/login.dart';

import '../../getxcontroller/usercontroller.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<ItemView> lst = [
    new ItemView(Icon(Icons.heart_broken_rounded), "Đã thích"),
    new ItemView(Icon(Icons.access_time), "Đã xem gần đây"),
    new ItemView(Icon(Icons.money), "Số dư tài khoản"),
    new ItemView(Icon(Icons.star_rate_outlined), "Đánh giá của tôi"),
    new ItemView(Icon(Icons.shop_2), "Đơn của tôi"),
    new ItemView(Icon(Icons.shopping_cart), "Thông tin cửa hàng"),
    new ItemView(Icon(Icons.contact_support_outlined), "Trung tâm trợ giúp"),
  ];
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final UserController informationController = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.cartShopping,)
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.message_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric( horizontal: 10),
            height: size.height/7,
            decoration: const BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircleAvatar(child: Icon(Icons.person,size: 50,),),
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Text(informationController.name.value, style: AppTextStyle.heading4Black,),
                    Text(informationController.email.value, style: AppTextStyle.heading4Black),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Expanded(child: ListView.builder(
            itemCount: lst.length,
            itemBuilder: (context, index){
              return InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric( horizontal: 10),
                  margin: EdgeInsets.only(bottom: 10),
                  color: Colors.white,
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: lst[index].leadingIcon,
                          ),
                          Text(lst[index].name.toString(), style: AppTextStyle.heading4Black,)
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_outlined, size: 20,)
                    ],
                  ),
                ),
                onTap: (){},
              );
            },
          )),
          Container(
            margin: EdgeInsets.only(bottom: 105),
            color: Colors.white,
            height: 45,
            child: FlatButton(
              onPressed: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(Icons.settings),
                      ),
                      Text( "Thiết lập tài khoản", style: AppTextStyle.heading4Black,)
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_outlined, size: 20,)
                ],
              ),
            ),
          ),
          Container(
            height: 45,
            width: size.width/2,
            margin: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  minimumSize: const Size(88, 36),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)
                      )
                  )
              ),
              onPressed: () {  },
              child: Text("Đăng xuất", style: AppTextStyle.heading4Black,),
            ),
          )
        ],
      ),
    );
  }
}

class ItemView{
  late  Icon? leadingIcon;
  late String? name;
  
  ItemView(this.leadingIcon,this.name);
}
