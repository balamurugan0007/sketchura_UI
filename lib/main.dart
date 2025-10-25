import 'package:flutter/material.dart';
import 'package:sketchura_ui/core/utils/sk_alert_dialogue.dart';
import 'constants/app_sizes.dart';
import 'constants/color_const.dart';
import 'core/utils/sk_accordian/sk_accordion.dart';
import 'core/utils/sk_button/sk_button.dart';
import 'core/utils/sk_input/sk_input.dart';

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
  bool isChecked = false;

  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F9),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Buttons
              Row(
                children: [
                  SkFilledButton(
                    label: 'Primary Action',
                    onTap: () {},
                    backgroundColor: SkColors.primary,
                  ),

                  // Primary Outlined Button
                  SkOutlinedButton(
                    label: 'Outline',
                    onTap: () async {
                      await SkDialogUtils.showSkConfirmationDialog(
                        context: context,
                        title: "Error Accour",
                        message: "user Not found",
                      );
                    },
                    borderColor: SkColors.primary,
                    textColor: SkColors.primary,
                  ),
                ],
              ),
              // Email input with validation
              SkInput(
                title: "Email Address",
                hintText: "Enter your email",
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                isRequired: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Email is required';
                  if (!value!.contains('@')) return 'Enter a valid email';
                  return null;
                },
              ),

              // Example usage in your app
              SkAccordion(
                title: "Frequently Asked Questions",
                content: Text("This is the expanded content area..."),
              ),

              Sksize.gapH12,
            ],
          ),
        ),
      ),
    );
  }
}
