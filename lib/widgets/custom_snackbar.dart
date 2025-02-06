import 'package:flutter/material.dart';

void showInternetSnackbar(BuildContext context,String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 10, // Position below status bar
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, color: Colors.white),
              SizedBox(width: 8),
              Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  // Insert the overlay
  overlay.insert(overlayEntry);

  // Remove the snackbar after 3 seconds
  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
