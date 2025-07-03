import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:orbit/app.dart';
import 'package:orbit/auth_repository.dart';
import 'package:orbit/firebase_auth_repository.dart';
import 'package:orbit/src/features/auth/presentation/login_screen.dart';
import 'firebase_options.dart'; 

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthRepository auth = FirebaseAuthRepository();
  
  runApp(App(auth));
}
