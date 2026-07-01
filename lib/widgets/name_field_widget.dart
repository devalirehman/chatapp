// Name Input Field
import 'package:flutter/material.dart';

Widget buildNameInputField({
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.name,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFE9E9E9),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextFormField(
          controller: controller,        // ✅ Fixed: was 'nameController' (undefined)
          keyboardType: keyboardType,    // ✅ Fixed: now uses the parameter
          decoration: InputDecoration(
            labelText: "Full Name",
            hintText: "Enter your name",
            prefixIcon: const Icon(Icons.person_outline),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Name is required";
            }
            if (value.trim().length < 3) {
              return "Name must be at least 3 characters";
            }
            return null;
          },
        ),
      ),
    ],
  );
}