import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../model/cart.dart';

class DBHelper {
  DBHelper._privateConstructor();

  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  _initiateDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join (directory.path, 'dbUSERS.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }
// creating database table
  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart(id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE, productName TEXT, productPrice INTEGER, quantity INTEGER)');
  }
// insertFuture<int>nto the table
  Future<int> insert(Cart cart) async {
    Database db = await instance.database;
    return await db.insert('cart', cart.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
// getting all the items in the list from the database
  Future<List<Cart>> getCartList() async {
    Database db = await instance.database;
    final List<Map<String, Object?>> queryResult =
    await db.query('cart');
    return queryResult.map((result) => Cart.fromMap(result)).toList();
  }

  Future<int> updateQuantity(Cart cart) async{
    Database db = await instance.database;
    return await db.update('cart', cart.toMap(), where: 'productId = ?', whereArgs: [cart.productId]);
  }

// deleting an item from the cart screen
  Future<int> deleteCartItem(int id) async {
    Database db = await instance.database;
    return await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join (directory.path, 'dbUSERS.db');
    databaseFactory.deleteDatabase(path);
  }

}

