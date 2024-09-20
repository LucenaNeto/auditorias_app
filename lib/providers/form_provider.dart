import 'dart:typed_data';
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

  void addImage(int formIndex, int questionIndex, File image) {
    _formularios[formIndex].questions[questionIndex].imageData =
        image as Uint8List?;
    notifyListeners();
  }
}
