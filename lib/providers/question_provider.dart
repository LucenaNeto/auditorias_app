import 'package:flutter/material.dart';
import 'dart:typed_data'; // Importa para usar Uint8List
import '../models/question.dart';

class QuestionProvider with ChangeNotifier {
  final List<Question> _questions = [];

  List<Question> get questions => _questions;

  // Método para adicionar uma nova pergunta com imagem opcional.
  void addQuestion(String title, Uint8List? imageData) {
    if (title.isNotEmpty) {
      _questions.add(
        Question(
          questionText: title,
          imageData: imageData as String,
        ),
      );
      notifyListeners();
    } else {
      print("O título da pergunta não pode estar vazio.");
    }
  }

  // Método para anexar ou atualizar uma imagem para uma pergunta existente.
  void attachImageToQuestion(int questionIndex, Uint8List imageData) {
    if (questionIndex >= 0 && questionIndex < _questions.length) {
      _questions[questionIndex].imageData = imageData as String?;
      notifyListeners();
    } else {
      // Lida com o caso de índice inválido (opcional)
      print("Índice da pergunta inválido");
    }
  }
}
