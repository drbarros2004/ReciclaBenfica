// import 'package:flutter/material.dart';
// import 'ranking_screen.dart'; // Importando a tela que criamos

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Ranking de Reciclagem',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: RankingScreen(), // Define a tela inicial como RankingScreen
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'home_screen.dart';
// import 'ranking_screen.dart';
// import 'password_screen.dart'; // Importar a tela de senha

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Seleção de Perfil',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: const HomeScreen(),
//       routes: {
//         '/ranking': (context) => RankingScreen(),
//         '/password': (context) => const PasswordScreen(), // Adicionar rota da tela de senha
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'ranking_screen.dart';
// import 'password_screen.dart';
// import 'home_screen.dart';
// import 'recycling_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Reciclagem App',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: const HomeScreen(),
//       routes: {
//         '/ranking': (context) => RankingScreen(),
//         '/password': (context) => const PasswordScreen(),
//         '/recycling': (context) => const RecyclingScreen(),
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'ranking_screen.dart';
// import 'password_screen.dart';
// import 'home_screen.dart';
// import 'recycling_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Reciclagem App',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: const HomeScreen(),
//       routes: {
//         '/ranking': (context) => RankingScreen(),
//         '/password': (context) => const PasswordScreen(),
//         '/recycling': (context) => const RecyclingScreen(),
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'ranking_screen.dart';
import 'password_screen.dart';
import 'home_screen.dart';
import 'recycling_screen.dart';
import 'profile_selection_screen.dart'; // Importa a nova tela

void main() {
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
        '/home': (context) => const HomeScreen(), // Rota para HomeScreen após login
      },
    );
  }
}
