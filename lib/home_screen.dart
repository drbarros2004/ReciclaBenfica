// // import 'package:flutter/material.dart';

// // class HomeScreen extends StatelessWidget {
// //   const HomeScreen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: const Color(0xFF67AB67),
// //         elevation: 0,
// //       ),
// //       body: Container(
// //         color: const Color(0xFFE6F4E4),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             const Text(
// //               "Você é:",
// //               style: TextStyle(
// //                 fontSize: 24,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.green,
// //               ),
// //             ),
// //             const SizedBox(height: 40),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 _buildOptionCard(
// //                   context: context,
// //                   title: "Aluno",
// //                   icon: Icons.menu_book_rounded,
// //                   onTap: () {
// //                     Navigator.pushNamed(context, '/ranking'); // Vai direto para o ranking
// //                   },
// //                 ),
// //                 const SizedBox(width: 30),
// //                 _buildOptionCard(
// //                   context: context,
// //                   title: "Professor",
// //                   icon: Icons.person,
// //                   onTap: () {
// //                     Navigator.pushNamed(context, '/password'); // Navega para a tela de senha
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildOptionCard({
// //     required BuildContext context,
// //     required String title,
// //     required IconData icon,
// //     required VoidCallback onTap,
// //   }) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         width: 120,
// //         height: 150,
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(20),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.1),
// //               blurRadius: 8,
// //               offset: const Offset(0, 4),
// //             ),
// //           ],
// //         ),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(
// //               icon,
// //               size: 50,
// //               color: Colors.green,
// //             ),
// //             const SizedBox(height: 10),
// //             Text(
// //               title,
// //               style: const TextStyle(
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.green,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Bem-vindo"),
//         backgroundColor: const Color(0xFF67AB67),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Outras seções, como botões "Ranking" e "Reciclagem" podem ser adicionadas aqui
//           Center(
//             child: Text(
//               'Tela Inicial',
//               style: TextStyle(fontSize: 24),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: const Color(0xFF67AB67),
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.black,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Início',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bar_chart),
//             label: 'Ranking',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.recycling),
//             label: 'Reciclagem',
//           ),
//         ],
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               // Caso de Início, já estamos na tela inicial
//               break;
//             case 1:
//               Navigator.pushNamed(context, '/ranking');
//               break;
//             case 2:
//               Navigator.pushNamed(context, '/recycling');
//               break;
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bem-vindo"),
        backgroundColor: const Color(0xFF67AB67),
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
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF67AB67),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 202, 202, 202),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Ranking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recycling),
            label: 'Reciclagem',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Caso de Início, já estamos na tela inicial
              break;
            case 1:
              Navigator.pushNamed(context, '/ranking');
              break;
            case 2:
              Navigator.pushNamed(context, '/recycling');
              break;
          }
        },
      ),
    );
  }
}
