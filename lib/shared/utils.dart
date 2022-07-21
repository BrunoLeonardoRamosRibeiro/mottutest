import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Dialog Error
showError({required String error, required String message}) {
  Get.snackbar(error, message,
      colorText: Colors.white,
      backgroundColor: Colors.blueGrey,
      snackPosition: SnackPosition.BOTTOM,
      icon: const Icon(
        Icons.dangerous,
        color: Colors.white,
      ),
      borderRadius: 1,
      margin: const EdgeInsets.all(0.0),
      duration: const Duration(seconds: 4));
}