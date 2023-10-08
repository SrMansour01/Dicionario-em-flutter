import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DictionaryApp(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal, // Altera a cor primária para teal
      ),
    );
  }
}

class DictionaryApp extends StatefulWidget {
  @override
  _DictionaryAppState createState() => _DictionaryAppState();
}

class _DictionaryAppState extends State<DictionaryApp> {
  final String apiUrl = 'https://api.api-ninjas.com/v1/dictionary?word=';
  final String apiKey = 'hy37G9mDwVSkoe0Z8A+dxg==1dnWWztHwcwZH3YP'; // Substitua pelo seu API Key
  String inputWord = '';
  String responseData = '';

  void fetchData() async {
    final response = await http.get(
      Uri.parse('$apiUrl$inputWord'),
      headers: {
        'X-Api-Key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        responseData = response.body;
      });
    } else {
      print('Erro: ${response.statusCode}');
      print('Corpo da resposta: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dicionário App',
          style: TextStyle(
            color: Colors.white, // Altera a cor do texto do AppBar para branco
          ),
        ),
        backgroundColor: Colors.teal, // Altera a cor de fundo do AppBar para teal
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Altera o fundo para branco
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Palavra para Consulta:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Altera a cor do texto para azul
              ),
            ),
            Text(
              inputWord,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Altera a cor do texto para azul
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  inputWord = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Digite a palavra',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchData,
              child: Text(
                'Consultar Dicionário',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Altera a cor do botão para azul
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Resposta da Requisição:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Altera a cor do texto para azul
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue, // Altera a cor da borda para azul
                    width: 2.0,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    responseData,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
