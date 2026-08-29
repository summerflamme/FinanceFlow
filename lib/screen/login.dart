import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../datasource/user_datasource.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../tools/SessionServices.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final repository = UserRepository(UserDatasource());
  Future<User?> login() async {
    final user = await repository.login(
      usernameController.text,
      passwordController.text,
    );

    if (user == null || user.id == null) {
      return null;
    }

    final session = SessionService();
    await session.saveUser(user.id!);

    return user;
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Image.asset('assets/logo.png', width: 100, height: 100),
        const Text(
          "Finance Flow",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 50),
        const Text(
          "Bienvenue",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
        ),
        const Text(
          "Connectez vous pour gérer vos finances",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Color(0xFF94A3B8),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: usernameController,
          decoration: InputDecoration(
            hintText: "Username",
            hintStyle: TextStyle(color: Color(0xFF94A3B8)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(width: 1, color: Color(0xFF40434B)),
            ),
            fillColor: Color(0xFF171B24),
            filled: true,
            prefixIcon: const Icon(Icons.person, color: Color(0xFF94A3B8)),
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "mot de passe",
            hintStyle: TextStyle(color: Color(0xFF94A3B8)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(width: 1, color: Color(0xFF40434B)),
            ),
            fillColor: Color(0xFF171B24),
            filled: true,
            prefixIcon: const Icon(Icons.lock, color: Color(0xFF94A3B8)),
          ),
          obscureText: true,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              "Mot de passe oublié ?",
              style: TextStyle(color: Color(0xFF60A5FA)),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            final user = await login();

            if (user == null) return;
            if (context.mounted) {
              context.go("/home");
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Color(0xFF4ADE80),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(16),
            ),
          ),
          child: const Text(
            "Se connecter",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Pas encore de compte? ",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
        ),
        TextButton(
          onPressed: () => context.push("/signup"),
          child: const Text(
            "Créer un compte",
            style: TextStyle(
              color: Color(0xFF4ADE80),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          children: [
            _header(context),
            SizedBox(height: 50),
            _inputField(context),
            SizedBox(height: 50),
            _signup(context),
          ],
        ),
      ),
    );
  }
}
