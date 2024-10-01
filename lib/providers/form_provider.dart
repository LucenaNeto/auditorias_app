import 'package:formulario_app/models/data_base_helper.dart';
import 'package:formulario_app/models/form.dart';
import 'package:flutter/material.dart';
import '../models/question.dart';
import 'dart:io';

class FormProvider with ChangeNotifier {
  List<Formulario> _formularios = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Formulario> get formularios => _formularios;

  Future<void> addForm(String title) async {
    _formularios.add(Formulario(title: title, questions: []));

    // adicionar a lista em memória
    _formularios.add(Formulario as Formulario);

    // salva no banco de dados
    print('Tentando salvar o formulario no banco de dados');
    await _dbHelper.insertFormulario(Formulario as Formulario);

    print('Formulario salvo com sucesso');
    notifyListeners();
  }

  Formulario getForm(int index) {
    return _formularios[index];
  }

  void addQuestion(int formIndex, String questionText) {
    final question = Question(questionText: questionText);
    _formularios[formIndex].questions.add(question);
    notifyListeners();
  }

  void updateAnswer(int formIndex, int questionIndex, bool answer) {
    _formularios[formIndex].questions[questionIndex].answer = answer;
    notifyListeners();
  }

  void addImage(int formIndex, int questionIndex, File imageFile) {
    _formularios[formIndex].questions[questionIndex].imageData = imageFile.path;
    notifyListeners();
  }

  void updateQuestion(int formIndex, int questionIndex, String text) {
    if (formIndex >= 0 && formIndex < _formularios.length) {
      if (questionIndex >= 0 &&
          questionIndex < _formularios[formIndex].questions.length) {
        _formularios[formIndex].questions[questionIndex].questionText = text;
        notifyListeners();
      } else {
        print("Índice da pergunta inválido.");
      }
    } else {
      print("Índice do formulário inválido.");
    }
  }

  void deleteQuestion(int formIndex, int questionIndex) {
    if (formIndex >= 0 && formIndex < _formularios.length) {
      if (questionIndex >= 0 &&
          questionIndex < _formularios[formIndex].questions.length) {
        _formularios[formIndex].questions.removeAt(questionIndex);
        notifyListeners();
      } else {
        print('Índice da pergunta inválido');
      }
    } else {
      print('Índice do formulário inválido');
    }
  }

  // Função para excluir formulário
  Future<void> deleteFormulario(int id) async {
    // Remove o formulário da lista em memória
    _formularios.removeWhere((formulario) => formulario.id == id);

    // Exclui o formulário do banco de dados
    await _dbHelper.deleteFormulario(id);

    // Notifica os ouvintes sobre a mudança
    notifyListeners();
  }

  // Função para carregar os formulários do banco de dados
  Future<void> loadFormularios() async {
    _formularios = await _dbHelper.getFormularios();
    notifyListeners();
  }
}
