import 'package:flutter/material.dart';
import 'package:meuslivrosapp/database/sqlitedatabase.dart';
import 'package:meuslivrosapp/models/Cadastro.dart';

class RegisterPage extends StatefulWidget {
  final SQLiteDatabase sqLiteDatabase;

  RegisterPage({required this.sqLiteDatabase});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final double fontSize = 18.0;

  @override
  Widget build(BuildContext context) {
    String nome = ''; // Inicialize as variáveis aqui
    String email = '';
    String username = '';
    String password = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (text) {
                    nome = text; // Atualize as variáveis aqui
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (text) {
                    email = text; // Atualize as variáveis aqui
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (text) {
                    username = text; // Atualize as variáveis aqui
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (text) {
                    password = text; // Atualize as variáveis aqui
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (nome != null &&
                        email != null &&
                        username != null &&
                        password != null) {
                      Cadastro novoCadastro = Cadastro(
                        nome: nome!,
                        email: email!,
                        username: username!,
                        password: password!,
                      );

                      try {
                        final db = await widget.sqLiteDatabase.database;
                        await db?.insert(
                          'cadastro',
                          novoCadastro.toMap(),
                        );

                        // Exiba um SnackBar informando que o livro foi salvo com sucesso
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Cadastro realizado com sucesso.'),
                          ),
                        );

                        // Aguarde por um curto período antes de voltar para a tela principal
                        await Future.delayed(Duration(seconds: 1));

                        // Redirecione para a tela principal
                        Navigator.pop(context);
                      } catch (e) {
                        print('Falha ao cadastrar: $e');
                      }
                    } else {
                      print('');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 88, 1, 104), // Cor de fundo roxa
                  ),
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Colors.white, // Cor do texto branco
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
