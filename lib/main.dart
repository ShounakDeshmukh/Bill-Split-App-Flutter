import 'package:bill_split_app/firebase_options.dart';
import 'package:bill_split_app/screens/bill_creation_screen.dart';
import 'package:bill_split_app/screens/home_screen.dart';
import 'package:bill_split_app/screens/login_screen.dart';
import 'package:bill_split_app/screens/register_screen.dart';
import 'package:bill_split_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/billcreation': (context) => const BillCreationPage()
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    );
  }
}
