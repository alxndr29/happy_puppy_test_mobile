import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/song_model.dart';

class SongDB {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  static Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), 'song.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE songs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            singer TEXT,
            genre TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insert(Song song) async {
    final dbClient = await db;
    return dbClient.insert('songs', song.toMap());
  }

  static Future<List<Song>> getAll() async {
    final dbClient = await db;
    final result = await dbClient.query('songs');
    return result.map((e) => Song.fromMap(e)).toList();
  }

  static Future<int> update(Song song) async {
    final dbClient = await db;
    return dbClient.update(
      'songs',
      song.toMap(),
      where: 'id = ?',
      whereArgs: [song.id],
    );
  }

  static Future<int> delete(int id) async {
    final dbClient = await db;
    return dbClient.delete('songs', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Song>> getFiltered({
    String search = "",
    String genre = "All",
    String sortBy = "Judul",
  }) async {
    final dbClient = await db;

    List<String> whereClauses = [];
    List<dynamic> whereArgs = [];

    if (search.isNotEmpty) {
      whereClauses.add("LOWER(title) LIKE ?");
      whereArgs.add('%${search.toLowerCase()}%');
    }

    if (genre != "All") {
      whereClauses.add("genre = ?");
      whereArgs.add(genre);
    }

    String whereString = whereClauses.isNotEmpty
        ? whereClauses.join(" AND ")
        : "";

    String orderBy = sortBy == "Judul" ? "title ASC" : "singer ASC";

    final result = await dbClient.query(
      'songs',
      where: whereString.isEmpty ? null : whereString,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );

    return result.map((e) => Song.fromMap(e)).toList();
  }
}
