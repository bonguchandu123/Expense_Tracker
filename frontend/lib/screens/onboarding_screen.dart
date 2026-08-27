import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'main_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            // Placeholder for 3D character image
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: AppTheme.background,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, size: 100, color: AppTheme.primary),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const MainScreen()),
                    );
                  },
                  child: const Text("Get Started"),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Already Have Account? Log In",
                style: TextStyle(color: AppTheme.textGrey),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
