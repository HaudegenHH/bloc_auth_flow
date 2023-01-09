import 'package:bloc_auth_project/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc_auth_project/auth/login/login_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: LoginView(),
      ),
    );
  }
}
