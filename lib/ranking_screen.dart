import 'package:flutter/material.dart';

class RankingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ranking"),
        backgroundColor: const Color(0xFF67AB67),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          RankingCard(
            turma: "7º Ano A",
            papel: "5 kg",
            vidro: "2 kg",
            plastico: "3 kg",
            pilha: "100 g",
            metal: "1 kg",
            total: "11 kg",
            progressValues: [0.4, 0.2, 0.3, 0.1],
          ),
          RankingCard(
            turma: "8º Ano B",
            papel: "3 kg",
            vidro: "1 kg",
            plastico: "4 kg",
            pilha: "50 g",
            metal: "2 kg",
            total: "10 kg",
            progressValues: [0.3, 0.1, 0.4, 0.2],
          ),
          // Adicione mais turmas aqui...
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Índice da aba atual
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.recycling),
            label: "Reciclagem",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: "Ranking",
          ),
        ],
        onTap: (index) {
          // Navegar entre abas
        },
      ),
    );
  }
}

class RankingCard extends StatelessWidget {
  final String turma;
  final String papel;
  final String vidro;
  final String plastico;
  final String pilha;
  final String metal;
  final String total;
  final List<double> progressValues;

  const RankingCard({
    required this.turma,
    required this.papel,
    required this.vidro,
    required this.plastico,
    required this.pilha,
    required this.metal,
    required this.total,
    required this.progressValues,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.green[50],
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Turma - $turma",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: progressValues.reduce((a, b) => a + b),
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(Colors.green),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                InfoTile(color: Colors.blue, label: "Papel", value: papel),
                InfoTile(color: Colors.green, label: "Vidro", value: vidro),
                InfoTile(color: Colors.red, label: "Plástico", value: plastico),
                InfoTile(color: Colors.orange, label: "Pilha", value: pilha),
                InfoTile(color: Colors.yellow, label: "Metal", value: metal),
                InfoTile(color: Colors.purple, label: "Total", value: total),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final Color color;
  final String label;
  final String value;

  const InfoTile({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 5, backgroundColor: color),
        SizedBox(width: 8),
        Text("$label: $value"),
      ],
    );
  }
}
