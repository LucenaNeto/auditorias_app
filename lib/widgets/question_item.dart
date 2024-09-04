import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/question.dart';
import '../providers/form_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
// import 'package:formulario_app/providers/question_provider.dart';

class QuestionItem extends StatelessWidget {
  final Question question;
  final int formIndex;
  final int questionIndex; // Adicionando o parâmetro `questionIndex`

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
            Row(
              children: [
                if (question.imageData != null)
                  Image.file(
                    question.imageData! as File,
                    width: 100,
                    height: 100,
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
