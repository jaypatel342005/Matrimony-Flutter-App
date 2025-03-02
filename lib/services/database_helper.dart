import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'matrimony.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        password TEXT,
        firstName TEXT,
        lastName TEXT,
        isActive INTEGER DEFAULT 1,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  Future<bool> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final db = await database;
      
      // Check if email exists
      final existingUser = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email.toLowerCase()],
      );
      
      if (existingUser.isNotEmpty) {
        return false;
      }

      await db.insert('users', {
        'email': email.toLowerCase(),
        'password': _hashPassword(password),
        'firstName': firstName,
        'lastName': lastName,
      });
      return true;
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final db = await database;
      final hashedPassword = _hashPassword(password);
      
      final List<Map<String, dynamic>> result = await db.query(
        'users',
        where: 'email = ? AND password = ? AND isActive = 1',
        whereArgs: [email.toLowerCase(), hashedPassword],
      );
      
      if (result.isEmpty) return null;
      
      final user = Map<String, dynamic>.from(result.first);
      user.remove('password'); // Don't send password back
      return user;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<bool> checkEmailExists(String email) async {
    try {
      final db = await database;
      final result = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [email.toLowerCase()],
      );
      return result.isNotEmpty;
    } catch (e) {
      print('Email check error: $e');
      return false;
    }
  }
} 