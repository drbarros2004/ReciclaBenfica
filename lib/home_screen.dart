// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/utils/navigation_utils.dart';
// import 'ranking_screen.dart';
// import 'recycling_screen.dart';

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
//               const SizedBox(height: 10), // Pequeno espaço acima da imagem
//               Image.asset(
//                 'assets/images/cenario2.png',
//                 width: MediaQuery.of(context).size.width * 0.8, // 80% da largura da tela
//                 height: MediaQuery.of(context).size.height * 0.3, // 30% da altura da tela
//                 fit: BoxFit.contain,
//               ),
//               const SizedBox(height: 20), // Espaçamento abaixo da imagem
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Column(
//                     children: const [
//                       Icon(
//                         Icons.recycling,
//                         size: 50,
//                         color: Color(0xFF67AB67),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Na aba Reciclagem, você pode descobrir em que lixo cada resíduo deve ser descartado, bem como quais materiais podem ou não podem ser reciclados',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Column(
//                     children: const [
//                       Icon(
//                         Icons.emoji_events,
//                         size: 50,
//                         color: Color(0xFF67AB67),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Em Ranking, você pode encontrar a colocação da sua turma, além de poder ver quantas moedas Fundinho cada turma já conseguiu acumular',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 14),
//                       ),
//                     ],
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
//               navigateWithSlideLR(context, const RecyclingScreen());
//               break;
//             case 1:
//               break;
//             case 2:
//               navigateWithSlideRL(context, const RankingScreen());
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: SingleChildScrollView(
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
            ],
          ),
        ),
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
            case 1:
              break;
            case 0:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const RecyclingScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return child; // Sem animação
                  },
                  transitionDuration: Duration.zero, // Duração zero
                  reverseTransitionDuration: Duration.zero, // Duração zero ao voltar
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const RankingScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return child; // Sem animação
                  },
                  transitionDuration: Duration.zero, // Duração zero
                  reverseTransitionDuration: Duration.zero, // Duração zero ao voltar
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
