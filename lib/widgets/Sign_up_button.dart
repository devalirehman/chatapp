import 'package:flutter/material.dart';

Widget buildSignupButton({
 required BuildContext context,
 required TextEditingController emailController,
  required TextEditingController passwordController,
  required bool isLoading,           // ✅ Fixed: pass _isLoading as parameter
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.all(18),
    child: SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE11D48),   // normal color
          disabledBackgroundColor: const Color(0xFFF4869A), // loading color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ).copyWith(
          // ✅ Press hone par dark red ho jata hai
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return const Color(0xFF9F0F2E); // pressed dark color
              }
              return null;
            },
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.5,
          ),
        )
            : const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w500,
              color: Colors.white,
            letterSpacing: 0.3,
          ),
        ),
      ),
    ),
  );
}