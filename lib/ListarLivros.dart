import 'package:flutter/material.dart';
import 'package:meuslivrosapp/database/sqlitedatabase.dart';
import 'package:meuslivrosapp/models/Livro.dart';

class ListarLivros extends StatefulWidget {
  final SQLiteDatabase sqliteDatabase;

  const ListarLivros({super.key, required this.sqliteDatabase});

  @override
  _ListarLivrosState createState() => _ListarLivrosState();
}

class _ListarLivrosState extends State<ListarLivros> {
  int currentPage = 0; // Página atual

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listar Livros'),
      ),
      body: FutureBuilder<List<Livro>>(
        future: widget.sqliteDatabase.getAllLivros(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os livros'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum livro encontrado'));
          } else {
            List<Livro> livros = snapshot.data!;
            if (currentPage < 0) currentPage = 0;
            if (currentPage >= livros.length) currentPage = livros.length - 1;

            Livro livro = livros[currentPage];

            return Column(
              children: [
                ListTile(
                  title: Text(livro.nome),
                  subtitle: Text(livro.autor),
                  trailing: Text('Nota: ${livro.nota.toStringAsFixed(1)}'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentPage--;
                        });
                      },
                      child: const Text('Anterior'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentPage++;
                        });
                      },
                      child: const Text('Próximo'),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
