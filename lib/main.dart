

import 'package:flutter/material.dart';
import 'ranking_screen.dart';
import 'password_screen.dart';
import 'home_screen.dart';
import 'recycling_screen.dart';
import 'profile_selection_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// void main() {
//   runApp(const MyApp());
// }



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reciclagem App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'InstrumentSans'
      ),
      home: const ProfileSelectionScreen(), // Definindo a tela de escolha de perfil como a tela inicial
      routes: {
        '/ranking': (context) => const RankingScreen(),
        '/password': (context) => const PasswordScreen(),
        '/recycling': (context) => const RecyclingScreen(),
        '/home_screen': (context) => const HomeScreen(), // Rota para HomeScreen após login
        '/profile_selection_screen': (context) => const ProfileSelectionScreen(),
      },
    );
  }
}
