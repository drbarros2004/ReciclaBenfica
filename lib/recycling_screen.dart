import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/navigation_utils.dart';
import 'ranking_screen.dart';
import 'home_screen.dart';


class RecyclingScreen extends StatelessWidget {
  const RecyclingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'label': 'Papel', 'color': const Color(0xFF8CCDED), 'icon': Icons.article},
      {'label': 'Plástico', 'color': const Color(0xFFFF8585), 'icon': Icons.local_drink},
      {'label': 'Metal', 'color': const Color(0xFFFCE95A), 'icon': Icons.build},
      {'label': 'Vidro', 'color': const Color(0xFF94E47C), 'icon': Icons.wine_bar},
      {'label': 'Pilha', 'color': const Color(0xFFF9AD43), 'icon': Icons.battery_full},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reciclagem'),
        backgroundColor: const Color(0xFF67AB67),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ícone de seta de voltar.
          onPressed: () {
            // Navegar para a tela de seleção de perfil.
            Navigator.pushNamed(context, '/profile_selection_screen');
          }
        )
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0), // Espaçamento entre as caixas
            child: Card(
              color: category['color'] as Color, // Cor de fundo da caixa
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: ExpansionTile(
                leading: Icon(
                  category['icon'] as IconData,
                  size: 30,
                  color: Colors.black54,
                ),
                title: Text(
                  category['label'] as String,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Insira texto aqui sobre a reciclagem de ${category['label']}...',
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF67AB67),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
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
            icon: Icon(Icons.bar_chart),
            label: 'Ranking',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Já estamos na tela de reciclagem
              break;
            case 1:
              // Navigator.pushNamed(context, '/home_screen');
              navigateWithSlideRL(context, const HomeScreen());
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
