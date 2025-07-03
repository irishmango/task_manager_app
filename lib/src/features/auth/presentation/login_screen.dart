import 'package:flutter/material.dart';
import 'package:orbit/auth_repository.dart';
import 'package:orbit/firebase_auth_repository.dart';
import 'package:orbit/src/features/auth/presentation/register_screen.dart';
import 'package:orbit/src/features/home/presentation/home_screen.dart';

class LoginScreen extends StatefulWidget {
  final AuthRepository auth;
  const LoginScreen({super.key, required this.auth});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              const Text(
                'Login to Orbit!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Logo
              Image.asset('assets/logo/logo_1.png', width: 100, height: 100,),

              const SizedBox(height: 48),

              // Email Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: emailController,
                  cursorColor: Color.fromRGBO(28, 125, 28, 1),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: passwordController,
                  cursorColor: Color.fromRGBO(28, 125, 28, 1),
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Spacer(),

              // Login Button
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(28, 125, 28, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),


              const SizedBox(height: 16),

              // Google Login
              SizedBox(
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    try {
                      await widget.auth.signInWithGoogle();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    } catch (e) {
                      debugPrint('Google sign-in failed: $e');
                    }
                  },
                  icon: const Icon(Icons.g_mobiledata, color: Colors.white), 
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Apple Login
              SizedBox(
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Handle Apple login
                  },
                  icon: const Icon(Icons.apple, color: Colors.white),
                  label: const Text(
                    'Continue with Apple',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account yet? ",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to Register screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterScreen()),
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Color.fromRGBO(28, 125, 28, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}