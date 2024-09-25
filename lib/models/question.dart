// import 'dart:io';
//import 'dart:typed_data';

class Question {
  final int? id; // o id será gerado pelo banco de dados
  String questionText;
  bool? answer; // Resposta de sim ou não, inicializada como null.
  String? imageData; // Arquivo de imagem opcional.

  Question({
    this.id,
    required this.questionText,
    this.answer,
    this.imageData,
  });

  // Converter a pergunta para um MAP

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionText': questionText,
      'answer': answer == true ? 1 : 0,
      'imageData': imageData,
    };
  }
}
