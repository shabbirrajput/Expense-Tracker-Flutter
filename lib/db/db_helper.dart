import 'package:expense_tracker/db/models/add_data_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DbHelper {
  late Database _db;

  static const String dbName = 'expense.db';
  static const String tableUser = 'user';
  static const int version = 1;

  ///Add data table
  static const String tableAddData = 'addData';
  static const String addId = 'id';
  static const String addDataUserId = 'addDataUserId';
  static const String addDate = 'date';
  static const String addTime = 'time';
  static const String addType = 'type';
  static const String addCategory = 'category';
  static const String addPaymentMethod = 'paymentMethod';
  static const String addStatus = 'status';
  static const String addNote = 'note';

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
        " $addPaymentMethod TEXT, "
        " $addStatus TEXT, "
        " $addNote TEXT "
        ")");
  }

  ///Insert Into Add Data Table
  Future<int> saveAddData(AddDataModel addData) async {
    var dbClient = await db;
    var res = await dbClient.insert(tableAddData, addData.toJson());
    return res;
  }
}
