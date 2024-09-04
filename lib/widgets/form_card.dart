import 'package:flutter/material.dart';
import 'package:formulario_app/models/form.dart';
import 'package:formulario_app/screens/form_detail_screen.dart';
import 'package:formulario_app/models/form.dart';

class FormCard extends StatelessWidget {
  final Formulario formulario;
  final int index;

  FormCard({
    required this.formulario,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 5, // Sombra do card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Bordas arredondadas
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          formulario.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center, // Centraliza o texto
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => FormDetailScreen(formIndex: index),
            ),
          );
        },
      ),
    );
  }
}
