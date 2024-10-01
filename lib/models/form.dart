import 'question.dart';

class Formulario {
  int? id;
  String title;
  List<Question> questions; // Lista de perguntas

  Formulario({
    this.id,
    required this.title,
    required this.questions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory Formulario.fromMap(Map<String, dynamic> map) {
    return Formulario(
      id: map['id'],
      title: map['title'],
      questions: [], // as perguntas serão carregadas do banco
    );
  }
}
