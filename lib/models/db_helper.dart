import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/question.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._();
  static Database? _database;

  DBHelper._();

  factory DBHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'formulario.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE questions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        questionText TEXT,
        answer INTEGER,
        imageData BLOB
      )
    ''');
  }

  // Inserir pergunta no banco de dados
  Future<int> insertQuestion(Question question) async {
    final db = await database;
    return await db.insert('questions', question.toMap());
  }

  // Buscar todas as perguntas
  Future<List<Question>> getQuestions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('questions');

    return List.generate(maps.length, (i) {
      return Question(
        id: maps[i]['id'],
        questionText: maps[i]['questionText'],
        answer: maps[i]['answer'] == 1,
        imageData: maps[i]['imageData'],
      );
    });
  }

  // Deletar pergunta
  Future<int> deleteQuestion(int id) async {
    final db = await database;
    return await db.delete('questions', where: 'id = ?', whereArgs: [id]);
  }

  // Atualizar pergunta
  Future<int> updateQuestion(Question question) async {
    final db = await database;
    return await db.update(
      'questions',
      question.toMap(),
      where: 'id = ?',
      whereArgs: [question.id],
    );
  }
}
