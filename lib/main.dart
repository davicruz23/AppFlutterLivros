import 'package:flutter/material.dart';
import 'package:meuslivrosapp/AdicionarLivros.dart';
import 'package:meuslivrosapp/ListarLivros.dart';
import 'package:meuslivrosapp/database/sqlitedatabase.dart';
import 'package:meuslivrosapp/page_login.dart';


void main() {
  runApp(MyApp());  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meus Livros',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color:  Color.fromARGB(
              255, 88, 1, 104), // Cor roxa para o fundo do AppBar
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 88, 1, 104)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

 class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 500,
              height: 400,
              child: Image.asset('assets/livro.avif'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdicionarLivros(
                      sqliteDatabase: SQLiteDatabase(),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 88, 1, 104), // Cor de fundo roxa
              ),
              child: const Text(
                'Adicionar Livros',
                style: TextStyle(
                  color: Colors.white, // Cor do texto branca
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListarLivros(
                      sqliteDatabase: SQLiteDatabase(),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 88, 1, 104), // Cor de fundo roxa
              ),
              child: const Text(
                'Listar Livros',
                style: TextStyle(
                  color: Colors.white, // Cor do texto branca
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
