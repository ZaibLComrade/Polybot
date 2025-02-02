import 'package:flutter/material.dart';
import 'package:polybot/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Welcome Back",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32,
            ),
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
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, "/chat"),
              child: const Text("Login"),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, "/chat"),
              child: const Text("Continue as Guest"),
            )
          ],
        ),
      )),
    );
  }
}
