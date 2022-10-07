

import 'package:flutter/cupertino.dart';

import 'arrow_back.dart';

class SliderImage extends StatelessWidget {
  const SliderImage({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

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
                      itemCount: 5,
                      itemBuilder: (context,index){
                        return Container(
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            width: size.width-20,
                            child: Image.asset('assets/images/img_2.png')
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