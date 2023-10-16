import 'package:meuslivrosapp/database/sqlitedatabase.dart';

class Cadastro {
  int? id;
  String nome;
  String email;
  String username;
  String password;

  Cadastro({
    this.id,
    required this.nome, 
    required this.email,
    required this.username,
    required this.password,
  });

  Future<int> save() async {
    final db = await SQLiteDatabase().database; // Obtenha a instância do banco de dados
    if (id == null) {
      id = await db?.insert('cadastro', toMap());
    } else {
      await db?.update('cadastro', toMap(), where: 'id = ?', whereArgs: [id]);
    }
    return id!;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'username': username,
      'password': password,
    };
  }










}





