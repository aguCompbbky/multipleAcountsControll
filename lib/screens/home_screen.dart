import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_accounts/bloc/account_bloc.dart';
import 'package:multiple_accounts/bloc/account_event.dart';
import 'package:multiple_accounts/bloc/account_state.dart';
import 'package:multiple_accounts/main.dart';
import 'package:multiple_accounts/services/auth_service.dart';
import 'package:multiple_accounts/widgets/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    loadAccounts();
  }

  Future<void> loadAccounts() async {
    await accountServices.init();
    setState(() {}); 
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey _menuKey = GlobalKey();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    print("build çalıştı");
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            color: Colors.purple,
            child: TextButton(
              key: _menuKey,
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      insetPadding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        height: 300, // yüksekliği burada ayarlarsın
                        child: BlocBuilder<AccountBloc, AccountState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Change Account',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount:
                                        accountServices.subAccountsList!.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          accountServices
                                              .subAccountsList![index],
                                        ),
                                        onTap: () {},
                                      );
                                    },
                                  ),
                                ),

                                ListTile(
                                  title: Text('Add a new account'),
                                  onTap: () {
                                    popup(
                                      context: context,
                                      widget: Column(
                                        children: [
                                          emailTextField(
                                            emailController: emailController,
                                          ),
                                          passwordTextField(
                                            passwordController:
                                                passwordController,
                                          ),
                                          Container(
                                            height: 40,
                                            width: 100,
                                            color: Colors.purple,
                                            child: Card(
                                              child: TextButton(
                                                onPressed: () async {
                                                  context
                                                      .read<AccountBloc>()
                                                      .add(
                                                        AddAccountEvent(
                                                          email: emailController
                                                              .text,
                                                          password:
                                                              passwordController
                                                                  .text,
                                                        ),
                                                      );
                                                     await authService.getSubUserList();
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Add"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                "Change account",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> popup({
    required BuildContext context,
    required Widget widget,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            height: 300, // yüksekliği burada ayarlarsın
            child: widget,
          ),
        );
      },
    );
  }
}

class passwordTextField extends StatelessWidget {
  const passwordTextField({super.key, required this.passwordController});

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
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
    );
  }
}

class emailTextField extends StatelessWidget {
  const emailTextField({super.key, required this.emailController});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.0025,
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
    );
  }
}
