
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6/model/product.dart';

class NetworkRequest {
  static const String urlProduct = 'http://backendpbl6.herokuapp.com/product';
  List<Product> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) =>Product.fromJson(json)).toList();
  }
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(urlProduct));
    if (response.statusCode == 200) {
      return parseProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }



  // static List<Product> parseResults(String requestBody){
  //     final json = "[" + requestBody + "]";
  //     var jsons = jsonDecode(json);
  //     List<Product> product = [];
  //     for (var jsons2 in jsons) {
  //       product.add(Product.fromJson(jsons2));
  //     }
  //     return product;
  // }
  //
  // static Future<List<Product>> fecthProduct(http.Client client) async{
  //   final response = await client.get(Uri.parse(urlProduct));
  //   if(response.statusCode == 200){
  //     return compute(parseResults, response.body);
  //   }
  //   else {
  //     throw Exception('Cant');
  //   }
  // }


  static Future<List<Product>> fecthProduct(http.Client client)  async{

    final response = await client.get(Uri.parse(urlProduct));
    List<Product> products = [];
    if(response.statusCode == 200){
      products.add(Product.fromJson(json.decode(response.body)));
      return products;
    }
    else{
      throw Exception("Can\'t conect to fecth");
    }
  }

}


