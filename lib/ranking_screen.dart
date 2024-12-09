import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'recycling_screen.dart';
import 'home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/utils/navigation_utils.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  /// Recupera o valor de isProfessor armazenado no SharedPreferences
  Future<bool> getIsProfessor() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isProfessor') ?? false; // Retorna false se não configurado
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getIsProfessor(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final isProfessor = snapshot.data ?? false;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Ranking",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
            ),
            backgroundColor: const Color(0xFF67AB67),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, '/profile_selection_screen');
              },
            ),
            actions: isProfessor
                ? [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.pushNamed(context, '/edit_data_screen');
                      },
                    ),
                  ]
                : null,
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('turmas').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('Nenhuma turma encontrada.'));
              }

              // Lógica para calcular os rankings
              final turmas = snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return {
                  "turma": data['nome'] ?? "Turma sem nome",
                  "papel": data['papel'] ?? 0.0,
                  "vidro": data['vidro'] ?? 0.0,
                  "plastico": data['plastico'] ?? 0.0,
                  "pilha": data['pilha'] ?? 0.0,
                  "metal": data['metal'] ?? 0.0,
                };
              }).toList();

              const Map<String, double> pesos = {
                "papel": 1.0,
                "vidro": 5.0,
                "plastico": 1.5,
                "pilha": 50.0,
                "metal": 5.0,
              };

              for (var turma in turmas) {
                final totalPontuacao = pesos["papel"]! * turma["papel"] +
                    pesos["vidro"]! * turma["vidro"] +
                    pesos["plastico"]! * turma["plastico"] +
                    pesos["pilha"]! * turma["pilha"] +
                    pesos["metal"]! * turma["metal"];

                turma["total_quilos"] = turma["papel"] +
                    turma["vidro"] +
                    turma["plastico"] +
                    turma["pilha"] +
                    turma["metal"];

                turma["pontuacao"] = totalPontuacao;

                // Calculando o progresso para a barra
                turma["progresso"] = [
                  pesos["papel"]! * turma["papel"] / totalPontuacao,
                  pesos["vidro"]! * turma["vidro"] / totalPontuacao,
                  pesos["plastico"]! * turma["plastico"] / totalPontuacao,
                  pesos["pilha"]! * turma["pilha"] / totalPontuacao,
                  pesos["metal"]! * turma["metal"] / totalPontuacao,
                ];
              }

              turmas.sort((a, b) => b["pontuacao"].compareTo(a["pontuacao"]));

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: turmas.length,
                itemBuilder: (context, index) {
                  final turma = turmas[index];
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
                    progresso: turma["progresso"],
                  );
                },
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
                  navigateWithFade(context, RecyclingScreen());
                  break;
                case 1:
                  navigateWithFade(context, HomeScreen());
                  break;
                case 2:
                  break;
              }
            },
          ),
        );
      },
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
      color: const Color(0xFFC3EEAC),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Conteúdo principal do card
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nome e posição da turma
                    Text(
                      "#${widget.position} - Turma: ${widget.turma}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E672E),
                      ),
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
                              borderRadius: BorderRadius.circular(20),
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
                          InfoTile(color: Colors.purple, label: "Total (kg)", value: widget.totalQuilos),
                        ],
                      ),

                    // Pontuação fixa
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Pontuação: ${widget.pontuacao}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF2E672E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Botão para expandir/recolher
              IconButton(
                icon: Icon(
                  _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: const Color(0xFF2E672E),
                ),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ],
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