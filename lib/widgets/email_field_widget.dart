import 'package:flutter/material.dart';

Widget buildEmailInputField({required TextEditingController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 👆 Upar "Email" label
      const Text(
        "Email Address",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 8),

      // 👇 Input field
      TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "name@example.com",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          prefixIcon: Icon(
            Icons.mail_outline,
            color: Colors.grey.shade400,
            size: 20,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 22,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1.2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return "Email is required";
          final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,}$');
          if (!emailRegex.hasMatch(value.trim())) {
            return "Enter a valid email";
          }
          return null;
        },
      ),
    ],
  );
}
