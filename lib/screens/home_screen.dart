import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/form_provider.dart';
import 'form_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciador de Auditorias'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 121, 133, 124),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Image.asset('images/logo.png', height: 200),
              ),
            ),
            SizedBox(height: 14),
            Text(
              'Gerencie suas auditorias com facilidade.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black54,
                  ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 231, 234, 240),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              child: Text('Criar Nova Auditoria'),
              onPressed: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (ctx) => FormListScreen(),
                  ),
                )
                    .then((_) {
                  // Recarregar a lista de formulários ao retornar
                  formProvider.loadFormularios();
                });
              },
            ),
            SizedBox(height: 24),
            Text(
              'Recentes',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: FutureBuilder(
                future: formProvider.loadFormularios(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (formProvider.formularios.isEmpty) {
                    return Center(child: Text('Nenhuma auditoria encontrada.'));
                  }
                  return ListView.builder(
                    itemCount: formProvider.formularios.length,
                    itemBuilder: (ctx, i) {
                      final formulario = formProvider.formularios[i];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16.0),
                          title: Text(
                            formulario.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => FormListScreen(),
                              ),
                            );
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _confirmDelete(
                                  context, formProvider, formulario.id!);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(
      BuildContext context, FormProvider formProvider, int formularioId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Excluir Auditoria'),
        content: Text('Tem certeza que deseja excluir esta auditoria?'),
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
              formProvider.deleteFormulario(formularioId);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }
}
