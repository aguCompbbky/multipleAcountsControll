import 'package:flutter/material.dart';
import 'package:multiple_accounts/screens/login_screen.dart';
import 'package:multiple_accounts/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthService auth = AuthService();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.25,
                  ),
                  child: TextField(
                    cursorHeight: 25,
                    controller: nameController,
                    style: Theme.of(context).textTheme.titleMedium,

                    decoration: InputDecoration(
                      labelText: "NAME",
                      hintText: "ENTER THE YOUR NAME",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.07,
                  ),
                  child: TextField(
                    cursorHeight: 25,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.titleMedium,

                    decoration: InputDecoration(
                      labelText: "EMAİL",
                      hintText: "ENTER THE EMAİL",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.07,
                  ),
                  child: TextField(
                    cursorHeight: 25,
                    controller: passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.titleMedium,

                    decoration: InputDecoration(
                      labelText: "PASSWORD",
                      hintText: "ENTER THE PASSWORD",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 100,
                  color: Colors.purple,
                  child: Card(
                    child: TextButton(
                      onPressed: () {
                        auth.registerWithEmail(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        Navigator.push(context, MaterialPageRoute(builder: (context){return LoginScreen();}));
                      },
                      child: Text("REGISTER"),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                  child: Text("I have a already an account."),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
