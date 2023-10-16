import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:meuslivrosapp/models/Livro.dart';

class SQLiteDatabase {
  Database? _database;
  final String databaseName = 'meuslivros.db';

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, databaseName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE livros (
            id INTEGER PRIMARY KEY,
            autor TEXT,
            nome TEXT,
            ano INTEGER,
            nota REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE cadastro (
            id INTEGER PRIMARY KEY,
            username TEXT,
            password TEXT
          )
        ''');
      },
    );

    return _database!;
  }

  Future<List<Livro>> getAllLivros() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('livros');
    return List.generate(maps.length, (index) {
      return Livro(
        id: maps[index]['id'],
        autor: maps[index]['autor'],
        nome: maps[index]['nome'],
        ano: maps[index]['ano'],
        nota: maps[index]['nota'],
      );
    });
  }
}
