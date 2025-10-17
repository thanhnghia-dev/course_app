import 'package:flutter/material.dart';

Future<void> showOverlayToast(BuildContext context, String message) async {
  final overlay = Overlay.of(context);
  
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 40,
      left: MediaQuery.of(context).size.width * 0.1,
      right: MediaQuery.of(context).size.width * 0.1,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  // Đợi 1.5s rồi remove toast
  await Future.delayed(const Duration(milliseconds: 1500));
  overlayEntry.remove();
}
