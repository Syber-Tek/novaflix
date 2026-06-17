import 'package:flutter/material.dart';
import 'package:novaflix/main.dart';
// import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'STREAMFLIX',
              style: TextStyle(
                color: StreamFlix.novaRed,
                fontSize: 50,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'STREAM WITHOUT LIMITS',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 40),
            const SizedBox(
              width: 140,
              child: LinearProgressIndicator(
                color: StreamFlix.novaRed,
                backgroundColor: Color(0xff333333),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
