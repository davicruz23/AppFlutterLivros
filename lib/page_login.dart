import 'package:flutter/material.dart';

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
            SizedBox(
              height: 12,
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
                ElevatedButton(
                  onPressed: () {
                    // Adicione a lógica do botão "Entrar" aqui
                  },
                  child: Text('Entrar'), // Coloque o texto do botão aqui
                ),
                SizedBox(width: 16.0), // Espaço entre os botões
                ElevatedButton(
                  onPressed: () {
                    // Adicione a lógica do botão "Registrar" aqui
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
