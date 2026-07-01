import 'package:flutter/material.dart';

Widget buildConfirmPasswordField({
  required TextEditingController controller,
  required TextEditingController passwordController,
  required bool hidePassword,
  required VoidCallback onToggle,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Confirm password",
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
          hintText: "Re-enter your password",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          prefixIcon: Icon(
            Icons.shield_outlined,
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
            horizontal: 20,
            vertical: 20
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 0.8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue, width: 1.2),
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
          if (value == null || value.isEmpty)
            return "Please confirm your password";
          if (value != passwordController.text) return "Passwords do not match";
          return null;
        },
      ),
    ],
  );
}
