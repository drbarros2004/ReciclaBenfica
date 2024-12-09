

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PasswordScreen extends StatefulWidget {
//   const PasswordScreen({super.key});

//   @override
//   State<PasswordScreen> createState() => _PasswordScreenState();
// }

// class _PasswordScreenState extends State<PasswordScreen> {
//   final TextEditingController _passwordController = TextEditingController();
//   final String _correctPassword = "12345"; // Substitua pela senha desejada
//   String? _errorMessage;

//   /// Salva o valor de isProfessor no dispositivo
//   Future<void> _setIsProfessor(bool value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isProfessor', value);
//   }

//   /// Valida a senha
//   void _validatePassword() async {
//     if (_passwordController.text == _correctPassword) {
//       await _setIsProfessor(true); // Define que o usuário é professor
//       Navigator.pushReplacementNamed(context, '/ranking'); // Ir para a tela de ranking
//     } else {
//       setState(() {
//         _errorMessage = "Senha incorreta. Tente novamente!";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Autenticação"),
//         backgroundColor: const Color(0xFF67AB67),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back), // Ícone de seta de voltar.
//           onPressed: () {
//             // Navegar para a tela de seleção de perfil.
//             Navigator.pushNamed(context, '/profile_selection_screen');
//           }
//         )
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               "Digite a senha para acessar (apenas para professores):",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: "Senha",
//                 border: const OutlineInputBorder(),
//                 errorText: _errorMessage,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _validatePassword,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//               ),
//               child: const Text(
//                 "Entrar",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String? _correctPassword;
  String? _errorMessage;

  /// Carrega a senha do Firebase
  Future<void> _loadPassword() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('config')
          .doc('password')
          .get();
      if (doc.exists) {
        setState(() {
          _correctPassword = doc.data()?['value'];
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Erro ao carregar a senha.";
      });
    }
  }

  /// Salva o valor de isProfessor no dispositivo
  Future<void> _setIsProfessor(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isProfessor', value);
  }

  /// Valida a senha
  void _validatePassword() async {
    if (_passwordController.text == _correctPassword) {
      await _setIsProfessor(true); // Define que o usuário é professor
      Navigator.pushReplacementNamed(context, '/ranking'); // Ir para a tela de ranking
    } else {
      setState(() {
        _errorMessage = "Senha incorreta. Tente novamente!";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Autenticação"),
        backgroundColor: const Color(0xFF67AB67),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/profile_selection_screen');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Digite a senha para acessar (apenas para professores):",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                border: const OutlineInputBorder(),
                errorText: _errorMessage,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _correctPassword == null ? null : _validatePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "Entrar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

