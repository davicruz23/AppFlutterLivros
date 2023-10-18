import 'package:flutter/material.dart';
import 'package:meuslivrosapp/database/sqlitedatabase.dart';
import 'package:meuslivrosapp/models/Cadastro.dart';

class RegisterPage extends StatefulWidget {
  final SQLiteDatabase sqLiteDatabase;

  const RegisterPage({Key? key, required this.sqLiteDatabase})
      : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final double fontSize = 18.0;

  String nome = '';
  String email = '';
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      nome = text;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      email = text;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      username = text;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Usuário',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      password = text;
                    });
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (nome.isNotEmpty &&
                        email.isNotEmpty &&
                        username.isNotEmpty &&
                        password.isNotEmpty) {
                      Cadastro novoCadastro = Cadastro(
                        nome: nome,
                        email: email,
                        username: username,
                        password: password,
                      );

                      try {
                        final db = await widget.sqLiteDatabase.database;
                        await db?.insert(
                          'cadastro',
                          novoCadastro.toMap(),
                        );

                        // Exiba um SnackBar informando que o cadastro foi realizado com sucesso
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cadastro realizado com sucesso.'),
                          ),
                        );

                        // Aguarde por um curto período antes de voltar para a tela principal
                        await Future.delayed(const Duration(seconds: 1));

                        // Redirecione para a tela principal
                        Navigator.pop(context);
                      } catch (e) {
                        print('Falha ao cadastrar: $e');
                      }
                    } else {
                      // Exiba uma mensagem de erro se algum campo estiver vazio
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Preencha todos os campos.'),
                        ),
                      );
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
