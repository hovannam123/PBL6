

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/model/trademark.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<Trademark> lstTrademark = [
    new Trademark(id: 1, name: 'ACER'),
    new Trademark(id: 2, name: 'APPLE'),
    new Trademark(id: 3, name: 'ASUS'),
    new Trademark(id: 4, name: 'DELL'),
    new Trademark(id: 5, name: 'HP'),
    new Trademark(id: 6, name: 'LG'),
    new Trademark(id: 7, name: 'LENOVO'),
  ];
  late String? dropdownValue = lstTrademark[0].name;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
      width: size.width,
      height: size.height/4,
      color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Thương hiệu', style: AppTextStyle.heading3Black,),
              DropdownButton<String>(
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                    style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  items: lstTrademark.map<DropdownMenuItem<String>>((Trademark value){
                    return DropdownMenuItem<String>(
                      value: value.name,
                      child: Text(value.name!),
                    );
                  }).toList(),
                  value: dropdownValue,
                  onChanged: (String? value){
                    setState((){
                      dropdownValue = value!;
                    });
                  },
              )
            ],
          )
        ],
      ),
    );
  }
}
