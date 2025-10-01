import 'package:flutter/material.dart';
import 'package:sketchura_ui/constants/color_const.dart';
import 'package:sketchura_ui/constants/responsive.dart';
import 'package:sketchura_ui/core/utils/accordion.dart';
import 'package:sketchura_ui/core/utils/badges.dart';
import 'package:sketchura_ui/core/utils/breadcrums.dart';
import 'package:sketchura_ui/core/utils/custom_button.dart';
import 'package:sketchura_ui/core/utils/custom_drop_down_option.dart';
import 'package:sketchura_ui/core/utils/inputbar.dart';
import 'package:sketchura_ui/core/utils/searchbar/animated_searchbar.dart';
import 'package:sketchura_ui/core/utils/snackbar.dart';
import 'package:sketchura_ui/core/utils/toast_message.dart';

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
  TextEditingController usercontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
