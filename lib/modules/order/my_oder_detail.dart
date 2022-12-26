import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pbl6/api/api_service.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/model/order.dart';
import 'package:pbl6/modules/detail/item_detail.dart';

class MyOrderDetail extends StatefulWidget {
  const MyOrderDetail({super.key, required this.bill});
  final Bill? bill;

  @override
  State<MyOrderDetail> createState() => _MyOrderDetailState();
}

class _MyOrderDetailState extends State<MyOrderDetail> {
  final NumberFormat decimalFormat = NumberFormat.decimalPattern();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Chi tiết đơn hàng',
          style: AppTextStyle.heading3Light,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.home,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView.builder(
        itemCount: widget.bill!.billDetails!.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemDetails(
                          product: widget.bill!.billDetails![index].orderDetail!
                              .product!)));
            },
            child: Card(
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    Image.network(
                      '${widget.bill!.billDetails![index].orderDetail!.product?.productImgs?[0]}',
                      width: 100,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.bill!.billDetails![index].orderDetail!.product!.name}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: AppTextStyle.heading3Black,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Số lượng: ${widget.bill!.billDetails![index].orderDetail!.amount}',
                            style: AppTextStyle.heading4Black,
                          ),
                          Text(
                            'Đơn giá: ${decimalFormat.format(widget.bill!.billDetails![index].orderDetail!.product!.price)}VNĐ',
                            style: AppTextStyle.heading4Black,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        ApiService.instance.addToCart(widget.bill!
                            .billDetails![index].orderDetail!.product!.id!);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "Thêm vào giỏ hàng thành công",
                            style: AppTextStyle.heading4Light,
                          ),
                          backgroundColor: Colors.grey,
                        ));
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: SizedBox(
              height: 60,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ngày đặt hàng: ${widget.bill!.day}',
                      style: AppTextStyle.heading3Light,
                    ),
                    Text(
                      'Tổng đơn hàng: ${decimalFormat.format(widget.bill!.total)}đ',
                      style: AppTextStyle.heading3Light,
                    ),
                  ]))),
    );
  }
}
