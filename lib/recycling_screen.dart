

import 'package:flutter/material.dart';
import 'ranking_screen.dart';
import 'home_screen.dart';
import 'package:flutter_application_1/utils/navigation_utils.dart';

class RecyclingScreen extends StatelessWidget {
  const RecyclingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'label': 'Papel',
        'color': const Color(0xFF8CCDED),
        'icon': Icons.article,
        'info': 'A reciclagem do papel desempenha um papel fundamental na preservação ambiental, pois reduz a necessidade de derrubar árvores para produzir mais papel. A indústria do papel é uma das maiores responsáveis pelo desmatamento e pela emissão de gases de efeito estufa, e, ao reciclar o papel, evitamos essas consequências negativas. Além disso, a reciclagem de papel consome menos energia e água do que a produção de papel novo a partir de madeira. Isso contribui para uma menor emissão de poluentes na atmosfera e para a preservação dos recursos hídricos, essenciais para a vida na Terra. O papel reciclado também ajuda a diminuir o volume de lixo nos aterros sanitários, evitando o acúmulo de resíduos e a poluição do solo e das águas. Portanto, a reciclagem do papel é uma maneira eficaz de reduzir o impacto ambiental e promover a sustentabilidade.',
        'recyclables': ['Jornal', 'Revista', 'Folha de caderno', 'Caixa de papelão', 'Caixa de sapato'],
        'nonRecyclables': ['Papel engordurado', 'Papel toalha usado', 'Guardanapo usado', 'Papel higiênico usado', 'Papel plastificado'],
      },
      {
        'label': 'Plástico',
        'color': const Color(0xFFFF8585),
        'icon': Icons.local_drink,
         'info': 'A reciclagem do plástico é uma das questões mais urgentes para a preservação do meio ambiente. O plástico, quando descartado de forma inadequada, pode levar centenas de anos para se decompor, causando sérios danos aos ecossistemas e à vida selvagem. Ao reciclar plásticos, conseguimos reduzir o impacto ambiental causado pela produção de plástico novo e pela poluição nos oceanos e no solo. A reciclagem de plástico diminui a necessidade de extração de petróleo, que é a principal matéria-prima para a fabricação de plásticos, ajudando a preservar os recursos naturais e reduzir a emissão de gases de efeito estufa. Além disso, a reciclagem de plásticos reduz a quantidade de resíduos sólidos nos aterros sanitários e diminui a poluição do ambiente. Embora a reciclagem do plástico seja desafiadora devido à variedade de tipos de plásticos, é uma etapa essencial para um futuro mais sustentável e para a preservação dos ecossistemas marinhos e terrestres.',
        'recyclables': ['Garrafa PET', 'Embalagem plástica', 'Sacola plástica', 'Copo plástico', 'Embalagem de iogurte'],
        'nonRecyclables': ['Canudo plástico', 'Plástico contaminado com alimentos', 'Filme plástico', 'Plástico bolha', 'Talher plástico'],
      },
      {
        'label': 'Metal',
        'color': const Color(0xFFFCE95A),
        'icon': Icons.build,
        'info': 'A reciclagem de metais é uma das formas mais eficientes de preservar os recursos naturais e reduzir os impactos ambientais da extração de minérios. O processo de extração de metais da natureza, como o alumínio e o aço, exige grande quantidade de energia e causa a degradação dos ecossistemas. Ao reciclar metais, como latas de alumínio ou sucata de ferro, conseguimos economizar até 95% da energia que seria utilizada na produção de metal novo. Além disso, a reciclagem de metais evita a exploração de recursos finitos, preservando os ecossistemas e reduzindo a poluição ambiental. A reciclagem de metais também diminui as emissões de gases de efeito estufa, pois exige menos energia do que a produção a partir de minérios, contribuindo para a luta contra as mudanças climáticas. Em resumo, a reciclagem de metais é crucial para a conservação de recursos e a redução dos impactos ambientais negativos.',
        'recyclables': ['Lata de alumínio', 'Lata de alimento', 'Fio de cobre', 'Tampa de frasco', 'Recipiente de metal limpo'],
        'nonRecyclables': ['Panela', 'Metal contaminado', 'Frigideira', 'Lata de alimento não limpa', 'Seringa de metal'],
      },
      {
        'label': 'Vidro',
        'color': const Color(0xFF94E47C),
        'icon': Icons.wine_bar,
          'info': 'A reciclagem de vidro é uma prática essencial para a preservação do meio ambiente, pois o vidro é 100% reciclável e pode ser reutilizado sem perder a qualidade. Ao reciclar vidro, evitamos a necessidade de extrair matérias-primas como areia, calcário e soda, o que reduz o impacto ambiental da mineração e da exploração de recursos naturais. Além disso, a reciclagem de vidro consome muito menos energia do que a produção de vidro novo, ajudando a reduzir a emissão de gases poluentes e a contribuir para a redução do aquecimento global. A reciclagem de vidro também diminui a quantidade de resíduos nos aterros sanitários, ajudando a evitar o acúmulo de lixo e a poluição do solo e da água. Como o vidro pode ser reciclado infinitamente sem perder suas propriedades, ele é uma das opções mais sustentáveis para a redução de resíduos e a preservação do meio ambiente.',
        'recyclables': ['Garrafa de vidro', 'Pote de vidro', 'Frasco de vidro', 'Copo de vidro', 'Vidro de medicamento'],
        'nonRecyclables': ['Vidro quebrado', 'Vidro de cerâmica', 'Lâmpada de vidro', 'Vidro temperado', 'Espelho'],
      },
      {
        'label': 'Pilha',
        'color': const Color(0xFFF9AD43),
        'icon': Icons.battery_full,
          'info': 'A reciclagem de pilhas é crucial para evitar a contaminação do solo e da água com substâncias tóxicas e metais pesados presentes nas pilhas. Quando as pilhas são descartadas incorretamente, elas podem vazar substâncias perigosas, como mercúrio, cádmio e chumbo, que são altamente poluentes e prejudiciais à saúde humana e animal. A reciclagem de pilhas ajuda a recuperar esses metais preciosos e evita que eles se acumulem no meio ambiente. Além disso, a reciclagem de pilhas reduz a necessidade de minerar esses metais, contribuindo para a preservação dos recursos naturais. O processo de reciclagem de pilhas também diminui a quantidade de resíduos tóxicos nos aterros sanitários, reduzindo o impacto ambiental e melhorando a saúde do ecossistema. Dessa forma, a reciclagem de pilhas é uma prática essencial para a segurança ambiental e para a conservação dos recursos naturais.',
        'recyclables': ['Pilha alcalina', 'Pilha de lítio', 'Pilha recarregável', 'Pilha de zinco-carbono', 'Bateria recarregável de celular e laptop'],
        'nonRecyclables': ['Pilha de mercúrio', 'Pilha danificada ou vazando', 'Pilha de cádmio', 'Bateria de automóvel', 'Pilha de aparelho de audição'],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reciclagem',
        style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white),
                ),
        backgroundColor: const Color(0xFF67AB67),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/profile_selection_screen');
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> category = categories[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                color: category['color'] as Color,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {},
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      Container(
                        color: Colors.white, // Define o fundo branco
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              category['info'] as String,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Coluna para itens recicláveis
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(
                                      (category['recyclables'] as List<String>).length,
                                      (index) {
                                        return ListTile(
                                          leading: const Icon(Icons.check, color: Colors.green),
                                          title: Text(
                                            category['recyclables'][index] as String,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Coluna para itens não recicláveis
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(
                                      (category['nonRecyclables'] as List<String>).length,
                                      (index) {
                                        return ListTile(
                                          leading: const Icon(Icons.close, color: Colors.red),
                                          title: Text(
                                            category['nonRecyclables'][index] as String,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
            icon: Icon(Icons.emoji_events),
            label: 'Ranking',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Já estamos na tela de reciclagem
              break;
            case 1:
              navigateWithFade(context, HomeScreen());
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