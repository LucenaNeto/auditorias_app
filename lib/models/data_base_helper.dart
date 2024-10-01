import 'dart:async';
import 'package:flutter/material.dart';
import 'package:formulario_app/models/form.dart';
import 'package:formulario_app/models/question.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'formulario.db');

    print('Caminho do banco de dados: $path'); // Log para verificar caminho

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Criar tabela de formularios
        await db.execute(
          'CREATE TABLE formularios(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT)',
        );
        print('Tabela de formularios criada com sucesso');

        // Criar tabela de perguntas vinculadas a um formulário
        await db.execute(
          'CREATE TABLE questions(id INTEGER PRIMARY KEY AUTOINCREMENT, formId INTEGER, questionText TEXT, answer INTEGER, imageData TEXT, FOREIGN KEY(formId) REFERENCES formularios(id) ON DELETE CASCADE)',
        );
        print('Tabela de perguntas criada com sucesso');
      },
    );
  }

  Future<void> insertFormulario(Formulario formulario) async {
    final db = await database;

    // Insere o formulário e captura o ID gerado automaticamente
    int formId = await db.insert(
      'formularios',
      formulario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Formulário "${formulario.title}" salvo com ID: $formId');

    // Insere as perguntas vinculadas ao formulário
    for (var question in formulario.questions) {
      await insertQuestion(formId, question); // Usa o formId gerado
    }
  }

  Future<void> insertQuestion(int formId, Question question) async {
    final db = await database;

    // Insere a pergunta e vincula ao formulário através do formId
    await db.insert(
      'questions',
      {
        'formId': formId,
        ...question.toMap(), // Expande o mapa da questão
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Pergunta "${question.questionText}" inserida no formulário $formId');
  }

  Future<List<Formulario>> getFormularios() async {
    final db = await database;

    // Consulta todos os formulários
    final List<Map<String, dynamic>> formularioMaps =
        await db.query('formularios');

    List<Formulario> formularios = [];
    for (var map in formularioMaps) {
      // Busca perguntas associadas a cada formulário
      var questions = await getQuestions(map['id']);
      formularios.add(Formulario(
        id: map['id'],
        title: map['title'],
        questions: questions,
      ));
    }
    return formularios;
  }

  Future<List<Question>> getQuestions(int formId) async {
    final db = await database;

    // Consulta as perguntas associadas ao formId
    final List<Map<String, dynamic>> questionMaps = await db.query(
      'questions',
      where: 'formId = ?',
      whereArgs: [formId],
    );

    // Gera a lista de perguntas
    return List.generate(questionMaps.length, (i) {
      return Question.fromMap(questionMaps[i]);
    });
  }

  Future<void> updateFormulario(Formulario formulario) async {
    final db = await database;

    // Atualiza os dados do formulário
    await db.update(
      'formularios',
      formulario.toMap(),
      where: 'id = ?',
      whereArgs: [formulario.id],
    );
    print('Formulário ${formulario.title} atualizado com sucesso');
  }

  Future<void> deleteFormulario(int id) async {
    final db = await database;

    // Deleta o formulário e as perguntas associadas através do CASCADE
    await db.delete(
      'formularios',
      where: 'id = ?',
      whereArgs: [id],
    );
    print('Formulário $id e perguntas associadas deletados com sucesso');
  }
}
