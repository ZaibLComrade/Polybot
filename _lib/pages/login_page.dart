import 'package:flutter/material.dart';
import '../widgets/common/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          // Center the content horizontally on larger screens
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Welcome Back",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    const CustomTextField(
                      label: "Email",
                      hint: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const CustomTextField(
                      label: "Password",
                      hint: "Enter your password",
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, "/chat"),
                      child: const Text("Login"),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, "/chat"),
                      child: const Text("Continue as Guest"),
                    ),
                    const SizedBox(height: 32),
                    // Social Logins Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement Google Sign-In
                          },
                          icon: const Icon(Icons.g_mobiledata),
                          label: const Text("Google"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                        ),
                        const SizedBox(width: 36),
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement Facebook Sign-In
                          },
                          icon: const Icon(Icons.facebook),
                          label: const Text("Facebook"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Registration prompt
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            // Navigate to your registration page
                            Navigator.pushNamed(context, "/register");
                          },
                          child: const Text("Register here"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
