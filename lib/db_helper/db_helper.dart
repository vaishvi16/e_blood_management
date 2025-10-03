import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  //database details
  static final _dbname = "profile.db";
  static final _dbversion = 1;

  //user profile table details
  static final _tablename = "user";
  static final _userid = "id";
  static final username = "user_name";
  static final useremail = "user_email";
  static final userpassword = "user_password";
  static final usergender = "user_gender";
  static final usercontact = "user_contact";
  static final userbloodgrp = "user_bloodgrp";
  static final userstate = "user_state";
  static final usercity = "user_city";

  //blood donation table details
  static final donationTable = "donation";
  static final donationId = "id";
  static final columnUserId = "user_id";
  static final columnDonationDate = "donation_date";
  static final columnQuantity = "quantity_ml";
  static final columnHospitalName = "hospital_name";
  static final columnLocation = "location";
  static final columnStatus = "status";

  //blood request table details
  static final requestTable = "request";
  static final requestId = "id";
  static final ColumnRequestUserId = "user_id";
  static final columnRequestDate = "donation_date";
  static final columnRequestQuantity = "quantity_ml";
  static final columnRequestHospitalName = "hospital_name";
  static final columnRequestLocation = "location";
  static final columnRequestUrgency = "urgency";
  static final columnRequestBloodGroup = "blood_group";

  //private constructor
  DbHelper._privateconstructor();

  //database object
  Database? db;

  //initialization
  static final DbHelper instance = DbHelper._privateconstructor();

  //get database details
  Future<Database> get database async => db ??= await _initDatabase();

  _initDatabase() async {
    Directory directorypath = await getApplicationDocumentsDirectory();
    print(directorypath);

    String finalpath = join(directorypath.path, _dbname);
    print(finalpath);

    return await openDatabase(
      finalpath,
      version: _dbversion,
      onCreate: _oncreate,
    );
  }

  Future<void> _oncreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_tablename 
          (
            $_userid INTEGER PRIMARY KEY,
            $username TEXT NOT NULL,
             $useremail TEXT NOT NULL ,
             $userpassword TEXT NOT NULL ,
              $usergender TEXT NOT NULL ,
               $usercontact TEXT NOT NULL ,
                $userbloodgrp TEXT NOT NULL ,
                 $userstate TEXT NOT NULL ,
                  $usercity TEXT NOT NULL 
          )
        ''');

    await db.execute('''
  CREATE TABLE $donationTable 
  (
    $donationId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnUserId INTEGER NOT NULL,
    $columnDonationDate TEXT NOT NULL,
    $columnQuantity INTEGER,
    $columnHospitalName TEXT,
    $columnLocation TEXT,
    $columnStatus TEXT DEFAULT 'pending',
    FOREIGN KEY ($columnUserId) REFERENCES $_tablename($_userid) ON DELETE CASCADE
  )
''');

    await db.execute('''
  CREATE TABLE $requestTable 
  (
    $requestId INTEGER PRIMARY KEY AUTOINCREMENT,
    $ColumnRequestUserId INTEGER NOT NULL,
    $columnRequestDate TEXT NOT NULL,
    $columnRequestQuantity INTEGER,
    $columnRequestHospitalName TEXT,
    $columnRequestLocation TEXT,
    $columnRequestUrgency TEXT,
    $columnRequestBloodGroup TEXT,
    FOREIGN KEY ($ColumnRequestUserId) REFERENCES $_tablename($_userid) ON DELETE CASCADE
  )
''');
  }

  //insert data of user profile
  Future<int> insertdata(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert(_tablename, row);
  }

  //check that id exist in db or not
  Future<Map<String, dynamic>?> checkId(
    String username,
    String userpassword,
  ) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'user_email = ? AND user_password = ?',
      whereArgs: [username, userpassword],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  //gets the details from id
  Future<Map<String, dynamic>?> getDetailsFromId(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  //insert data of blood donate
  Future<int> insertBloodDonateData(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert(donationTable, row);
  }

  // fetch donation details
  Future<List<Map<String, dynamic>>> getAllDonations() async {
    final db = await database;
    return await db.query(donationTable);
  }

  //update blood donate data
  Future<int> updateBloodDonateData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[donationId];
    return await db.update(
      donationTable,
      row,
      where: '$donationId = ? ',
      whereArgs: [id],
    );
  }

  //delete blood donate data
  Future<int> deleteBloodDonateData(int id) async {
    Database db = await instance.database;
    return await db.delete(
      donationTable,
      where: '$donationId = ?',
      whereArgs: [id],
    );
  }

  // update record from the given id
  Future<Map<String, dynamic>> getDonationById(int id) async {
    final db = await instance.database;

    final result = await db.query(
      donationTable,
      where: '$donationId = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      throw Exception('Donation with id $id not found');
    }
  }

  //insert data of blood request
  Future<int> insertBloodRequestData(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert(requestTable, row);
  }

  // fetch request details
  Future<List<Map<String, dynamic>>> getAllRequests() async {
    final db = await database;
    return await db.query(requestTable);
  }

  //delete blood request data
  Future<int> deleteBloodRequestData(int id) async {
    Database db = await instance.database;
    return await db.delete(
      requestTable,
      where: '$requestId = ?',
      whereArgs: [id],
    );
  }

  // update request from the given id
  Future<Map<String, dynamic>> getRequestById(int id) async {
    final db = await instance.database;

    final result = await db.query(
      requestTable,
      where: '$requestId = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      throw Exception('Request with id $id not found');
    }
  }

  //update blood request data
  Future<int> updateBloodRequestData(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[requestId];
    return await db.update(
      requestTable,
      row,
      where: '$requestId = ? ',
      whereArgs: [id],
    );
  }



}
