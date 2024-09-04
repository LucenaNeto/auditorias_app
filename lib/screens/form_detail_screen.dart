import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/form_provider.dart';
import '../widgets/question_item.dart';

class FormDetailScreen extends StatelessWidget {
  final int formIndex;

  FormDetailScreen({required this.formIndex});

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);
    final formulario = formProvider.getForm(formIndex);

    return Scaffold(
      appBar: AppBar(
        title: Text(formulario.title),
      ),
      body: ListView.builder(
        itemCount: formulario.questions.length,
        itemBuilder: (ctx, i) {
          final question = formulario.questions[i];
          return QuestionItem(
            question: question,
            formIndex: formIndex,
            questionIndex: i, // Passando o `questionIndex` corretamente
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddQuestionDialog(context, formProvider);
        },
      ),
    );
  }

  void _showAddQuestionDialog(BuildContext context, FormProvider formProvider) {
    final TextEditingController questionController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Nova Pergunta'),
        content: TextField(
          controller: questionController,
          decoration: InputDecoration(labelText: 'Digite a pergunta'),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Adicionar'),
            onPressed: () {
              if (questionController.text.isNotEmpty) {
                formProvider.addQuestion(formIndex, questionController.text);
                Navigator.of(ctx).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
