
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/app_text_style.dart';
import '../../../../model/genres.dart';
import '../../../../config/app_color.dart';

class CategoryBar extends StatefulWidget {
  const CategoryBar({
    Key? key,
  }) : super(key: key);

@override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  List<Genres>? lstGenres = [
    new Genres(id: 1,name: 'Laptop'),
    new Genres(id: 2,name: 'PC'),
    new Genres(id: 3,name: 'CPU'),
    new Genres(id: 4,name: 'Hard drive'),
    new Genres(id: 4,name: 'VGA-Card'),
    new Genres(id: 4,name: 'Main'),
    new Genres(id: 4,name: 'Headphone'),
  ];

  int? selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          itemCount: lstGenres?.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){
                setState((){
                  selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                alignment: Alignment.center,
                width: 110,
                decoration: selectedIndex == index ? BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blueGrey
                ) : const BoxDecoration(color: Colors.transparent),
                child: Text('${lstGenres?[index].name}', style: AppTextStyle.heading3,),
              ),
            );
          }
      ),
    );
  }
}
