

import 'package:flutter/cupertino.dart';
import 'package:pbl6/model/product.dart';

import 'arrow_back.dart';

class SliderImage extends StatelessWidget {
  const SliderImage({
    Key? key,
    required this.size,
    required this.product,
  }) : super(key: key);

  final Size size;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Stack(
              children: [
                SizedBox(
                  height: 320,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.productImgs?.length,
                      itemBuilder: (context,index){
                        return Container(
                          padding: EdgeInsets.only(right: 5),
                          child: AspectRatio(
                            aspectRatio: 7/5.7,
                            child: Image(
                              image: NetworkImage('${product.productImgs?[index]}'),
                              fit: BoxFit.fill, // use this
                            ),
                          ),
                        );
                      }
                  ),
                ),
                const ArrowBack(),
              ],
            )
        ),
      ],
    );
  }
}