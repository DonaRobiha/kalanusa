import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB('kalanusa.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE catatan_kalender (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT NOT NULL,
        tanggal TEXT NOT NULL,
        keterangan TEXT
      )
    ''');
  }

  // =========================
  // CREATE
  // =========================
  Future<int> tambahCatatan(
    String judul,
    String tanggal,
    String keterangan,
  ) async {
    final db = await database;

    return await db.insert(
      'catatan_kalender',
      {
        'judul': judul,
        'tanggal': tanggal,
        'keterangan': keterangan,
      },
    );
  }

  // =========================
  // READ
  // =========================
  Future<List<Map<String, dynamic>>> getCatatan() async {
    final db = await database;

    return await db.query(
      'catatan_kalender',
      orderBy: 'id DESC',
    );
  }

  // =========================
  // UPDATE
  // =========================
  Future<int> updateCatatan(
    int id,
    String judul,
    String tanggal,
    String keterangan,
  ) async {
    final db = await database;

    return await db.update(
      'catatan_kalender',
      {
        'judul': judul,
        'tanggal': tanggal,
        'keterangan': keterangan,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // =========================
  // DELETE
  // =========================
  Future<int> hapusCatatan(int id) async {
    final db = await database;

    return await db.delete(
      'catatan_kalender',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}