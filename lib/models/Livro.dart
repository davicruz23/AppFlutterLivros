import 'package:meuslivrosapp/database/sqlitedatabase.dart';

class Livro {
  int? id;
  String nome;
  String autor;
  int ano;
  double nota;

  Livro({
    this.id,
    required this.nome,
    required this.autor,
    required this.ano,
    required this.nota,
  });

  Future<int> save() async {
  final db = await SQLiteDatabase().database; // Obtenha a instância do banco de dados
  if (id == null) {
    id = await db?.insert('livros', toMap());
  } else {
    await db?.update('livros', toMap(), where: 'id = ?', whereArgs: [id]);
  }
  return id!;
}


  Future<void> delete() async {
  final db = await SQLiteDatabase().database; // Obtenha a instância do banco de dados
  if (id != null) {
    await db?.delete('livros', where: 'id = ?', whereArgs: [id]);
  }
}


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'autor': autor,
      'ano': ano,
      'nota': nota,
    };
  }
}
