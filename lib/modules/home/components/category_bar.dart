// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/api/api_service.dart';
import 'package:pbl6/model/product.dart';

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
  late List<Category> categorys = [];
  int? selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  bool containsElement(Category e) {
    for (Category element in categorys) {
      if (element.id.toString().compareTo(e.id.toString()) == 0) return true;
    }
    return false;
  }

  getData() {
    ApiService.instance.fetchProducts().then((products) => {
          products.forEach((element) {
            if (!containsElement(element.category!)) {
              setState(() {
                categorys.add(element.category!);
              });
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          itemCount: categorys.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                alignment: Alignment.center,
                width: 110,
                decoration: selectedIndex == index
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.lightBlue)
                    : const BoxDecoration(color: Colors.transparent),
                child: Text(
                  '${categorys[index].name}',
                  style: AppTextStyle.heading3,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
    );
  }
}
