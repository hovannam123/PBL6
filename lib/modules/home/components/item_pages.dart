
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pbl6/config/app_color.dart';
import 'package:pbl6/config/app_text_style.dart';
import 'package:pbl6/modules/detail/detail.dart';

import '../../../api/api_request.dart';
import '../../../model/product.dart';
import 'package:intl/intl.dart';

class ItemPages extends StatefulWidget {
  const ItemPages({Key? key}) : super(key: key);
  @override
  State<ItemPages> createState() => _ItemPagesState();
}

class _ItemPagesState extends State<ItemPages>{
  late Future<List<Product>> products;
  final NumberFormat decimalFormat = NumberFormat.decimalPattern();
  // late List<Product> products = [];
  // late List<Product> displayItem = [];

  @override
  void initState() {
    super.initState();
    products = NetworkRequest.fetchProducts();
    // NetworkRequest.fetchProducts().then((value) => {
    //   value.forEach((item) {
    //    setState((){
    //      products.add(item);
    //    });
    //   })
    // });
    // displayItem = products;

  }

  // void update_display(String name){
  //   setState((){
  //     displayItem.where((item) => item.name!.toLowerCase().contains(name.toLowerCase())).toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: products,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return GridView.builder(
            itemCount: snapshot.data!.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1.5/2.8,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index){
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemDetails(product: snapshot.data![index])));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: DarkTheme.white,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.network(snapshot.data![index].productImgs![0],),
                      Text(
                        '${snapshot.data![index].name}',
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.heading3Black,
                        maxLines: 2,
                        textAlign: TextAlign.center,),
                      Text('Đơn giá: ${decimalFormat.format(snapshot.data![index].price)}',style: AppTextStyle.heading3Black),

                      FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          // checkDataContain(index);
                          // deleteData();
                        },
                        backgroundColor: Colors.lightBlue,
                        label: const Text('Thêm vào giỏ'),
                        extendedTextStyle: AppTextStyle.heading4Black,
                        icon: const Icon(Icons.add_shopping_cart_rounded),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
  // Widget build(BuildContext context) {
  //   final Size size = MediaQuery.of(context).size;
  //   return Column(
  //     children: [
  //    Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
  //     child: SizedBox(
  //       height: size.height/15,
  //       child: Container(
  //         height: size.height/15,
  //         decoration: BoxDecoration(
  //           color: Colors.grey,
  //           borderRadius: BorderRadius.circular(24),
  //         ),
  //         child: Row(
  //           children:  [
  //             const Padding(
  //               padding: EdgeInsets.only(left: 24, right: 24),
  //               child: Icon(Icons.search,color: Colors.white,),
  //             ),
  //              Expanded(
  //               child: TextField(
  //                 onChanged: (text) => update_display(text),
  //                 decoration: InputDecoration(
  //                   hintText: 'Tìm kiếm',
  //                   hintStyle: AppTextStyle.heading4Light,
  //                   border: InputBorder.none,
  //                 ),
  //               ),
  //             ),
  //             FloatingActionButton(
  //               heroTag: null,
  //               onPressed: (){},
  //               backgroundColor: Colors.blueGrey,
  //               child: Image.asset('assets/images/filter.png'),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   ),
  //       Expanded(child: GridView.builder(
  //         itemCount: displayItem.length,
  //         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
  //           maxCrossAxisExtent: 200,
  //           childAspectRatio: 1.5/2.8,
  //           mainAxisSpacing: 10,
  //           crossAxisSpacing: 10,
  //         ),
  //         itemBuilder: (context, index){
  //           return InkWell(
  //             onTap: (){
  //               Navigator.push(context, MaterialPageRoute(builder: (context)=> ItemDetails(product: displayItem[index])));
  //             },
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   color: DarkTheme.white,
  //                   borderRadius: BorderRadius.circular(8)
  //               ),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   Image.network(displayItem[index].productImgs![0],),
  //                   Text(
  //                     '${displayItem[index].name}',
  //                     overflow: TextOverflow.ellipsis,
  //                     style: AppTextStyle.heading3Black,
  //                     maxLines: 2,
  //                     textAlign: TextAlign.center,),
  //                   Text('Đơn giá: ${decimalFormat.format(displayItem[index].price)}',style: AppTextStyle.heading3Black),
  //
  //                   FloatingActionButton.extended(
  //                     heroTag: null,
  //                     onPressed: () {
  //                       // checkDataContain(index);
  //                       // deleteData();
  //                     },
  //                     backgroundColor: Colors.lightBlue,
  //                     label: const Text('Thêm vào giỏ'),
  //                     extendedTextStyle: AppTextStyle.heading4Black,
  //                     icon: const Icon(Icons.add_shopping_cart_rounded),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       )
  //       )
  //     ],
  //   );

}

