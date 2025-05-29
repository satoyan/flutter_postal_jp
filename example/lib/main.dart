import 'package:flutter/material.dart';
import 'package:postal_jp/postal_jp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Postal JP Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Postal JP Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _address = 'Enter postal code';
  final TextEditingController _controller = TextEditingController();

  Future<void> _getAddress(String postalCode) async {
    final service = PostalJP();
    final result = await service.getAddress(postalCode: postalCode);
    switch (result) {
      case ApiSuccess(data: final addressInfoList):
        if (addressInfoList.isNotEmpty) {
          setState(() {
            _address = addressInfoList
                .map((address) =>
                    '${address.address1} ${address.address2} ${address.address3}(${address.kana1} ${address.kana2} ${address.kana3})')
                .join('\n');
          });
        } else {
          setState(() {
            _address = 'No address found';
          });
        }
      case ApiFailure():
        setState(() {
          _address = 'Error: ${result.error}';
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter 7-digit postal code',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _getAddress(_controller.text);
                },
                child: const Text('Get Address'),
              ),
              const SizedBox(height: 20),
              Text(
                _address,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
