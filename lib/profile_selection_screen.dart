import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';  // Importar o SharedPreferences

class ProfileSelectionScreen extends StatelessWidget {
  const ProfileSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha seu perfil',
        style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white),
                ),
        backgroundColor: const Color(0xFF67AB67),
        automaticallyImplyLeading: false, // Tirando a seta de voltar!
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Você é:',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildProfileButton(context, "Aluno", Icons.book, '/home_screen', false),
              const SizedBox(width: 20),
              _buildProfileButton(context, "Professor", Icons.person, '/password', true),
            ],
          ),
        ],
      ),
    );
  }

  // Função para construir o botão do perfil e atualizar o SharedPreferences
  Widget _buildProfileButton(BuildContext context, String label, IconData icon, String route, bool isProfessor) {
    return GestureDetector(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isProfessor', isProfessor);  // Salvar o valor de 'isProfessor' no SharedPreferences
        Navigator.pushReplacementNamed(context, route);  // Vai para a tela correta dependendo do perfil
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.green.shade100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.green.shade700),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
