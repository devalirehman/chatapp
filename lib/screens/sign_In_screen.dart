import 'package:chat_box/screens/sign_Up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/Sign_In_button.dart';
import '../widgets/email_field_widget.dart';
import '../widgets/password_field_widget.dart';
import '../widgets/social_button_widget.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool _hidePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose(); // ✅ also dispose password controller
    super.dispose();
  }

  // ✅ Core logic: try login → if no account → register + save to Firestore
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Try to sign in first
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // ✅ Login success → go to Home
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ✅ No account found → auto-register
        await _registerNewUser();
      } else if (e.code == 'wrong-password') {
        setState(() => _errorMessage = "Wrong password. Please try again.");
      } else if (e.code == 'invalid-email') {
        setState(() => _errorMessage = "Invalid email format.");
      } else if (e.code == 'too-many-requests') {
        setState(() => _errorMessage = "Too many attempts. Try again later.");
      } else {
        setState(() => _errorMessage = "Something went wrong: ${e.message}");
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ✅ Register new user + save data to Firestore
  Future<void> _registerNewUser() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      // ✅ Save user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
            'uid': credential.user!.uid,
            'email': emailController.text.trim(),
            'createdAt': FieldValue.serverTimestamp(),
            'isOnline': true,
          });

      // ✅ Go to Home after registration
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() => _errorMessage = "Email already in use.");
      } else if (e.code == 'weak-password') {
        setState(() => _errorMessage = "Password is too weak.");
      } else {
        setState(() => _errorMessage = "Registration failed: ${e.message}");
      }
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
              key: _formKey, // ✅ Wrap with Form for validation
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 95),

                  // Title
                  Center(
                    child: RichText(
                      text: const TextSpan(
                        text: "L",
                        style: TextStyle(
                          color: Color(0xFFE11D48),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          letterSpacing: 1.5,
                          fontSize: 30,
                        ),
                        children: [
                          TextSpan(
                            text: "OG IN TO CHATBOX",
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

                  // Subtitle
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      "Welcome back! Sign in using your social\naccount or email to continue us",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),

                  // Social Buttons
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      }),
                    ],
                  ),

                  // OR Divider
                  const SizedBox(height: 27),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "OR",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),

                  // ✅ Email Field with validation
                  const SizedBox(height: 20),
                  buildEmailInputField(controller: emailController),

                  // ✅ Password Field with validation
                  const SizedBox(height: 12),
                  buildPasswordInputField(
                    controller: passwordController,
                    hidePassword: _hidePassword, // ✅ Pass it
                    onToggle: () => setState(() {
                      _hidePassword = !_hidePassword; // ✅ setState lives here
                    }),
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

                  // ✅ Login / Loading Button
                  const SizedBox(height: 20),
                  buildSignInButton(
                    context: context,
                    emailController: emailController,
                    passwordController: passwordController,
                    isLoading: _isLoading,
                    // ✅ Pass it
                    onPressed: _handleLogin,
                  ),

                  // Don't have an account
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
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
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xFF1DA97A),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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

// ✅ Removed the broken global setState() function that was at the bottom
