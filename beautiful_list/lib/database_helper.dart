import 'dart:async';
import 'dart:io' as io;

//import 'package:beautiful_list/model/user.dart';
import 'package:beautiful_list/model/header.dart';
import 'package:beautiful_list/model/detail.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
     //   "CREATE TABLE User(id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, dob TEXT)");
//           "CREATE TABLE Header(id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, dob TEXT)");
           "CREATE TABLE Header(id INTEGER PRIMARY KEY, title TEXT, level TEXT,indicatorValue  DOUBLE, price INTEGER, content TEXT)");

    await db.execute(
      //   "CREATE TABLE User(id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, dob TEXT)");
        "CREATE TABLE Detail(id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT, dob TEXT)");


  }

  Future<int> saveHeader(Header user) async {
    var dbClient = await db;
    int res = await dbClient.insert("Header", user.toMap());
    return res;
  }

  Future<int> saveDetail (Detail user) async {
    var dbClient = await db;
    int res = await dbClient.insert("Detail", user.toMap());
    return res;
  }


  Future<List<Header>> getHeader() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Header');
    List<Header> employees = new List();
    for (int i = 0; i < list.length; i++) {
      var user =
      new Header(
//          list[i]["firstname"], list[i]["lastname"], list[i]["dob"] ,
        list[i]["title"], list[i]["level"] ,list[i]["indicatorValue"],
        list[i]["price"], list[i]["content"]);

      user.setUserId(list[i]["id"]);
      employees.add(user);
    }
    print(employees.length);
    return employees;
  }


  Future<List<Detail>> getDetail() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Detail');
    List<Detail> employees = new List();
    for (int i = 0; i < list.length; i++) {
      var user =
      new Detail(list[i]["firstname"], list[i]["lastname"], list[i]["dob"]);
      user.setUserId(list[i]["id"]);
      employees.add(user);
    }
    print(employees.length);
    return employees;
  }



  Future<int> deleteUsers(Header user) async {
    var dbClient = await db;

    int res =
    await dbClient.rawDelete('DELETE FROM User WHERE id = ?', [user.id]);
    return res;
  }

  Future<bool> update(Header user) async {
    var dbClient = await db;
//    int res =   await dbClient.update("User", user.toMap(),
    int res =   await dbClient.update("Header", user.toMap(),
        where: "id = ?", whereArgs: <int>[user.id]);
    return res > 0 ? true : false;
  }
}