import 'package:flutter/material.dart';
import 'package:sketchura/constants/ColorConst.dart';
import 'package:sketchura/core/utils/CustomButton.dart';

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
  @override
  bool isactive = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SkFilledButton(
              label: "Click",
              onTap: () {
                setState(() {
                  if (!isactive) {
                    isactive = true;
                  } else {
                    isactive = false;
                  }
                });
              },
              backgroundColor: SkColors.error,
              borderRadius: 40,
            ),
            SizedBox(height: 20),
            SkOutlinedButton(
              label: "submit",
              onTap: () {},
              borderColor: isactive
                  ? SkColors.NeturalDarkDarkest
                  : SkColors.success,
            ),
            SizedBox(height: 20),
            SkTextButton(label: "view all ", onTap: () {}),
            SizedBox(height: 20),
            SkIconButton(
              label: "user",
              h: 40,
              w: 120,
              onTap: () {},
              isPrefixIcon: false,
              icon: Icon(Icons.usb),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              label: Text('label'),
              icon: Icon(Icons.abc_outlined),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
