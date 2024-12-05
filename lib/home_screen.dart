import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/navigation_utils.dart';
import 'ranking_screen.dart';
import 'recycling_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bem-vindo!"),
        backgroundColor: const Color(0xFF67AB67),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ícone de seta de voltar.
          onPressed: () {
            // Navegar para a tela de seleção de perfil.
            Navigator.pushNamed(context, '/profile_selection_screen');
          }
        )
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Tela Inicial',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF67AB67),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
        currentIndex: 1,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.recycling),
            label: 'Reciclagem',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Ranking',
          ),
          
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Navigator.pushNamed(context, '/recycling');
              navigateWithSlideLR(context, const RecyclingScreen());
              break;
            case 1:
              // Caso de Início, já estamos na tela inicial
              break;
            case 2:
              // Navigator.pushNamed(context, '/ranking');
              navigateWithSlideRL(context, const RankingScreen());
              break;
          }
        },
      ),
    );
  }
}
