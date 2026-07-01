import 'package:flutter/material.dart';

Widget socialButton(String assetPath, String label, VoidCallback ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      alignment: Alignment.center, // ✅ topCenter → center kiya
      width: 150,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              width: 34,   // ✅ image size control
              height: 34,
            ),
            const SizedBox(width: 8),  // ✅ image aur text ka gap
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}