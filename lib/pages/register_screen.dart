import 'package:chatapp_with_firebase/services/auth/auth_service.dart';
import 'package:chatapp_with_firebase/conponents/my_botton.dart';
import 'package:chatapp_with_firebase/conponents/my_textfield.dart';
import 'package:chatapp_with_firebase/constant.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  final void Function()? onTap;

  RegisterScreen({super.key, this.onTap});

  void register(BuildContext context) {
    // get auth service
    final _auth = AuthService();

    // passwords match -> create user
    if (_pwController.text == _confirmPwController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
      } catch (e) {
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
    
    // passwords dont match -> tell user to fix
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match"),
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
              kHeight,
              MyTextField(
                hintText: 'Password',
                showPasswoed: true,
                controller: _pwController,
              ),
              kHeight,
              MyTextField(
                hintText: 'Confirm Password',
                showPasswoed: true,
                controller: _confirmPwController,
              ),
              kHeight25,
              kHeight20,
              MyButton(
                text: "Register",
                onTap: () => register(context),
              ),
              kHeight25,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have account? ",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Login now",
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
