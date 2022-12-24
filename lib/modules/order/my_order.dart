import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pbl6/api/api_service.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/model/order.dart';
import 'package:pbl6/modules/order/my_oder_detail.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  final NumberFormat decimalFormat = NumberFormat.decimalPattern();
  late List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    ApiService.instance.getOrder().then((value) => {
          setState(() {
            orders = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(left: 40),
          child: const Text(
            'Đơn hàng của tôi',
            style: AppTextStyle.heading3Light,
          ),
        ),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home),
            color: Colors.white,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyOrderDetail(
                              billDetais: orders[index].bill!.billDetails,
                            )));
              },
              child: Card(
                child: Column(
                  children: [
                    Text(
                      'Ngày: ${orders[index].dayOrder}',
                      style: AppTextStyle.heading4Black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng bill: ${orders[index].bill!.billDetails!.length}',
                          style: AppTextStyle.heading4Black,
                        ),
                        Text(
                          'Thanh toán: ${decimalFormat.format((orders[index].bill!.total as double) * 2400)}đ',
                          style: AppTextStyle.heading4Black,
                        ),
                      ],
                    ),
                    Text(
                      'Tình trạng: ${orders[index].orderStatus!.name}',
                      style: AppTextStyle.heading4Black,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class $ {}
