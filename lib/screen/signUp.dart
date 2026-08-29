import 'package:financeflow/datasource/accounts_datasource.dart';
import 'package:financeflow/datasource/user_datasource.dart';
import 'package:financeflow/models/user.dart';
import 'package:financeflow/repositories/account_repository.dart';
import 'package:financeflow/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:password_guard/password_guard.dart';

import '../models/accounts.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final userRepo = UserRepository(UserDatasource());
  final accountRepo = AccountRepository(AccountsDatasource());
  TextEditingController usernameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController rePwdController = TextEditingController();

  Widget _header(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Icon(
              Icons.arrow_circle_left_outlined,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
        SizedBox(height: 30),
        Image.asset('assets/logo.png', width: 100, height: 100),
        const Text(
          "Finance Flow",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 30),
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
          controller: pwdController,
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
        SizedBox(height: 24),
        TextField(
          controller: rePwdController,
          decoration: InputDecoration(
            hintText: "confirmez mot de passe",
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
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () async {
            if (pwdController.text != rePwdController.text) return;

            final hashedPwd = await PasswordGuard.hash(
              password: pwdController.text,
            );

            final account = Account(
              name: usernameController.text,
              balance: 1500.0,
            );

            final id = await accountRepo.addAccount(account);

            final User user = User(
              username: usernameController.text,
              password: hashedPwd.hash,
              account_id: id,
            );

            print("User $user");
            userRepo.addUser(user);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          children: [
            _header(context),
            SizedBox(height: 40),
            _inputField(context),
          ],
        ),
      ),
    );
  }
}
