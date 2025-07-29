import 'package:flutter/material.dart';
import 'package:multiple_accounts/screens/home_screen.dart';
import 'package:multiple_accounts/screens/register_screen.dart';
import 'package:multiple_accounts/services/auth_service.dart';
import 'package:multiple_accounts/utils/auth_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  
  AuthService auth = AuthService();
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
                      onPressed: () async {
                        AuthUtils.isLogined = await auth.loginWithEmail(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen();
                            },
                          ),
                        );
                      },
                      child: Text("LOGIN"),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return RegisterScreen();
                        },
                      ),
                    );
                  },
                  child: Text("Create a new account."),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
