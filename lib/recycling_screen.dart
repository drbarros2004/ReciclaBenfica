import 'package:flutter/material.dart';

class RecyclingScreen extends StatelessWidget {
  const RecyclingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reciclagem"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          _buildMaterialTile(
            context: context,
            material: "Papel",
            color: Colors.blue,
            icon: Icons.description,
            description:
                "Insira texto aqui sobre a reciclagem de papel, incluindo informações como benefícios e exemplos de materiais recicláveis.",
          ),
          _buildMaterialTile(
            context: context,
            material: "Vidro",
            color: Colors.green,
            icon: Icons.wine_bar,
            description:
                "Insira texto aqui sobre a reciclagem de vidro, incluindo como é reciclado e sua importância.",
          ),
          _buildMaterialTile(
            context: context,
            material: "Plástico",
            color: Colors.red,
            icon: Icons.local_drink,
            description:
                "Insira texto aqui sobre a reciclagem de plástico, destacando o impacto ambiental e formas de reaproveitamento.",
          ),
          _buildMaterialTile(
            context: context,
            material: "Metal",
            color: Colors.amber,
            icon: Icons.hardware,
            description:
                "Insira texto aqui sobre a reciclagem de metal, exemplos de materiais metálicos e a economia de energia na reciclagem.",
          ),
          _buildMaterialTile(
            context: context,
            material: "Pilhas",
            color: Colors.brown,
            icon: Icons.battery_alert,
            description:
                "Insira texto aqui sobre a reciclagem de pilhas e baterias, explicando a importância do descarte correto.",
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialTile({
    required BuildContext context,
    required String material,
    required Color color,
    required IconData icon,
    required String description,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 80.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ExpansionTile(
        leading: Icon(icon, color: color, size: 40),
        title: Text(
          material,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
