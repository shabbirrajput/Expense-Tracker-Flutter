import 'dart:io' as io;

import 'package:expense_tracker/db/models/add_data_model.dart';
import 'package:expense_tracker/db/models/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  late Database _db;

  static const String dbName = 'expense.db';
  static const int version = 1;

  ///Add data table
  static const String tableAddData = 'addData';
  static const String addId = 'id';
  static const String addDataUserId = 'addDataUserId';
  static const String addDate = 'date';
  static const String addTime = 'time';
  static const String addType = 'type';
  static const String addCategory = 'category';
  static const String addAmount = 'amount';
  static const String addPaymentMethod = 'paymentMethod';
  static const String addStatus = 'status';
  static const String addNote = 'note';

  ///table USer
  static const String tableUser = 'user';
  static const String userID = 'id';
  static const String userToken = 'token';
  static const String userName = 'name';
  static const String userEmail = 'email';
  static const String userPassword = 'password';

  Future<Database> get db async {
    /*if (_db != null) {
      return _db;
    }*/

    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $tableAddData ("
        " $addId INTEGER PRIMARY KEY, "
        " $addDataUserId TEXT, "
        " $addDate TEXT, "
        " $addTime TEXT, "
        " $addType TEXT, "
        " $addCategory TEXT, "
        " $addAmount INTEGER, "
        " $addPaymentMethod TEXT, "
        " $addStatus TEXT, "
        " $addNote TEXT "
        ")");

    await db.execute("CREATE TABLE $tableUser ("
        " $userID INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $userName TEXT, "
        " $userEmail TEXT,"
        " $userPassword TEXT"
        ")");
  }

  Future<int> saveUserData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(tableUser, user.toJson());
    return res;
  }

  ///Insert Into Add Data Table
  Future<int> saveAddData(AddDataModel addData) async {
    var dbClient = await db;
    var res = await dbClient.insert(tableAddData, addData.toJson());
    return res;
  }

  ///Get Added Data
  Future<List<AddDataModel>> getAddedData(String? userId) async {
    var dbClient = await db;
    print('user id ---> $userId');
    var res = await dbClient.rawQuery(
        "SELECT * FROM $tableAddData WHERE $addDataUserId = ?", [userId]);
    try {
      List<AddDataModel> mAddDataModel = List<AddDataModel>.from(
          res.map((model) => AddDataModel.fromJson(model)));

      return mAddDataModel;
    } catch (e) {
      return [];
    }
  }

  ///GET FILTER DATA
  Future<List<AddDataModel>?> getFilter(String date, String id) async {
    var dbClient = await db;
    String sql = 'SELECT * FROM $tableAddData WHERE $addDate = ?';
    var res = await dbClient.rawQuery(sql, [date]);
    List<AddDataModel> obj =
        res.isNotEmpty ? res.map((c) => AddDataModel.fromJson(c)).toList() : [];
    return obj.isNotEmpty ? obj : null;
  }

  Future<List<Map<String, Object?>>> getFiltered(String date) async {
    var dbClient = await db;
    var res = await dbClient
        .rawQuery('SELECT * FROM $tableAddData WHERE $addDate = ?', [date]);
    return res;
  }

  ///FILTER QUERY USING LIKE
/*
  Future<List<Map<String, Object?>>> getFiltered(String date) async {
    var dbClient = await db;
    var res = await dbClient
        .rawQuery('SELECT * FROM $tableAddData WHERE $addDate LIKE '$%date%'');
    return res;
  }*/

  /*Future<List> getFilter(String date) async {
    var dbClient = await db;
    var result = await dbClient.query(
      tableAddData,
      where: '$addDate >= ? and $addDate <= ?',
      whereArgs: [01 / 01 / 2023, 31 / 12 / 2023],
    ).then((data) => data.map(_fromMap).toList());
    return result;
  }*/

  ///Remove Add Data Table
  Future<int> deleteData(int id) async {
    var dbClient = await db;
    return await dbClient
        .rawDelete('DELETE FROM $tableAddData WHERE $addId = ?', [id]);
  }

  ///Get Total Amount
  Future<double> getTotalAmount() async {
    final dbClient = await db; // get reference to the database
    final List<Map<String, dynamic>> maps =
        await dbClient.query(tableAddData); // query all rows in the table

    double totalAmount = 0;

    for (final map in maps) {
      totalAmount += map[addAmount];
    }

    return totalAmount;
  }

  Future<int> calculateTotal() async {
    var dbClient = await db;
    var result =
        await dbClient.rawQuery("SELECT SUM($addAmount) FROM $tableAddData");
    final sum = result[0]['SUM($addAmount)'] as int;
    print(result.toList());
    return sum;
  }

  ///SnapShot Future logic
/*
  Future<List> getAllUsers() async {
    final dbClient = await db;

    final users = await dbClient.query(tableAddData);

    return users.map((user) => AddDataModel.fromMap(user)).toList();
  }
*/

  ///Get Added Data
/*  Future<AddDataModel> getCartProduct(String? addDataId, int? userId) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableAddData WHERE "
        "$addDataUserId = $addDataId AND "
        "$addId = $userId");

    if (res.isNotEmpty) {
      return AddDataModel.fromJson(res.first);
    }
    return AddDataModel();
  }*/
}
/*
  Future<List<AddDataModel>> fetchProd() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps =
        await dbClient.rawQuery('''SELECT * FROM $tableAddData''');
    List<AddDataModel> product = [];
    for (var map in maps) {
      AddDataModel prod = AddDataModel(
        id: map['id'],
        addDataUserId: map['addDataUserId'],
        date: map['date'],
        time: map['time'],
        type: map['type'],
        category: map['category'],
        amount: map['amount'],
        paymentMethod: map['paymentMethod'],
        status: map['status'],
        note: map['note'],
      );
      product.add(prod);
    }
    return product;
  }
*/
