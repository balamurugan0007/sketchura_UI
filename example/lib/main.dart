import 'package:flutter/material.dart';
import 'constants/color_const.dart';
import 'core/utils/accordion.dart';
import 'core/utils/check_box.dart';
import 'core/utils/custom_button.dart';
import 'core/utils/inputbar.dart';
import 'core/utils/snackbar.dart';
import 'core/utils/toast_message.dart';

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
              //  Buttons
              Row(
                children: [
                  SkFilledButton(
                    label: 'Primary Action',
                    onTap: () {
                      print('Button clicked!');
                    },
                    backgroundColor: SkColors.primary,
                  ),

                  // Primary Outlined Button
                  SkOutlinedButton(
                    label: 'Outline',
                    onTap: () {
                      print('Outlined button clicked!');
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

              // Basic Accoridian
              SkAccordion(
                title: "Frequently Asked Questions",
                content: Text("This is the expanded content area..."),
              ),

              // Basic snackBar
              SkFilledButton(
                label: "SnackBar",
                onTap: () {
                  SkSnackbar.show(
                    context,
                    message: "Operation completed successfully!",
                    backgroundColor: SkColors.primary,
                  );

                  // Shortcut methods
                  SkSnackbar.success(context, "Profile updated successfully!");
                  SkSnackbar.error(context, "Failed to save changes");
                  SkSnackbar.info(context, "New update available");
                  SkSnackbar.warning(context, "Please check your input");
                },
              ),

              SkFilledButton(
                label: "Toast Message",
                onTap: () {
                  // Success Toast
                  SkToast.show(
                    context: context,
                    message: 'Operation completed successfully!',
                    title: 'Success',
                    type: SkToast.successToast,
                  );

                  // Error Toast
                  SkToast.show(
                    context: context,
                    message: 'Something went wrong!',
                    title: 'Error',
                    type: SkToast.errToast,
                  );

                  // Warning Toast
                  SkToast.show(
                    context: context,
                    message: 'This action cannot be undone.',
                    title: 'Warning',
                    type: SkToast.warningToast,
                  );

                  // Info Toast
                  SkToast.show(
                    context: context,
                    message: 'New features available!',
                    title: 'Information',
                    type: SkToast.infoToast,
                  );

                  // Toast with Title
                  SkToast.show(
                    context: context,
                    message: 'Your changes have been saved.',
                    title: 'Profile Updated',
                    type: SkToast.successToast,
                    isTittleShow: true,
                  );

                  // Toast without Close Button
                  SkToast.show(
                    context: context,
                    message: 'Auto-dismissing toast',
                    title: 'Auto Dismiss',
                    type: SkToast.infoToast,
                    showCloseButton: false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
