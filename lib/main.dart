import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _precoAlcoolController = TextEditingController();
  final TextEditingController _precoGasolinaController = TextEditingController();

  String _resultado = "Informe os preços dos combustíveis:";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void limparCampos() {
    _precoAlcoolController.clear();
    _precoGasolinaController.clear();

    setState(() {
      _resultado = "Informe os preços dos combustíveis:";
    });
  }

  void calcular() {
    final precoAlcool = double.tryParse(_precoAlcoolController.text);
    final precoGasolina = double.tryParse(_precoGasolinaController.text);

    if (precoAlcool == null || precoGasolina == null || precoAlcool <= 0 || precoGasolina <= 0) {
      setState(() {
        _resultado = "Dados inválidos!";
      });
      return;
    }

    final razao = precoAlcool / precoGasolina;

    setState(() {
      if (razao < 0.7) {
        _resultado = "Abasteça com Álcool";
      } else {
        _resultado = "Abasteça com Gasolina";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de Combustível"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            onPressed: limparCampos,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.local_gas_station, size: 120.0, color: Colors.blue),
              SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço do Álcool (R\$)",
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25.0),
                controller: _precoAlcoolController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira o preço do álcool!";
                  }
                  final preco = double.tryParse(value);
                  if (preco == null || preco <= 0) {
                    return "Preço inválido!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Preço da Gasolina (R\$)",
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25.0),
                controller: _precoGasolinaController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira o preço da gasolina!";
                  }
                  final preco = double.tryParse(value);
                  if (preco == null || preco <= 0) {
                    return "Preço inválido!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          calcular();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Cor de fundo do botão
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: limparCampos,
                      child: Text(
                        "Limpar",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Cor de fundo do botão
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
