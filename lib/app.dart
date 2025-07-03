import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orbit/auth_repository.dart';
import 'package:orbit/firebase_auth_repository.dart';
import 'package:orbit/src/features/auth/presentation/login_screen.dart';

class App extends StatelessWidget {
  final AuthRepository auth;

  const App(this.auth, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        return MaterialApp(
          key: Key(snapshot.data?.uid ?? 'no_user'),
          home: LoginScreen(auth: auth),
        );
      },
    );
  }
}