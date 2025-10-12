import 'package:flutter/material.dart';
import 'package:sketchura_ui/constants/color_const.dart';
import 'package:sketchura_ui/core/utils/DismissableWidget/Dismisable.dart';
import 'package:sketchura_ui/core/utils/bottomsheet/bottomsheet.dart';
import 'package:sketchura_ui/core/utils/custom_button.dart';
import 'package:sketchura_ui/core/utils/table/table.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sketchura UI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Sketchura UI'),
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
  int selectedIndex = 0;

  TextEditingController usercontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<MyItem> items = [
      MyItem('Apple'),
      MyItem('Banana'),
      MyItem('Cherry'),
    ];

    return Scaffold(
      body: Column(
        children: [
          SkSimpleGlobalTable(
            data: [
              {'firstName': 'John', 'lastName': 'Doe', 'age': 30},
              {'firstName': 'Jane', 'lastName': 'Smith', 'age': 25},
            ],
            columnSpacing: 32,
            horizontalMargin: 20,
            headerBackgroundColor: Colors.blue[50],
            showBorder: false,
            borderRadius: 12,
          ),
        ],
      ),
    );
  }
}

class MyItem {
  final String name;
  MyItem(this.name);
}
