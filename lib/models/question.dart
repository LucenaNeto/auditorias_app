import 'dart:io';
import 'dart:typed_data';

class Question {
  final String questionText;
  bool? answer; // Resposta de sim ou não, inicializada como null.
  Uint8List? imageData; // Arquivo de imagem opcional.

  Question({
    required this.questionText,
    this.answer,
    this.imageData,
  });
}
