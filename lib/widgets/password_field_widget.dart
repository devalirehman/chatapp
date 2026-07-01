import 'package:flutter/material.dart';

Widget buildPasswordInputField({
  required TextEditingController controller,
  required bool hidePassword,
  required VoidCallback onToggle,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Password",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        obscureText: hidePassword,
        decoration: InputDecoration(
          hintText: "Enter your password",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.grey.shade400,
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              hidePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey.shade400,
              size: 20,
            ),
            onPressed: onToggle,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 22,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
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
          if (value == null || value.isEmpty) return "Password is required";
          if (value.length < 6) return "Minimum 6 characters";
          return null;
        },
      ),
    ],
  );
}
