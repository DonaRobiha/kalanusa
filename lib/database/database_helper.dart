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
    await _database!.execute('''
      CREATE TABLE IF NOT EXISTS komputasi_perjalanan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_rencana TEXT,
        jumlah_orang INTEGER NOT NULL DEFAULT 1,
        transportasi REAL NOT NULL DEFAULT 0,
        penginapan REAL NOT NULL DEFAULT 0,
        makan REAL NOT NULL DEFAULT 0,
        tiket_aktivitas REAL NOT NULL DEFAULT 0,
        biaya_lainnya REAL NOT NULL DEFAULT 0,
        total_biaya REAL NOT NULL DEFAULT 0,
        created_at TEXT
      )
    ''');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 4,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
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

    await db.execute('''
      CREATE TABLE destinasi (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        lokasi TEXT NOT NULL,
        kategori TEXT NOT NULL DEFAULT 'Wisata',
        biaya TEXT NOT NULL DEFAULT 'Gratis',
        foto TEXT,
        deskripsi TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE rencana_perjalanan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tujuan TEXT NOT NULL,
        tanggal TEXT NOT NULL,
        orang TEXT NOT NULL,
        budget TEXT NOT NULL,
        catatan TEXT
      )
    ''');

    await _seedData(db);
  }

  Future<void> _upgradeDB(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 4) {
      await db.execute('DROP TABLE IF EXISTS destinasi');
      await db.execute('DROP TABLE IF EXISTS rencana_perjalanan');
      await db.execute('''
        CREATE TABLE destinasi (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nama TEXT NOT NULL,
          lokasi TEXT NOT NULL,
          kategori TEXT NOT NULL DEFAULT 'Wisata',
          biaya TEXT NOT NULL DEFAULT 'Gratis',
          foto TEXT,
          deskripsi TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE rencana_perjalanan (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          tujuan TEXT NOT NULL,
          tanggal TEXT NOT NULL,
          orang TEXT NOT NULL,
          budget TEXT NOT NULL,
          catatan TEXT
        )
      ''');

      await _seedData(db);
    }
  }

  Future<void> _seedData(Database db) async {
    // Seed Destinasi Awal
    await db.insert('destinasi', {
      'nama': 'Borobudur',
      'lokasi': 'Magelang, Jawa Tengah',
      'kategori': 'Wisata Budaya',
      'biaya': 'Rp50.000',
      'foto': 'https://images.unsplash.com/photo-1596402184320-417e7178b2cd?w=800',
      'deskripsi': 'Candi Buddha terbesar di dunia yang menjadi salah satu warisan budaya dunia UNESCO.',
    });

    await db.insert('destinasi', {
      'nama': 'Raja Ampat',
      'lokasi': 'Papua Barat Daya',
      'kategori': 'Wisata Alam',
      'biaya': 'Rp500.000',
      'foto': 'https://images.unsplash.com/photo-1516690561799-46d8f74f9abf?w=800',
      'deskripsi': 'Gugusan pulau karang indah dengan keanekaragaman biota laut terbaik di dunia.',
    });

    await db.insert('destinasi', {
      'nama': 'Bali',
      'lokasi': 'Bali',
      'kategori': 'Wisata Pantai',
      'biaya': 'Rp100.000',
      'foto': 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=800',
      'deskripsi': 'Pulau Dewata dengan pantai eksotis, kebudayaan luhur, dan tradisi yang mendunia.',
    });

    // Seed Rencana Perjalanan Awal
    await db.insert('rencana_perjalanan', {
      'tujuan': 'Yogyakarta',
      'tanggal': '20 September 2026',
      'orang': '3 orang',
      'budget': 'Rp1.500.000',
      'catatan': 'Wisata dan kuliner Malioboro serta candi-candi sekitar.',
    });
  }

  // =========================
  // CRUD DESTINASI
  // =========================

  Future<int> tambahDestinasi(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('destinasi', data);
  }

  Future<List<Map<String, dynamic>>> getDestinasi() async {
    final db = await database;
    final res = await db.query('destinasi', orderBy: 'id DESC');
    if (res.isEmpty) {
      await _seedData(db);
      return await db.query('destinasi', orderBy: 'id DESC');
    }
    return res;
  }

  Future<int> updateDestinasi(int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update(
      'destinasi',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> hapusDestinasi(int id) async {
    final db = await database;
    return await db.delete(
      'destinasi',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // =========================
  // CRUD RENCANA PERJALANAN
  // =========================

  Future<int> tambahRencana(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('rencana_perjalanan', data);
  }

  Future<List<Map<String, dynamic>>> getRencana() async {
    final db = await database;
    final res = await db.query('rencana_perjalanan', orderBy: 'id DESC');
    if (res.isEmpty) {
      await _seedData(db);
      return await db.query('rencana_perjalanan', orderBy: 'id DESC');
    }
    return res;
  }

  Future<int> updateRencana(int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update(
      'rencana_perjalanan',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> hapusRencana(int id) async {
    final db = await database;
    return await db.delete(
      'rencana_perjalanan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // =========================
  // CRUD CATATAN KALENDER
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

  Future<List<Map<String, dynamic>>> getCatatan() async {
    final db = await database;

    return await db.query(
      'catatan_kalender',
      orderBy: 'id DESC',
    );
  }

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

  Future<int> hapusCatatan(int id) async {
    final db = await database;

    return await db.delete(
      'catatan_kalender',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // =========================
  // CRUD KOMPUTASI PERJALANAN / RIWAYAT TRANSAKSI
  // =========================

  Future<int> tambahKomputasi(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('komputasi_perjalanan', data);
  }

  Future<List<Map<String, dynamic>>> getKomputasi() async {
    final db = await database;
    return await db.query('komputasi_perjalanan', orderBy: 'id DESC');
  }

  Future<int> hapusKomputasi(int id) async {
    final db = await database;
    return await db.delete(
      'komputasi_perjalanan',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}