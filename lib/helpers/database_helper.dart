import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        email TEXT NOT NULL,
        number TEXT NOT NULL,
        dob TEXT NOT NULL,
        age INTEGER NOT NULL,
        city TEXT NOT NULL,
        gender INTEGER NOT NULL,
        hobbies TEXT NOT NULL,
        password TEXT NOT NULL,
        confirmPassword TEXT NOT NULL,
        country TEXT NOT NULL,
        state TEXT NOT NULL,
        religion TEXT NOT NULL,
        caste TEXT NOT NULL,
        subCaste TEXT NOT NULL,
        higherEducation TEXT NOT NULL,
        occupation TEXT NOT NULL,
        isLiked INTEGER NOT NULL
      )
    ''');
  }

  Future<void> close() async {
    try {
      final db = await database;
      await db.close();
      _database = null;
    } catch (e) {
      print('Database close error: $e');
      rethrow;
    }
  }
} 