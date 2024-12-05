import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/navigation_utils.dart';
import 'recycling_screen.dart';
import 'home_screen.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dados das turmas
    final List<Map<String, dynamic>> rankings = [
      {
        "turma": "7º Ano A",
        "papel": 5.0,
        "vidro": 2.0,
        "plastico": 3.0,
        "pilha": 0.1,
        "metal": 1.0,
      },
      {
        "turma": "8º Ano B",
        "papel": 3.0,
        "vidro": 1.0,
        "plastico": 4.0,
        "pilha": 0.05,
        "metal": 2.0,
      },
      {
        "turma": "8º Ano C",
        "papel": 6.0,
        "vidro": 2.0,
        "plastico": 4.0,
        "pilha": 0.4,
        "metal": 2.0,
      },
    ];

    // Pesos atribuídos a cada material reciclado
    const Map<String, double> pesos = {
      "papel": 1.0,
      "vidro": 5.0,
      "plastico": 1.5,
      "pilha": 50.0,
      "metal": 5.0,
    };

    // Calcula o total em quilos e a pontuação para cada turma
    for (var turma in rankings) {
      turma["total_quilos"] = turma["papel"] +
          turma["vidro"] +
          turma["plastico"] +
          turma["pilha"] +
          turma["metal"];
      turma["pontuacao"] = 
          pesos["papel"]! * turma["papel"] +
          pesos["vidro"]! * turma["vidro"] +
          pesos["plastico"]! * turma["plastico"] +
          pesos["pilha"]! * turma["pilha"] +
          pesos["metal"]! * turma["metal"];

      // Calcula a proporção de cada material na pontuação total
      turma["progresso"] = [
        (pesos["papel"]! * turma["papel"]) / turma["pontuacao"],
        (pesos["vidro"]! * turma["vidro"]) / turma["pontuacao"],
        (pesos["plastico"]! * turma["plastico"]) / turma["pontuacao"],
        (pesos["pilha"]! * turma["pilha"]) / turma["pontuacao"],
        (pesos["metal"]! * turma["metal"]) / turma["pontuacao"],
      ];
    }

    // Ordena as turmas pela pontuação (maior primeiro)
    rankings.sort((a, b) => b["pontuacao"].compareTo(a["pontuacao"]));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ranking"),
        backgroundColor: const Color(0xFF67AB67),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/profile_selection_screen');
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: rankings.length,
        itemBuilder: (context, index) {
          final turma = rankings[index];
          return RankingCard(
            position: index + 1,
            turma: turma["turma"],
            papel: "${turma["papel"]} kg",
            vidro: "${turma["vidro"]} kg",
            plastico: "${turma["plastico"]} kg",
            pilha: "${turma["pilha"]} kg",
            metal: "${turma["metal"]} kg",
            totalQuilos: "${turma["total_quilos"]!.toStringAsFixed(2)} kg",
            pontuacao: turma["pontuacao"]!.toStringAsFixed(2),
            progresso: turma["progresso"] as List<double>,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF67AB67),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54,
        currentIndex: 2,
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
              // Navigator.pushNamed(context, '/home_screen');
              navigateWithSlideLR(context, const HomeScreen());
              break;
            case 2:
              break;
          }
        }
      )  
    );
  }
}

class RankingCard extends StatefulWidget {
  final int position;
  final String turma;
  final String papel;
  final String vidro;
  final String plastico;
  final String pilha;
  final String metal;
  final String totalQuilos;
  final String pontuacao;
  final List<double> progresso;

  const RankingCard({
    super.key,
    required this.position,
    required this.turma,
    required this.papel,
    required this.vidro,
    required this.plastico,
    required this.pilha,
    required this.metal,
    required this.totalQuilos,
    required this.pontuacao,
    required this.progresso,
  });

  @override
  _RankingCardState createState() => _RankingCardState();
}

class _RankingCardState extends State<RankingCard> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.green[50],
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome e posição da turma
                Text(
                  "#${widget.position} - Turma: ${widget.turma}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Barra de progresso contínua
                SizedBox(
                  height: 15,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Row(
                        children: widget.progresso.asMap().entries.map((entry) {
                          final index = entry.key;
                          final value = entry.value;
                          final colors = [
                            Colors.blue,
                            Colors.green,
                            Colors.red,
                            Colors.orange,
                            Colors.yellow,
                          ];
                          return Expanded(
                            flex: (value * 100).toInt(),
                            child: Container(
                              decoration: BoxDecoration(
                                color: colors[index],
                                borderRadius: index == 0
                                    ? const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      )
                                    : index == widget.progresso.length - 1
                                        ? const BorderRadius.only(
                                            topRight: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          )
                                        : null,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Detalhes da turma (expandível)
                if (_isExpanded)
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      InfoTile(color: Colors.blue, label: "Papel", value: widget.papel),
                      InfoTile(color: Colors.green, label: "Vidro", value: widget.vidro),
                      InfoTile(color: Colors.red, label: "Plástico", value: widget.plastico),
                      InfoTile(color: Colors.orange, label: "Pilha", value: widget.pilha),
                      InfoTile(color: Colors.yellow, label: "Metal", value: widget.metal),
                      InfoTile(color: Colors.purple, label: "Total (Kg)", value: widget.totalQuilos),
                    ],
                  ),

                // Pontuação fixa
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Pontuação: ${widget.pontuacao}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
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
    super.key,
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
        const SizedBox(width: 8),
        Text("$label: $value"),
      ],
    );
  }
}

