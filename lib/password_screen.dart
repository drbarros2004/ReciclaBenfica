// import 'package:flutter/material.dart';

// class PasswordScreen extends StatefulWidget {
//   const PasswordScreen({super.key});

//   @override
//   State<PasswordScreen> createState() => _PasswordScreenState();
// }

// class _PasswordScreenState extends State<PasswordScreen> {
//   final TextEditingController _passwordController = TextEditingController();
//   final String _correctPassword = "12345"; // Substitua pela senha desejada
//   String? _errorMessage;

//   void _validatePassword() {
//     if (_passwordController.text == _correctPassword) {
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
//                 style: TextStyle(
//                   color: Colors.white
//                 ),
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

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final String _correctPassword = "12345"; // Substitua pela senha desejada
  String? _errorMessage;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Autenticação"),
        backgroundColor: const Color(0xFF67AB67),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ícone de seta de voltar.
          onPressed: () {
            // Navegar para a tela de seleção de perfil.
            Navigator.pushNamed(context, '/profile_selection_screen');
          }
        )
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
              onPressed: _validatePassword,
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
