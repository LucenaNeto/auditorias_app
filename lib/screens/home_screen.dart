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
        centerTitle: true, // Centraliza o título no AppBar
        backgroundColor: const Color.fromARGB(255, 121, 133, 124),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Espaço para a logo
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Image.asset('images/logo.png', height: 200),
              ),
            ),
            /*Text(
              '',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),*/
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) =>
                        FormListScreen(), // Navega para a tela de listagem de formulários
                  ),
                );
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
              child: ListView.builder(
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
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) =>
                                FormListScreen(), // Navega para a tela de listagem de formulários
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
