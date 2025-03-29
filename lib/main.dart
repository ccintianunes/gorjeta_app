import 'package:flutter/material.dart';

void main() {
  runApp(CalculaGorjetasApp());
}

class CalculaGorjetasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calcula Gorjetas',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: CalculaGorjetasScreen(),
    );
  }
}

class CalculaGorjetasScreen extends StatefulWidget {
  @override
  _CalculaGorjetasScreenState createState() => _CalculaGorjetasScreenState();
}

class _CalculaGorjetasScreenState extends State<CalculaGorjetasScreen> {
  final TextEditingController _valorController = TextEditingController();
  double _valorConta = 0.0;
  double _gorjeta = 0.0;
  double _valorTotal = 0.0;
  double _percentualGorjeta = 0.1; // Inicia com 10%

  void _calcularGorjeta() {
    double valor = double.tryParse(_valorController.text.replaceAll(',', '.')) ?? 0.0;
    setState(() {
      _valorConta = valor;
      _gorjeta = _valorConta * _percentualGorjeta;
      _valorTotal = _valorConta + _gorjeta;
    });
  }

  @override
  void initState() {
    super.initState();
    _valorController.addListener(_calcularGorjeta);
  }

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcula Gorjetas', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/gorjeta.jpg',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _valorController,
                decoration: InputDecoration(
                  labelText: 'Digite o valor da conta',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 20),
              Text(
                'Selecione a porcentagem da gorjeta:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPorcentagemButton('10%', 0.1),
                  _buildPorcentagemButton('15%', 0.15),
                  _buildPorcentagemButton('20%', 0.2),
                ],
              ),
              SizedBox(height: 20),
              _buildResultado('Gorjeta', _gorjeta),
              _buildResultado('Valor Total', _valorTotal),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPorcentagemButton(String label, double percentual) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _percentualGorjeta == percentual ? Colors.deepPurple : Colors.grey[300],
          foregroundColor: _percentualGorjeta == percentual ? Colors.white : Colors.black,
        ),
        onPressed: () {
          setState(() {
            _percentualGorjeta = percentual;
            _calcularGorjeta();
          });
        },
        child: Text(label),
      ),
    );
  }

  Widget _buildResultado(String titulo, double valor) {
    return Column(
      children: [
        Text(
          '$titulo:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          'R\$ ${valor.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
