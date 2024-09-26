import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/question.dart';
import '../providers/form_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:formulario_app/screens/full_screen_image.dart';

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
    final question =
        formProvider.formularios[formIndex].questions[questionIndex];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  question.questionText,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () =>
                      _showEditQuestionDialog(context, formProvider),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _confirmDelete(context, formProvider);
                  },
                ), // Botão de exclusão adicionado
              ],
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
                if (question.imageData != null &&
                    question.imageData!.isNotEmpty)
                  ElevatedButton.icon(
                    icon: Icon(Icons.image),
                    label: Text('Ver Imagem'),
                    onPressed: () {
                      print(
                          'Imagem disponível: ${question.imageData}'); // Verificação
                      viewAttachedImage(
                          context, File(question.imageData! as String));
                    },
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

  // Função para confirmar exclusão com diálogo
  void _confirmDelete(BuildContext context, FormProvider formProvider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Excluir Pergunta'),
        content: Text('Tem certeza que deseja excluir esta pergunta?'),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          ElevatedButton(
            child: Text('Excluir'),
            onPressed: () {
              formProvider.deleteQuestion(
                  formIndex, questionIndex); // Exclui a pergunta
              Navigator.of(ctx).pop(); // Fecha o diálogo
            },
          ),
        ],
      ),
    );
  }

  void _showEditQuestionDialog(
      BuildContext context, FormProvider formProvider) {
    final TextEditingController _controller = TextEditingController();
    _controller.text = question.questionText;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text('Editar Pergunta'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Atualizar pergunta',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          ElevatedButton(
            child: Text('Salvar'),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                formProvider.updateQuestion(
                    formIndex, questionIndex, _controller.text);
                Navigator.of(ctx).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      print('Imagem selecionada: ${pickedFile.path}'); // Verificação
      final formProvider = Provider.of<FormProvider>(context, listen: false);
      formProvider.addImage(formIndex, questionIndex, File(pickedFile.path));
    } else {
      print('Nenhuma imagem foi selecionada'); // Verificação caso falhe
    }
  }

  void viewAttachedImage(BuildContext context, File imageFile) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => FullScreenImage(imageFile: imageFile),
      ),
    );
  }
}
