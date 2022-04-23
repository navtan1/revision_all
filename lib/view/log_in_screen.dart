import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';
import 'home_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Log In",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                controller: _email,
                decoration: InputDecoration(hintText: "Enter your Email"),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _password,
                decoration: InputDecoration(hintText: "Enter your Password"),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    await kFirebaseAuth
                        .signInWithEmailAndPassword(
                            email: _email.text, password: _password.text)
                        .then(
                          (value) => Get.to(
                            () => HomeScreen(),
                          ),
                        );
                  },
                  child: Text("LogIn"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
