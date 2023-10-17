import 'package:flutter/material.dart';
import 'package:meuslivrosapp/database/sqlitedatabase.dart';

class DataViewerScreen extends StatefulWidget {
  final SQLiteDatabase sqLiteDatabase;

  const DataViewerScreen({super.key, required this.sqLiteDatabase});

  @override
  _DataViewerScreenState createState() => _DataViewerScreenState();
}

class _DataViewerScreenState extends State<DataViewerScreen> {
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final db = await widget.sqLiteDatabase.database;

    // Substitua a consulta abaixo com a consulta SQL apropriada
    final List<Map<String, dynamic>> data = await db!.query('cadastro');

    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizar Dados'),
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          final item = _data[index];
          return ListTile(
            title: Text(item['nome']), // Substitua por seus campos de dados
            subtitle: Text(item['email']), // Substitua por seus campos de dados
          );
        },
      ),
    );
  }
}
