import 'question.dart';

class Formulario {
  final String title;
  List<Question> questions;

  Formulario({required this.title, this.questions = const []});
}
