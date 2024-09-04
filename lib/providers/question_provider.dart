import 'package:flutter/material.dart';
import 'dart:typed_data'; // Importa para usar Uint8List
import '../models/question.dart';

class QuestionProvider with ChangeNotifier {
  List<Question> _questions = [];

  List<Question> get questions => _questions;

  // Método para adicionar uma nova pergunta com imagem opcional.
  void addQuestion(String title, Uint8List? imageData) {
    _questions.add(
      Question(
        questionText: title,
        imageData: imageData, // A imagem é armazenada como Uint8List.
      ),
    );
    notifyListeners();
  }

  // Método para anexar ou atualizar uma imagem para uma pergunta existente.
  void attachImageToQuestion(int questionIndex, Uint8List imageData) {
    _questions[questionIndex].imageData = imageData;
    notifyListeners();
  }
}
