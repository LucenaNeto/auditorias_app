//import 'dart:typed_data';
import 'package:formulario_app/models/form.dart';
import 'package:flutter/material.dart';
import '../models/question.dart';
import 'dart:io';

class FormProvider with ChangeNotifier {
  List<Formulario> _formularios = [];

  List<Formulario> get formularios => _formularios;

  void addForm(String title) {
    _formularios.add(Formulario(title: title, questions: []));
    notifyListeners();
  }

  Formulario getForm(int index) {
    return _formularios[index];
  }

  void addQuestion(int formIndex, String questionText) {
    final question =
        Question(questionText: questionText); // cria uma nova pergunta
    _formularios[formIndex]
        .questions
        .add(question as Question); // add pergunta ao formulario
    notifyListeners(); // notifica UI para atualizar
  }

  void updateAnswer(int formIndex, int questionIndex, bool answer) {
    _formularios[formIndex].questions[questionIndex].answer = answer;
    notifyListeners();
  }

  void addImage(int formIndex, int questionIndex, File imageFile) {
    // Acessa a pergunta e adiciona a imagem salvando o caminho correto
    _formularios[formIndex].questions[questionIndex].imageData = imageFile.path;
    notifyListeners();
  }

  void updateQuestion(int formIndex, int questionIndex, String text) {
    // Verifica se o índice do formulário e da pergunta são válidos
    if (formIndex >= 0 && formIndex < _formularios.length) {
      if (questionIndex >= 0 &&
          questionIndex < _formularios[formIndex].questions.length) {
        // Atualiza o texto da pergunta
        _formularios[formIndex].questions[questionIndex].questionText = text;

        // Notifica os ouvintes que houve uma mudança
        notifyListeners();
      } else {
        print("Índice da pergunta inválido.");
      }
    } else {
      print("Índice do formulário inválido.");
    }
  }
}
