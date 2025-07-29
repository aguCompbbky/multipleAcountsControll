import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiple_accounts/bloc/account_bloc.dart';
import 'package:multiple_accounts/firebase_options.dart';

import 'package:multiple_accounts/screens/login_screen.dart';
import 'package:multiple_accounts/services/account_services.dart';

AccountServices accountServices = AccountServices();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final accountServices = AccountServices();
  await accountServices.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AccountBloc>(
          create: (context) => AccountBloc(accountServices),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.roboto(fontSize: 30),
          titleMedium: GoogleFonts.roboto(fontSize: 16),
          titleSmall: GoogleFonts.roboto(fontSize: 12),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
