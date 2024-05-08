import 'package:chatapp_with_firebase/services/auth/auth_service.dart';
import 'package:chatapp_with_firebase/conponents/my_botton.dart';
import 'package:chatapp_with_firebase/conponents/my_textfield.dart';
import 'package:chatapp_with_firebase/constant.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  // email and password controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  final void Function()? onTap;

  LoginScreen({super.key, this.onTap});

  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // try loging
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _pwController.text);
    }
    // catch any error
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message_rounded,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              kHeight25,
              Text(
                "Welcome back, you been missed!",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 16),
              ),
              kHeight25,
              MyTextField(
                hintText: 'Email',
                showPasswoed: false,
                controller: _emailController,
              ),
              kHeight20,
              MyTextField(
                hintText: 'Password',
                showPasswoed: true,
                controller: _pwController,
              ),
              kHeight25,
              kHeight20,
              MyButton(
                text: "Login",
                onTap: () => login(context),
              ),
              kHeight25,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member? ",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Register now",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
