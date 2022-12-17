import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6/model/login.dart';
import 'package:pbl6/model/product.dart';

import '../getxcontroller/usercontroller.dart';
import '../model/cart.dart';
import '../model/option.dart';

class ApiService {
  static ApiService? _instance;

  ApiService._();

  static ApiService get instance => _instance ??= ApiService._();

  UserController informationController = Get.put(UserController());

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
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
    final response =
        await http.get(Uri.parse('https://backendpbl6.herokuapp.com/product'));
    if (response.statusCode == 200) {
      return parseProducts(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<List<Cart>> getCart(int userId) async {
    String url = "https://backendpbl6.herokuapp.com/cart/$userId";
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

  Future<void> addToCart(int userId, int idProduct) async {
    String url = "https://backendpbl6.herokuapp.com/cart/$userId";
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

  Future<void> subItemFromCart(int userId, int idProduct) async {
    String url = "https://backendpbl6.herokuapp.com/cart/$userId";
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
    String url = "https://backendpbl6.herokuapp.com/cart/$idCart";
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
    String url = "https://backendpbl6.herokuapp.com";
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
}
