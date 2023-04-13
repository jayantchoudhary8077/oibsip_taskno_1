import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextStyle labelStyle = TextStyle(
    fontSize: 16.0,
  );
  final TextStyle resultSyle = TextStyle(
    color: Colors.teal,
    fontSize: 25.0,
    fontWeight: FontWeight.w700,
  );

  final List<String> _mesaures = [
    'Meters',
    'Kilometers',
    'Grams',
    'Kilograms',
    'Feet',
    'Miles',
    'Pounds',
    'Ounces'
  ];

  late double _value;
  String _fromMesaures = 'Meters';
  String _toMesaures = 'Kilometers';
  String _results = "";

  final Map<String, int> _mesauresMap = {
    'Meters': 0,
    'Kilometers': 1,
    'Grams': 2,
    'Kilograms': 3,
    'Feet': 4,
    'Miles': 5,
    'Pounds': 6,
    'Ounces': 7,
  };

  dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Inter the Value',
                ),
                onChanged: (value) {
                  setState(() {
                    _value = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 45.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From',
                        style: labelStyle,
                      ),
                      DropdownButton(
                        items: _mesaures
                            .map((String value) => DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _fromMesaures = value as String;
                          });
                        },
                        value: _fromMesaures,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('To', style: labelStyle),
                      DropdownButton(
                        items: _mesaures
                            .map((String value) => DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _toMesaures = value as String;
                          });
                        },
                        value: _toMesaures,
                      ),
                    ],
                  ),
                ],
              ),
              MaterialButton(
                minWidth: double.infinity,
                onPressed: _convert,
                child: Text(
                  'Convert',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 25.0),
              Text(
                _results,
                style: resultSyle,
                textAlign: TextAlign.center,
              ),
              Container(
                child: Image(
                  image: AssetImage("images/unitt.png"),
                  height: 250,
                  width: 250,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _convert() {
    print('Button Clicked');
    print(_value);

    if (_value != 0 && _fromMesaures.isNotEmpty && _toMesaures.isNotEmpty) {
      int from = _mesauresMap[_fromMesaures] as int ;
      int to = _mesauresMap[_toMesaures] as int;

      var multiplier = _formulas[from.toString()][to];

      setState(() {
        _results =
        "$_value $_fromMesaures = ${_value * multiplier} $_toMesaures";
      });
    } else {
      setState(() {
        _results = "Please enter a non zero value";
      });
    }
  }
}