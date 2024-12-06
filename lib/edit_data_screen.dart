import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditTurmasScreen extends StatelessWidget {
  const EditTurmasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Turmas"),
        backgroundColor: const Color(0xFF67AB67),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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

          final turmas = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: turmas.length,
            itemBuilder: (context, index) {
              final doc = turmas[index];
              final data = doc.data() as Map<String, dynamic>;

              return EditTurmaCard(
                turmaId: doc.id,
                initialData: data,
              );
            },
          );
        },
      ),
    );
  }
}

class EditTurmaCard extends StatefulWidget {
  final String turmaId;
  final Map<String, dynamic> initialData;

  const EditTurmaCard({
    super.key,
    required this.turmaId,
    required this.initialData,
  });

  @override
  _EditTurmaCardState createState() => _EditTurmaCardState();
}

class _EditTurmaCardState extends State<EditTurmaCard> {
  late TextEditingController papelController;
  late TextEditingController vidroController;
  late TextEditingController plasticoController;
  late TextEditingController pilhaController;
  late TextEditingController metalController;

  @override
  void initState() {
    super.initState();
    papelController = TextEditingController(text: widget.initialData['papel'].toString());
    vidroController = TextEditingController(text: widget.initialData['vidro'].toString());
    plasticoController = TextEditingController(text: widget.initialData['plastico'].toString());
    pilhaController = TextEditingController(text: widget.initialData['pilha'].toString());
    metalController = TextEditingController(text: widget.initialData['metal'].toString());
  }

  @override
  void dispose() {
    papelController.dispose();
    vidroController.dispose();
    plasticoController.dispose();
    pilhaController.dispose();
    metalController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    try {
      await FirebaseFirestore.instance.collection('turmas').doc(widget.turmaId).update({
        'papel': double.tryParse(papelController.text) ?? 0.0,
        'vidro': double.tryParse(vidroController.text) ?? 0.0,
        'plastico': double.tryParse(plasticoController.text) ?? 0.0,
        'pilha': double.tryParse(pilhaController.text) ?? 0.0,
        'metal': double.tryParse(metalController.text) ?? 0.0,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados atualizados com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Turma: ${widget.turmaId}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: papelController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Papel (kg)'),
            ),
            TextFormField(
              controller: vidroController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Vidro (kg)'),
            ),
            TextFormField(
              controller: plasticoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Plástico (kg)'),
            ),
            TextFormField(
              controller: pilhaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Pilha (kg)'),
            ),
            TextFormField(
              controller: metalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Metal (kg)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF67AB67),
              ),
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
