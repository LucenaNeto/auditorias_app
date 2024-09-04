import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../models/form.dart';
import '../models/question.dart';
import 'dart:io';

class FormProvider with ChangeNotifier {
  List<Formulario> _formularios = [];

  List<Formulario> get formularios => _formularios;

  void addForm(String title) {
    _formularios.add(Formulario(title: title));
    notifyListeners();
  }

  Formulario getForm(int index) {
    return _formularios[index];
  }

  void addQuestion(int formIndex, String questionText) {
    _formularios[formIndex].questions.add(
          Question(
            questionText: questionText,
          ),
        );
    notifyListeners();
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
