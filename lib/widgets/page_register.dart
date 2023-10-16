import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String nome = '';
  String email = '';
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SizedBox(
      width: double.infinity,
      height: double.infinity,
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
                labelText: 'Email', border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 12,
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'Password', border: OutlineInputBorder()),
          ),
        ],
      ),
    ));
  }
}
