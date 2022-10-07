

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/app_color.dart';
import '../../../config/app_text_style.dart';


class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      child: SizedBox(
        height: size.height/15,
        child: Container(
          height: size.height/15,
          decoration: BoxDecoration(
            color: DarkTheme.darkGrey,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children:  [
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Icon(Icons.search,color: Colors.white,),
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
                onPressed: (){},
                backgroundColor: Colors.blueGrey,
                child: Image.asset('assets/images/filter.png'),
              )
            ],
          ),
        ),
      ),
    );
  }
}