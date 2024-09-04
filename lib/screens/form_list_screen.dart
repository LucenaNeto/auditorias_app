import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/form_provider.dart';
import 'package:formulario_app/screens/form_detail_screen.dart';
import '../widgets/form_card.dart';

class FormListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meus Formulários',
          textAlign: TextAlign.center, // Centraliza o texto
        ),
        centerTitle: true, // Centraliza o título no AppBar
      ),
      body: ListView.builder(
        itemCount: formProvider.formularios.length,
        itemBuilder: (ctx, i) {
          final formulario = formProvider.formularios[i];
          return FormCard(
            formulario: formulario,
            index: i,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddFormDialog(context, formProvider);
        },
      ),
    );
  }

  void _showAddFormDialog(BuildContext context, FormProvider formProvider) {
    final TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Novo Formulário'),
        content: TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: 'Digite o nome do formulário'),
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
              if (titleController.text.isNotEmpty) {
                formProvider.addForm(titleController.text);
                Navigator.of(ctx).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
