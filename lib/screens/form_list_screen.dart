import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/form_provider.dart';
//import '../screens/form_detail_screen.dart';
import '../widgets/form_card.dart';

class FormListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meus Formulários',
          style: TextStyle(
            fontFamily: 'Roboto', // Fonte personalizada
            fontSize: 24, // Tamanho da fonte
            fontWeight: FontWeight.bold, // Negrito
          ),
        ),
        centerTitle: true, // Centraliza o título no AppBar
        elevation: 2, // Leve sombra no AppBar
        backgroundColor:
            const Color.fromARGB(255, 121, 133, 124), // Cor de fundo do AppBar
      ),
      body: Container(
        color: Colors.grey[200], // Fundo da tela
        child: ListView.builder(
          itemCount: formProvider.formularios.length,
          itemBuilder: (ctx, i) {
            final formulario = formProvider.formularios[i];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: FormCard(
                formulario: formulario,
                index: i,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 121, 133, 124), // Cor do FAB
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordas arredondadas
        ),
        title: Text(
          'Novo Formulário',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Negrito no título
            color: const Color.fromARGB(255, 121, 133, 124), // Cor do título
          ),
        ),
        content: TextField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: 'Digite o nome do formulário',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), // Bordas arredondadas
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey, // Cor do botão Cancelar
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          ElevatedButton(
            child: Text('Adicionar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(
                  255, 121, 133, 124), // Cor do botão Adicionar
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bordas arredondadas
              ),
            ),
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
