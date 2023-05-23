import 'package:expense_tracker/db/models/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DbHelper {
  late Database _db;

  static const String dbName = 'expense.db';
  static const String tableUser = 'user';
  static const int version = 1;

  static const String userID = 'id';
  static const String userToken = 'token';
  static const String userName = 'name';
  static const String userEmail = 'email';
  static const String userPassword = 'password';

  Future<Database> get db async {
    /* if (_db != null) {
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
    await db.execute("CREATE TABLE $tableUser ("
        " $userID INTEGER PRIMARY KEY, "
        " $userName TEXT, "
        " $userEmail TEXT,"
        " $userPassword TEXT"
        ")");
  }

  ///Insert Into User Table
  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(tableUser, user.toJson());
    return res;
  }

  ///LoginUserCheck
  Future<UserModel> getLoginUser(String email, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableUser WHERE "
        "$userEmail = '$email' AND "
        "$userPassword = '$password'");

    if (res.isNotEmpty) {
      return UserModel.fromJson(res.first);
    }
    return UserModel();
  }
}
