import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'destinasi.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE list_destinasi (
        id INTEGER PRIMARY KEY,
        judul TEXT,
        deskripsi TEXT
      )
    ''');
  }

  Future<int> insertUser(User user) async {
    Database db = await instance.db;
    return await db.insert('list_destinasi', user.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    Database db = await instance.db;
    return await db.query('list_destinasi');
  }

  Future<int> updateUser(User user) async {
    Database db = await instance.db;
    return await db.update('list_destinasi', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> deleteUser(int id) async {
    Database db = await instance.db;
    return await db.delete('list_destinasi', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> initializeUsers() async {
    List<User> usersToAdd = [
      User(judul: 'candi borobudur', deskripsi: 'candi tua'),
      
 
    ];

    for (User user in usersToAdd) {
      await insertUser(user);
    }
  }
}