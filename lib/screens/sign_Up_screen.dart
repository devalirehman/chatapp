import 'package:chat_box/screens/sign_In_screen.dart';
import 'package:chat_box/widgets/email_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/Sign_up_button.dart';
import '../widgets/confirm_password_widget.dart';
import '../widgets/password_field_widget.dart';
import '../widgets/social_button_widget.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // ✅ Firebase signup + Firestore save
  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // ✅ Create user with Firebase Auth
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      // ✅ Update display name
      await credential.user!.updateDisplayName(nameController.text.trim());

      // ✅ Save user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
            'uid': credential.user!.uid,
            'name': nameController.text.trim(),
            'email': emailController.text.trim(),
            'createdAt': FieldValue.serverTimestamp(),
            'isOnline': true,
          });

      // ✅ Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("🎉 You have successfully signed up!"),
            backgroundColor: Color(0xFF1DA97A),
            duration: Duration(seconds: 2),
          ),
        );

        // ✅ Go to Home after short delay
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() => _errorMessage = "This email is already registered.");
      } else if (e.code == 'weak-password') {
        setState(() => _errorMessage = "Password is too weak.");
      } else if (e.code == 'invalid-email') {
        setState(() => _errorMessage = "Invalid email format.");
      } else {
        setState(() => _errorMessage = "Signup failed: ${e.message}");
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey, // ✅ Form wrapper for validation
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 95),

                  // Title — UI UNCHANGED ✅
                  Center(
                    child: RichText(
                      text: const TextSpan(
                        text: "S",
                        style: TextStyle(
                          color: Color(0xFFE11D48),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          letterSpacing: 1.5,
                          fontSize: 30,
                        ),
                        children: [
                          TextSpan(
                            text: "IGN UP WITH EMAIL",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1DA97A),
                              decorationStyle: TextDecorationStyle.dotted,
                              decorationColor: Color(0xFF1DA97A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Subtitle — UI UNCHANGED ✅
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      "Get chatting with friends and family today by \n signing up for our chat app!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),

                  // Social Buttons — UI UNCHANGED ✅
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      socialButton(
                        'assets/facebook-logo.webp',
                        'Facebook', // 👈 label pass karo
                        () {
                          // facebook login logic
                        },
                      ),
                      const SizedBox(width: 10),
                      // ✅ Fixed: was SizedBox(height AND width)
                      socialButton('assets/Google-Logo.png', 'Google', () {
                        // google login logic
                      }),
                    ],
                  ),

                  // OR Divider — UI UNCHANGED ✅
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "OR",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),

                  // ✅ Email Field with validation
                  const SizedBox(height: 07),
                  buildEmailInputField(controller: emailController),

                  // ✅ Password Field with validation
                  const SizedBox(height: 07),
                  buildPasswordInputField(
                    controller: passwordController,
                    hidePassword: _hidePassword,
                    onToggle: () =>
                        setState(() => _hidePassword = !_hidePassword),
                  ),

                  // ✅ Confirm Password with match validation
                  const SizedBox(height: 07),
                  buildConfirmPasswordField(
                    controller: confirmPasswordController,
                    passwordController: passwordController,
                    hidePassword: _hideConfirmPassword,
                    onToggle: () => setState(
                      () => _hideConfirmPassword = !_hideConfirmPassword,
                    ),
                  ),

                  // ✅ Error message display
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // ✅ Sign Up Button with loading state
                  const SizedBox(height: 3),
                  buildSignupButton(
                    context: context,
                    emailController: emailController,
                    passwordController: passwordController,
                    isLoading: _isLoading,
                    // ✅ Pass it
                    onPressed: _handleSignUp,
                  ),

                  // Already have account — UI UNCHANGED ✅
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFF1DA97A),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
