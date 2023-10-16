import 'package:flutter/material.dart';
import 'package:meuslivrosapp/database/sqlitedatabase.dart';
import 'package:meuslivrosapp/main.dart';
import 'package:meuslivrosapp/page_register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String nome = '';
  String email = '';
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Image.asset('assets/livro.avif'),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              onChanged: (text) {
                print(text);
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
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: use_build_context_synchronously
                ElevatedButton(
                  onPressed: () async {
                    final validCredenciais = await SQLiteDatabase()
                        .verificarCredenciais(username, password);
                    if (validCredenciais) {
                      // Credenciais válidas, redirecione para a página principal.
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage(title: 'Página Principal'),
                        ),
                      );
                    } else {
                      // Credenciais inválidas, você pode exibir uma mensagem de erro.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Nome de usuário ou senha incorretos'),
                        ),
                      );
                    }
                  },
                  child: Text('Entrar'),
                ),

                SizedBox(width: 16.0), // Espaço entre os botões
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RegisterPage(sqLiteDatabase: SQLiteDatabase()),
                      ),
                    );
                  },
                  child: Text('Registrar'), // Coloque o texto do botão aqui
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
