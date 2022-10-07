

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/model/laptop.dart';

import 'components/slider_image.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({Key? key,
    required this.lap
  }) : super(key: key);

  final Laptop lap;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SliderImage(size: size),
            Text('${widget.lap.name}', style: AppTextStyle.heading3Light,),
            SizedBox(height: 10,),
            Text('đ${widget.lap.price}', style: AppTextStyle.heading3Red, ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('Đánh giá: 4/5', style: AppTextStyle.heading4Light,),
                SizedBox(width: 20,),
                Text('Tình trạng: Còn hàng',style: AppTextStyle.heading4Light,)
              ],
            ),
            SizedBox(height: 10,),
            Text('Thông số kĩ thuật:', style: AppTextStyle.heading3Light,),
            Container(
              color: Colors.grey,
              child: Table(
                border: TableBorder.all(
                    color: Colors.white,
                    style: BorderStyle.solid,
                    width: 2
                ),
                children: [
                  TableRow( children: [
                    Column(children:[Text('Sản phẩm', style: AppTextStyle.heading2Black)]),
                    Column(children:[Text('Laptop', style: AppTextStyle.heading2Black)]),
                  ]),
                  TableRow( children: [
                    Column(children:[Text('Thương hiệu', style: AppTextStyle.heading3Black,)]),
                    Column(children:[Text('MSI', style: AppTextStyle.heading3Black,)]),
                  ]),
                  TableRow( children: [
                    Column(children:[Text('Thời gian bảo hành', style: AppTextStyle.heading3Black,)]),
                    Column(children:[Text('12 tháng', style: AppTextStyle.heading3Black,)]),
                  ]),
                  TableRow( children: [
                    Column(children:[Text('Bộ xử lý', style: AppTextStyle.heading3Black,)]),
                    Column(children:[Text('Core i5', style: AppTextStyle.heading3Black,)]),
                  ]),
                  TableRow( children: [
                    Column(children:[Text('Ram', style: AppTextStyle.heading3Black,)]),
                    Column(children:[Text('8 GB', style: AppTextStyle.heading3Black,)]),
                  ]),
                  TableRow( children: [
                    Column(children:[Text('Màn hình', style: AppTextStyle.heading3Black,)]),
                    Column(children:[Text('15.6 inch', style: AppTextStyle.heading3Black,)]),
                  ]),
                  TableRow( children: [
                    Column(children:[Text('Đồ họa', style: AppTextStyle.heading3Black,)]),
                    Column(children:[Text('GeForce RTX 3050', style: AppTextStyle.heading3Black,)]),
                  ]),
                  TableRow( children: [
                    Column(children:[Text('Lưu trữ', style: AppTextStyle.heading3Black,)]),
                    Column(children:[Text('SSD 512 GB', style: AppTextStyle.heading3Black,)]),
                  ]),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}


