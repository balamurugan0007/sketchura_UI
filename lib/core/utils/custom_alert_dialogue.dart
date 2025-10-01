import 'package:flutter/material.dart';
import 'package:sketchura_ui/constants/color_const.dart';
import 'package:sketchura_ui/core/utils/custom_button.dart';

class SkminimalDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isTittleshow;
  final bool isDesShow;

  const SkminimalDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'OK',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.isDesShow = true,
    this.isTittleshow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // So we can fully control the design
      child: Container(
        width: 240,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: SkColors.lightMedium,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isTittleshow)
              Text(
                title,
                style: TextTheme.of(context).headlineMedium,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 12),
            if (isDesShow)
              Text(
                message,
                style: TextTheme.of(context).bodyLarge,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SkFilledButton(
                  label: cancelText,
                  onTap: () {
                    Navigator.of(context).pop();
                    if (onCancel != null) onCancel!();
                  },
                  w: 80,
                  h: 40,
                ),
                SkFilledButton(
                  label: confirmText,
                  onTap: () {
                    Navigator.of(context).pop();
                    if (onConfirm != null) onConfirm!();
                  },
                  w: 80,
                  h: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showCustomAlertDialog({
  required BuildContext context,
  required String title,
  required String message,
  String confirmText = 'OK',
  String cancelText = 'Cancel',
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool isTittleshow = true,
  bool isDesShow = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => SkminimalDialog(
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      isDesShow: isDesShow,
      isTittleshow: isTittleshow,
    ),
  );
}

class SkDialog extends StatelessWidget {
  final Widget child;
  final Color? baackgroundColor;
  final double? w;
  final double? h;
  final double? radious;

  const SkDialog({
    super.key,
    required this.child,
    this.baackgroundColor,
    this.h,
    this.w,
    this.radious,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:
          baackgroundColor ??
          Colors.transparent, // So we can fully control the design
      child: Container(
        width: w ?? 240,
        height: h ?? 150,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: SkColors.lightMedium,
          borderRadius: BorderRadius.circular(radious ?? 12),
        ),
        child: child,
      ),
    );
  }
}

Future<void> SkAlertDialog({
  required BuildContext context,
  required Widget child,
  Color? backgroundColor,
  double? w,
  double? h,
  double? radious,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => SkDialog(
      child: child,
      baackgroundColor: backgroundColor,
      w: w,
      h: h,
      radious: radious,
    ),
  );
}

// class SkDialogThreeActions extends StatelessWidget {
//   final String title;
//   final String message;
//   final String confirmText;
//   final String cancelText;
//   final VoidCallback? onConfirm;
//   final VoidCallback? onCancel;
//   final bool isTittleshow;
//   final bool isDesShow;

//   const SkDialogThreeActions({
//     super.key,
//     required this.title,
//     required this.message,
//     this.confirmText = 'OK',
//     this.cancelText = 'Cancel',
//     this.onConfirm,
//     this.onCancel,
//     this.isDesShow = true,
//     this.isTittleshow = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent, // So we can fully control the design
//       child: Container(
//         padding: EdgeInsets.all(16),
//         height: 260,
//         width: 300,
//         decoration: BoxDecoration(
//           color: SkColors.lightLightest,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 16),
//             if (isTittleshow)
//               Text(
//                 title,
//                 style: TextTheme.of(context).headlineMedium,
//                 textAlign: TextAlign.center,
//               ),
//             SizedBox(height: 8),
//             if (isDesShow)
//               Text(
//                 message,
//                 style: TextTheme.of(context).bodyLarge,
//                 textAlign: TextAlign.center,
//               ),
//             SizedBox(height: 16),

//             SkFilledButton(
//               label: cancelText,
//               onTap: () {
//                 Navigator.of(context).pop();
//                 if (onCancel != null) onCancel!();
//               },
//               w: 120,
//               h: 40,
//             ),
//             SizedBox(height: 16),

//             SkFilledButton(
//               label: cancelText,
//               onTap: () {
//                 Navigator.of(context).pop();
//                 if (onCancel != null) onCancel!();
//               },
//               w: 120,
//               h: 40,
//             ),
//             SizedBox(height: 8),

//             SkFilledButton(
//               label: confirmText,
//               onTap: () {
//                 Navigator.of(context).pop();
//                 if (onConfirm != null) onConfirm!();
//               },
//               w: 120,
//               h: 40,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Future<void> showCustomAlertDialogThreeActions({
//   required BuildContext context,
//   required String title,
//   required String message,
//   String confirmText = 'OK',
//   String cancelText = 'Cancel',
//   VoidCallback? onConfirm,
//   VoidCallback? onCancel,
//   bool isTittleshow = true,
//   bool isDesShow = true,
// }) {
//   return showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (_) => SkDialogThreeActions(
//       title: title,
//       message: message,
//       confirmText: confirmText,
//       cancelText: cancelText,
//       onConfirm: onConfirm,
//       onCancel: onCancel,
//       isDesShow: isDesShow,
//       isTittleshow: isTittleshow,
//     ),
//   );
// }
