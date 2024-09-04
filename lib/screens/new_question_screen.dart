/*
// lib/screens/new_question_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../providers/question_provider.dart';

class NewQuestionScreen extends StatefulWidget {
  @override
  _NewQuestionScreenState createState() => _NewQuestionScreenState();
}

class _NewQuestionScreenState extends State<NewQuestionScreen> {
  final _titleController =
      TextEditingController(); // Controlador para o campo de título.
  File? _selectedImage; // Armazena a imagem selecionada.

  // Função para selecionar uma imagem usando o ImagePicker.
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage =
            File(pickedImage.path); // Armazena o arquivo da imagem selecionada.
      });
    }
  }

  // Função para salvar a nova pergunta.
  void _saveQuestion() {
    if (_titleController.text.isEmpty) {
      return; // Se o título estiver vazio, não faz nada.
    }
    Provider.of<QuestionProvider>(context, listen: false).addQuestion(
        _titleController.text,
        _selectedImage as Image?); // Adiciona a pergunta à lista.
    Navigator.of(context).pop(); // Retorna à tela anterior.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Pergunta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController, // Controlador do campo de texto.
              decoration: InputDecoration(labelText: 'Título da Pergunta'),
            ),
            SizedBox(height: 10),
            _selectedImage != null
                ? Image.file(_selectedImage!, height: 200, fit: BoxFit.cover)
                : Text(
                    'Nenhuma imagem selecionada'), // Exibe a imagem selecionada ou um texto.
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.image),
              label: Text('Selecionar Imagem'),
              onPressed: _pickImage, // Chama a função para selecionar a imagem.
            ),
            Spacer(),
            ElevatedButton(
              child: Text('Salvar Pergunta'),
              onPressed:
                  _saveQuestion, // Chama a função para salvar a pergunta.
            ),
          ],
        ),
      ),
    );
  }
}
*/