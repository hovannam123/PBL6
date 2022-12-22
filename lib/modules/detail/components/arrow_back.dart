import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pbl6/api/api_service.dart';
import 'package:pbl6/modules/cart/cart_shopping.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {
              ApiService.instance.getCart();
              Navigator.push(
                  context,
                  (MaterialPageRoute(
                      builder: (context) => const CartShopping())));
            },
            icon: const FaIcon(
              FontAwesomeIcons.cartShopping,
              color: Colors.black,
              size: 27,
            ),
          ),
        ],
      ),
    );
  }
}
