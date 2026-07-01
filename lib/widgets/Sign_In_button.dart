import 'package:flutter/material.dart';

Widget buildSignInButton({
  required BuildContext context,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required bool isLoading,           // ✅ Fixed: pass _isLoading as parameter
  required VoidCallback onPressed,   // ✅ Fixed: pass _handleLogin as parameter
}) {
  return Padding(
    padding: const EdgeInsets.all(18),
    child: SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFE11D48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: isLoading ? null : onPressed,   // ✅ Fixed: uses parameters
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
          "Sign In",
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