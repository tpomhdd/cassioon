import 'package:cassion23/Client/mydata.dart';
import 'package:cassion23/theme/color.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController, passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mydata.cheakpreference();
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              mycolor.primary,
              mycolor.primary4,
            ])),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            _buildHeader(),
            const SizedBox(height: 20),
            Expanded(child: _buildInputFields())
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          Text(
            "Login",
            style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildInputFields() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          )),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Column(
              children: [
                _buildTextField("Enter email here", emailController),
                const SizedBox(height: 16),
                _buildTextField("Password", passwordController, isPass: true),
              ],
            ),
            const SizedBox(height: 32),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(color: Colors.grey),
                )),
            const SizedBox(height: 32),
            _buildButton("Login", mycolor.primary3, () {
           mydata.loginchek(emailController.text, passwordController.text);
            }),

        ]
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      {isPass = false}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none),
        style: const TextStyle(color: Colors.black),
        obscureText: isPass,
      ),
    );
  }

  Widget _buildButton(String buttonText, Color color, Function()? onPressed) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 2,
          backgroundColor: color,
          minimumSize: const Size.fromHeight(60),
        ),
        child: Text(buttonText,
            style: const TextStyle(fontSize: 16, color: Colors.white)));
  }
}