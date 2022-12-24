import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6/model/login.dart';
import 'package:pbl6/model/order.dart';
import 'package:pbl6/model/product.dart';

import '../getxcontroller/usercontroller.dart';
import '../model/cart.dart';
import '../model/option.dart';

class ApiService {
  static ApiService? _instance;

  ApiService._();

  static ApiService get instance => _instance ??= ApiService._();

  UserController informationController = Get.put(UserController());

  String urlRoot = "https://backendpbl6.herokuapp.com";

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "$urlRoot/login";
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
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Can not request api, the status code is: ${response.statusCode}');
    }
  }

  List<Product> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$urlRoot/product'));
    if (response.statusCode == 200) {
      return parseProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<List<Cart>> getCart() async {
    String url = "$urlRoot/cart/${informationController.id.value}";
    String token = informationController.token.value.toString();
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      return (json.decode(response.body) as List)
          .map((e) => Cart.fromJson(e))
          .toList();
    } else {
      throw Exception(
          'Can not request api, the status code is: ${response.statusCode}');
    }
  }

  Future<void> addToCart(int idProduct) async {
    String url = "$urlRoot/cart/${informationController.id.value}";
    String token = informationController.token.value.toString();
    await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'id': '$idProduct',
      }),
    );
  }

  Future<void> subItemFromCart(int idProduct) async {
    String url = "$urlRoot/cart/${informationController.id.value}";
    String token = informationController.token.value.toString();
    await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'id': '$idProduct',
      }),
    );
  }

  Future<void> deleteProductFromCart(int idCart) async {
    String url = "$urlRoot/cart/$idCart";
    String token = informationController.token.value.toString();
    await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<List<Option>> getOption() async {
    String url = urlRoot;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => Option.fromJson(e))
          .toList();
    } else {
      throw Exception(
          "Can not request api, the status code is: ${response.statusCode}");
    }
  }

  Future<String> paypal(double amount, List<int> listCart) async {
    String url = "$urlRoot/payment/paypal";
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "amount": amount,
          "oderInfor": "no infor",
          "listCart": listCart,
          "userId": informationController.id.value
        }));
    if (response.statusCode == 200 || response.statusCode == 400) {
      return response.body;
    } else {
      throw Exception(
          "Can not request api, status Code is: ${response.statusCode}");
    }
  }

  Future<List<Order>> getOrder() async {
    String url = "$urlRoot/order/${informationController.id.value}";
    String token = informationController.token.value.toString();
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      return (json.decode(response.body) as List)
          .map((e) => Order.fromJson(e))
          .toList();
    } else {
      throw Exception(
          "Can not request api, status Code is: ${response.statusCode}");
    }
  }
}
