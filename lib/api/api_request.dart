
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbl6/model/login.dart';
import 'package:pbl6/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cart.dart';


class NetworkRequest {

  static Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "https://backendpbl6.herokuapp.com/login";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': '${requestModel.username}',
        'password': '${requestModel.password}'
      }),
    );
    if(response.statusCode == 200 || response.statusCode == 400){
      return LoginResponseModel.fromJson(json.decode(response.body));
    }
    else{
      throw Exception('Can not request api, the status code is: ${response.statusCode}');
    }
  }


  static List<Product> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) =>Product.fromJson(json)).toList();
  }

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('http://backendpbl6.herokuapp.com/product'));
    if (response.statusCode == 200) {
      return parseProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }


  static Future<List<Cart>> getCart(int userId) async{
    String url = "https://backendpbl6.herokuapp.com/cart/$userId";
    String? token = await getToken();

    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if(response.statusCode == 200 || response.statusCode == 400){
      return (json.decode(response.body)as List)
          .map((e) => Cart.fromJson(e))
          .toList();
    }
    else{
      throw Exception('Can not request api, the status code is: ${response.statusCode}');
    }
  }

  static void setToken(String token) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  static Future<String?> getToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

}


