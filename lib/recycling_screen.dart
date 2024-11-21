// // import 'package:flutter/material.dart';

// // class RecyclingScreen extends StatelessWidget {
// //   const RecyclingScreen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Reciclagem"),
// //         backgroundColor: const Color(0xFF67AB67),
// //       ),
// //       body: ListView(
// //         padding: const EdgeInsets.all(10.0),
// //         children: [
// //           _buildMaterialTile(
// //             context: context,
// //             material: "Papel",
// //             color: Colors.blue,
// //             icon: Icons.description,
// //             description:
// //                 "Insira texto aqui sobre a reciclagem de papel, incluindo informações como benefícios e exemplos de materiais recicláveis.",
// //           ),
// //           _buildMaterialTile(
// //             context: context,
// //             material: "Vidro",
// //             color: Colors.green,
// //             icon: Icons.wine_bar,
// //             description:
// //                 "Insira texto aqui sobre a reciclagem de vidro, incluindo como é reciclado e sua importância.",
// //           ),
// //           _buildMaterialTile(
// //             context: context,
// //             material: "Plástico",
// //             color: Colors.red,
// //             icon: Icons.local_drink,
// //             description:
// //                 "Insira texto aqui sobre a reciclagem de plástico, destacando o impacto ambiental e formas de reaproveitamento.",
// //           ),
// //           _buildMaterialTile(
// //             context: context,
// //             material: "Metal",
// //             color: Colors.amber,
// //             icon: Icons.hardware,
// //             description:
// //                 "Insira texto aqui sobre a reciclagem de metal, exemplos de materiais metálicos e a economia de energia na reciclagem.",
// //           ),
// //           _buildMaterialTile(
// //             context: context,
// //             material: "Pilhas",
// //             color: Colors.brown,
// //             icon: Icons.battery_alert,
// //             description:
// //                 "Insira texto aqui sobre a reciclagem de pilhas e baterias, explicando a importância do descarte correto.",
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildMaterialTile({
// //     required BuildContext context,
// //     required String material,
// //     required Color color,
// //     required IconData icon,
// //     required String description,
// //   }) {
// //     return Card(
// //       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 80.0),
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(15),
// //       ),
// //       elevation: 5,
// //       child: ExpansionTile(
// //         leading: Icon(icon, color: color, size: 40),
// //         title: Text(
// //           material,
// //           style: TextStyle(
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //             color: color,
// //           ),
// //         ),
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.all(15.0),
// //             child: Text(
// //               description,
// //               style: const TextStyle(fontSize: 16),
// //               textAlign: TextAlign.justify,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class RecyclingScreen extends StatelessWidget {
//   const RecyclingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final categories = [
//       {'label': 'Papel', 'color': const Color(0xFF8CCDED), 'icon': Icons.article},
//       {'label': 'Plástico', 'color': const Color(0xFFFF8585), 'icon': Icons.local_drink},
//       {'label': 'Metal', 'color': const Color(0xFFFCE95A), 'icon': Icons.build},
//       {'label': 'Vidro', 'color': const Color(0xFF94E47C), 'icon': Icons.wine_bar},
//       {'label': 'Pilha', 'color': const Color(0xFFF9AD43), 'icon': Icons.battery_full},
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Reciclagem'),
//         backgroundColor: const Color(0xFF67AB67),
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           final category = categories[index];
//           return ExpansionTile(
//             leading: Icon(
//               category['icon'] as IconData,
//               size: 30,
//               color: Colors.black54,
//             ),
//             title: Text(
//               category['label'] as String,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             backgroundColor: (category['color'] as Color).withOpacity(0.3),
//             collapsedBackgroundColor: category['color'] as Color,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Insira texto aqui sobre a reciclagem de ${category['label']}...',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: const Color(0xFF67AB67),
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.black54,
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
//             icon: Icon(Icons.bar_chart),
//             label: 'Ranking',
//           ),
//         ],
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               // Já estamos na tela de reciclagem
//               break;
//             case 1:
//               Navigator.pushNamed(context, '/home');
//               break;
//             case 2:
//               Navigator.pushNamed(context, '/ranking');
//               break;
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

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
              Navigator.pushNamed(context, '/home');
              break;
            case 2:
              Navigator.pushNamed(context, '/ranking');
              break;
          }
        },
      ),
    );
  }
}
