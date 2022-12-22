import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pbl6/api/api_service.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/model/product.dart';

import '../cart/components/plusminusbuttons.dart';
import 'components/slider_image.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    final NumberFormat decimalFormat = NumberFormat.decimalPattern();
    final ValueNotifier<int> quantity = ValueNotifier<int>(1);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderImage(size: size, product: widget.product),
              SizedBox(
                height: 10,
              ),
              Text(
                '${widget.product.name}',
                style: AppTextStyle.heading3BlackBold,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Thương hiệu: ${widget.product.brand?.name}',
                style: AppTextStyle.heading3Black,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'đ${decimalFormat.format(widget.product.price)}',
                style: AppTextStyle.heading2Red,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Đánh giá: ${widget.product.rate}',
                    style: AppTextStyle.heading3Black,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('|'),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Tình trạng: ${widget.product.status == true ? 'Còn hàng' : 'Hết hàng'}',
                    style: AppTextStyle.heading3Black,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Thông số kĩ thuật:',
                style: AppTextStyle.heading3Black,
              ),
              Table(
                border: TableBorder.all(color: Colors.black),
                children: List<TableRow>.generate(
                  widget.product.attributes!.length,
                  (index) {
                    final attributes = widget.product.attributes![index];
                    return TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            attributes.optionGroup.toString(),
                            textAlign: TextAlign.center,
                            style: AppTextStyle.heading4Black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(attributes.name.toString(),
                              textAlign: TextAlign.center,
                              style: AppTextStyle.heading4Black),
                        ),
                      ],
                    );
                  },
                  growable: false,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        backgroundColor: Colors.lightBlue,
        icon: const FaIcon(
          FontAwesomeIcons.cartPlus,
          color: Colors.white,
        ),
        label: const Text(
          'Thêm vào giỏ',
          style: AppTextStyle.heading4Light,
        ),
        onPressed: () {
          ApiService.instance.addToCart(widget.product.id!);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Thêm vào giỏ hàng thành công",
              style: AppTextStyle.heading4Light,
            ),
            backgroundColor: Colors.grey,
          ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ValueListenableBuilder(
                valueListenable: quantity,
                builder: (context, value, child) {
                  return PlusMinusButtons(
                      addQuantity: () {
                        quantity.value++;
                      },
                      deleteQuantity: () {
                        if (quantity.value > 1) {
                          quantity.value--;
                        }
                      },
                      amount: value.toString());
                }),
          ],
        ),
      ),
    );
  }
}
