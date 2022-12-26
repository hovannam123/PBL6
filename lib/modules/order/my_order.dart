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
        title: Text(
          'Đơn hàng của tôi',
          style: AppTextStyle.heading3Light,
        ),
        centerTitle: true,
        elevation: 0,
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 110,
            decoration: const BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              child: SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 24, right: 24),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Tìm kiếm',
                            hintStyle: AppTextStyle.heading4Light,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.blueGrey,
                        child: Image.asset('assets/images/filter.png'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
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
                                    bill: orders[index].bill,
                                  )));
                    },
                    child: SizedBox(
                      height: 150,
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Ngày: ${orders[index].dayOrder}',
                              style: AppTextStyle.heading4Black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tổng đơn hàng: ${orders[index].bill!.billDetails!.length}',
                                  style: AppTextStyle.heading4Black,
                                ),
                                Text(
                                  'Thanh toán: ${decimalFormat.format(orders[index].bill!.total as double)}đ',
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
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
