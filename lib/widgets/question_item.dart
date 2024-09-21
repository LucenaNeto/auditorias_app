import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/question.dart';
import '../providers/form_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class QuestionItem extends StatelessWidget {
  final Question question;
  final int formIndex;
  final int questionIndex;

  QuestionItem({
    required this.question,
    required this.formIndex,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.questionText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text('Resposta: '),
                Radio<bool>(
                  value: true,
                  groupValue: question.answer,
                  onChanged: (bool? value) {
                    formProvider.updateAnswer(formIndex, questionIndex, value!);
                  },
                ),
                Text('Sim'),
                Radio<bool>(
                  value: false,
                  groupValue: question.answer,
                  onChanged: (bool? value) {
                    formProvider.updateAnswer(formIndex, questionIndex, value!);
                  },
                ),
                Text('Não'),
              ],
            ),
            SizedBox(height: 10),
            // Utilizando a função para visualizar a imagem anexada
            Row(
              children: [
                if (question.imageData != null)
                  GestureDetector(
                    onTap: () {
                      viewAttachedImage(
                          context, File(question.imageData! as String));
                    },
                    child: Image.file(
                      File(question.imageData! as String),
                      width: 100,
                      height: 100,
                    ),
                  ),
                Spacer(),
                ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt),
                  label: Text('Anexar Imagem'),
                  onPressed: () => _pickImage(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final formProvider = Provider.of<FormProvider>(context, listen: false);
      formProvider.addImage(formIndex, questionIndex, File(pickedFile.path));
    }
  }
}

// Função reutilizável para visualizar a imagem em tela cheia
void viewAttachedImage(BuildContext context, File imageFile) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => FullScreenImage(imageFile: imageFile),
    ),
  );
}

// Tela de visualização em tela cheia da imagem
class FullScreenImage extends StatelessWidget {
  final File imageFile;

  FullScreenImage({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}
