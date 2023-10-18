import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:meuslivrosapp/database/sqlitedatabase.dart';
import 'package:meuslivrosapp/models/Livro.dart';

class AdicionarLivros extends StatefulWidget {
  final SQLiteDatabase sqliteDatabase;

  const AdicionarLivros({super.key, required this.sqliteDatabase});

  @override
  _AdicionarLivrosState createState() => _AdicionarLivrosState();
}

class _AdicionarLivrosState extends State<AdicionarLivros> {
  int? id;
  String? nome;
  String? autor;
  int? ano;
  double? nota;

  final double fontSize = 18.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Livros', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(
          color: Colors.white,  
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Título',
                labelStyle: TextStyle(fontSize: fontSize),
              ),
              onChanged: (value) {
                nome = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Autor',
                labelStyle: TextStyle(fontSize: fontSize),
              ),
              onChanged: (value) {
                autor = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Ano',
                labelStyle: TextStyle(fontSize: fontSize),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                ano = int.tryParse(value);
              },
            ),
            Row(
              children: <Widget>[
                Text(
                  'Nota',
                  style: TextStyle(fontSize: fontSize),
                ),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 0,
                  maxRating: 5,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    nota = value;
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (nome != null &&
                    autor != null &&
                    ano != null &&
                    nota != null) {
                  Livro novoLivro = Livro(
                    nome: nome!,
                    autor: autor!,
                    ano: ano!,
                    nota: nota!,
                  );

                  try {
                    final db = await widget.sqliteDatabase.database;
                    await db?.insert(
                      'livros',
                      novoLivro.toMap(),
                    );

                    autor = null;
                    nome = null;
                    ano = null;
                    nota = null;

                    // Exiba um SnackBar informando que o livro foi salvo com sucesso
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Livro adicionado com sucesso.'),
                      ),
                    );

                    // Aguarde por um curto período antes de voltar para a tela principal
                    await Future.delayed(const Duration(seconds: 1));

                    // Redirecione para a tela principal
                    Navigator.pop(context);
                  } catch (e) {
                    print('Falha ao adicionar o livro: $e');
                  }
                } else {
                  print('Falha ao adicionar o livro devido a valores nulos.');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 88, 1, 104), // Cor de fundo roxa
              ),
              child: Text(
                'Adicionar Livro',
                style: TextStyle(
                  color: Colors.white, // Cor do texto branco
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
