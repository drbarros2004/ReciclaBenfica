// import 'package:flutter/material.dart';
// import 'ranking_screen.dart';
// import 'recycling_screen.dart';
// import 'package:flutter_application_1/utils/navigation_utils.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Início',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 25,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: const Color(0xFF67AB67),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             // Navegar para a tela de seleção de perfil.
//             Navigator.pushNamed(context, '/profile_selection_screen');
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 10), // Espaçamento acima da imagem
//               Image.asset(
//                 'assets/images/cenario2.png',
//                 width: MediaQuery.of(context).size.width * 0.8, // 80% da largura da tela
//                 height: MediaQuery.of(context).size.height * 0.3, // 30% da altura da tela
//                 fit: BoxFit.contain,
//               ),
//               const SizedBox(height: 20), // Espaçamento abaixo da imagem

//               // Seção Reciclagem (ícone ao lado esquerdo)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.recycling,
//                     size: 80, // Ícone maior
//                     color: const Color(0xFF67AB67),
//                   ),
//                   const SizedBox(width: 16), // Espaçamento entre o ícone e o texto
//                   Expanded(
//                     child: const Text(
//                       '\n Na aba Reciclagem, você pode descobrir em que lixo cada resíduo deve ser descartado, bem como quais materiais podem ou não podem ser reciclados',
//                       textAlign: TextAlign.start,
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),

//               // Seção Ranking (ícone ao lado esquerdo)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.emoji_events,
//                     size: 80, // Ícone maior
//                     color: const Color(0xFF67AB67),
//                   ),
//                   const SizedBox(width: 16), // Espaçamento entre o ícone e o texto
//                   Expanded(
//                     child: const Text(
//                       '\n Em Ranking, você pode encontrar a colocação da sua turma, além de poder ver quantas moedas Fundinho cada turma já conseguiu acumular',
//                       textAlign: TextAlign.start,
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: const Color(0xFF67AB67),
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.black54,
//         currentIndex: 1,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.recycling),
//             label: 'Reciclagem',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Início',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.emoji_events),
//             label: 'Ranking',
//           ),
//         ],
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               navigateWithFade(context, RecyclingScreen());
//               break;
//             case 1:
//               break;
//             case 2:
//               navigateWithFade(context, RankingScreen());
//               break;
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'ranking_screen.dart';
import 'recycling_screen.dart';
import 'package:flutter_application_1/utils/navigation_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Recupera os pesos de pontuação do Firestore
  Future<Map<String, double>> getPesos() async {
    final doc = await FirebaseFirestore.instance.collection('config').doc('pesos').get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        "papel": (data['papel'] ?? 1.0).toDouble(),
        "vidro": (data['vidro'] ?? 5.0).toDouble(),
        "plastico": (data['plastico'] ?? 1.5).toDouble(),
        "pilha": (data['pilha'] ?? 50.0).toDouble(),
        "metal": (data['metal'] ?? 5.0).toDouble(),
      };
    }
    // Retorna pesos padrão caso o documento não exista
    return {
      "papel": 1.0,
      "vidro": 5.0,
      "plastico": 1.5,
      "pilha": 50.0,
      "metal": 5.0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Início',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF67AB67),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navegar para a tela de seleção de perfil.
            Navigator.pushNamed(context, '/profile_selection_screen');
          },
        ),
      ),
      body: FutureBuilder<Map<String, double>>(
        future: getPesos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Erro ao carregar os pesos.'));
          }

          final pesos = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10), // Espaçamento acima da imagem
                  Image.asset(
                    'assets/images/cenario2.png',
                    width: MediaQuery.of(context).size.width * 0.8, // 80% da largura da tela
                    height: MediaQuery.of(context).size.height * 0.3, // 30% da altura da tela
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20), // Espaçamento abaixo da imagem

                  // Seção Reciclagem (ícone ao lado esquerdo)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.recycling,
                        size: 80, // Ícone maior
                        color: const Color(0xFF67AB67),
                      ),
                      const SizedBox(width: 16), // Espaçamento entre o ícone e o texto
                      Expanded(
                        child: const Text(
                          '\n Na aba Reciclagem, você pode descobrir em que lixo cada resíduo deve ser descartado, bem como quais materiais podem ou não podem ser reciclados',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Seção Ranking (ícone ao lado esquerdo)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: 80, // Ícone maior
                        color: const Color(0xFF67AB67),
                      ),
                      const SizedBox(width: 16), // Espaçamento entre o ícone e o texto
                      Expanded(
                        child: const Text(
                          '\n Em Ranking, você pode encontrar a colocação da sua turma, além de poder ver quantas moedas Fundinho cada turma já conseguiu acumular',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.calculate_outlined,
                        size: 80, // Ícone maior
                        color: const Color(0xFF67AB67),
                      ),
                      const SizedBox(width: 16), // Espaçamento entre o ícone e o texto
                      Expanded(
                        child: const Text(
                          '\n A pontuação de cada turma é calculada com base nos seguintes pesos atribuídos aos materiais reciclados:',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Text(
                    'Papel*${pesos["papel"]} + Vidro*${pesos["vidro"]} + Plástico*${pesos["plastico"]} + Pilha*${pesos["pilha"]} + Metal*${pesos["metal"]}',
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
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
              navigateWithFade(context, RecyclingScreen());
              break;
            case 1:
              break;
            case 2:
              navigateWithFade(context, RankingScreen());
              break;
          }
        },
      ),
    );
  }
}
