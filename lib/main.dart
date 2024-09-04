import 'package:flutter/material.dart';
import 'package:formulario_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/form_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FormProvider()),
      ],
      child: MaterialApp(
        title: 'Gerenciador de Formulários',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            HomeScreen(), // Define a tela inicial como a listagem de formulários.
      ),
    );
  }
}
