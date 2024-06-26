import 'package:flutter/material.dart';
import 'package:local_resources_demo/functions/geolocator.dart';

import '../functions/text_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Resources Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Team David & Co.'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Stack(children: [
        const MapWidget(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: ElevatedButton(
                child:
                    const Text('View Visited Locations', textAlign: TextAlign.center),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FlutterDemo(storage: CounterStorage()),
                  ));
                }),
          ),
        )
      ]),
    );
  }
}
