
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditTurmasScreen extends StatefulWidget {
  const EditTurmasScreen({super.key});

  @override
  _EditTurmasScreenState createState() => _EditTurmasScreenState();
}

class _EditTurmasScreenState extends State<EditTurmasScreen> {
  final Map<String, String> turmaNames = {}; // Mapeia o ID da turma para o nome customizado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar dados de turma e senha',
        style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white),
                ),
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
            itemCount: turmas.length + 3, // Adiciona três: editar senha, editar pesos, criar turma
            itemBuilder: (context, index) {
              if (index < turmas.length) {
                final doc = turmas[index];
                final data = doc.data() as Map<String, dynamic>;
                final nome = data['nome'] as String? ?? 'Sem Nome';

                return EditTurmaCard(
                  turmaId: doc.id,
                  initialData: data,
                  initialName: turmaNames[doc.id] ?? nome,
                  onNameChanged: (newName) {
                    setState(() {
                      turmaNames[doc.id] = newName;
                    });
                  },
                );
              } else if (index == turmas.length) {
                return const EditPasswordSection(); // Alterar senha
              } else if (index == turmas.length + 1) {
                return const EditWeightsSection(); // Editar pesos
              } else {
                return const CreateTurmaSection(); // Criar nova turma
              }
            },
          );
        },
      ),
    );
  }
}


class CreateTurmaSection extends StatefulWidget {
  const CreateTurmaSection({super.key});

  @override
  _CreateTurmaSectionState createState() => _CreateTurmaSectionState();
}

class _CreateTurmaSectionState extends State<CreateTurmaSection> {
  final TextEditingController _turmaNameController = TextEditingController();
  final Map<String, TextEditingController> controllers = {
    'papel': TextEditingController(),
    'vidro': TextEditingController(),
    'plastico': TextEditingController(),
    'pilha': TextEditingController(),
    'metal': TextEditingController(),
  };

  Future<void> _createTurma() async {
    try {
      final Map<String, double> newData = {
        for (var key in controllers.keys) key: double.tryParse(controllers[key]!.text) ?? 0.0,
      };
      await FirebaseFirestore.instance.collection('turmas').add({
        'nome': _turmaNameController.text,
        ...newData,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nova turma criada com sucesso!')),
      );
      _turmaNameController.clear();
      for (var controller in controllers.values) {
        controller.clear();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao criar turma: $e')),
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
            const Text(
              "Criar Nova Turma",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _turmaNameController,
              decoration: const InputDecoration(labelText: 'Nome da Turma'),
            ),
            ...controllers.keys.map((key) {
              return TextFormField(
                controller: controllers[key],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: '$key (kg)'),
              );
            }),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createTurma,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF67AB67),
              ),
              child: const Text('Criar Turma'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditTurmaCard extends StatefulWidget {
  final String turmaId;
  final String initialName;
  final Map<String, dynamic> initialData;
  final void Function(String newName) onNameChanged;

  const EditTurmaCard({
    super.key,
    required this.turmaId,
    required this.initialData,
    required this.initialName,
    required this.onNameChanged,
  });

  @override
  _EditTurmaCardState createState() => _EditTurmaCardState();
}

class _EditTurmaCardState extends State<EditTurmaCard> {
  late TextEditingController nameController;
  late TextEditingController papelController;
  late TextEditingController vidroController;
  late TextEditingController plasticoController;
  late TextEditingController pilhaController;
  late TextEditingController metalController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName);
    papelController = TextEditingController(text: widget.initialData['papel'].toString());
    vidroController = TextEditingController(text: widget.initialData['vidro'].toString());
    plasticoController = TextEditingController(text: widget.initialData['plastico'].toString());
    pilhaController = TextEditingController(text: widget.initialData['pilha'].toString());
    metalController = TextEditingController(text: widget.initialData['metal'].toString());
  }

  @override
  void dispose() {
    nameController.dispose();
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
        'nome': nameController.text,
      });
      widget.onNameChanged(nameController.text);
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
            TextFormField(
              // controller: nameController,
              // decoration: const InputDecoration(labelText: 'Nome da Turma'),
              // onChanged: widget.onNameChanged,
              controller: nameController,
                decoration: const InputDecoration(labelText: 'Nome da Turma'),
                onChanged: (newName) {
                  widget.onNameChanged(newName);
                },
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


class EditPasswordSection extends StatefulWidget {
  const EditPasswordSection({super.key});

  @override
  _EditPasswordSectionState createState() => _EditPasswordSectionState();
}

class _EditPasswordSectionState extends State<EditPasswordSection> {
  final TextEditingController _passwordController = TextEditingController();
  String? _successMessage;
  String? _errorMessage;

  /// Atualiza a senha no Firebase
  Future<void> _updatePassword() async {
    try {
      await FirebaseFirestore.instance
          .collection('config')
          .doc('password')
          .set({'value': _passwordController.text});

      setState(() {
        _successMessage = "Senha atualizada com sucesso!";
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Erro ao atualizar a senha.";
        _successMessage = null;
      });
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
            const Text(
              "Alterar Senha de Professor",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Nova Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updatePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF67AB67),
              ),
              child: const Text('Salvar Nova Senha'),
            ),
            const SizedBox(height: 8),
            if (_successMessage != null)
              Text(
                _successMessage!,
                style: const TextStyle(color: Colors.green),
              ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

class EditWeightsSection extends StatefulWidget {
  const EditWeightsSection({super.key});

  @override
  _EditWeightsSectionState createState() => _EditWeightsSectionState();
}

class _EditWeightsSectionState extends State<EditWeightsSection> {
  final Map<String, TextEditingController> _weightControllers = {
    'papel': TextEditingController(),
    'vidro': TextEditingController(),
    'plastico': TextEditingController(),
    'pilha': TextEditingController(),
    'metal': TextEditingController(),
  };

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWeights();
  }

  Future<void> _loadWeights() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('config')
          .doc('pesos')
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        for (var key in _weightControllers.keys) {
          _weightControllers[key]?.text = (data[key] ?? 0.0).toString();
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar os pesos: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveWeights() async {
    try {
      final Map<String, double> newWeights = {
        for (var key in _weightControllers.keys)
          key: double.tryParse(_weightControllers[key]!.text) ?? 0.0,
      };

      await FirebaseFirestore.instance
          .collection('config')
          .doc('pesos')
          .set(newWeights);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pesos atualizados com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar os pesos: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Editar Pesos de Pontuação",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ..._weightControllers.keys.map((key) {
              return TextFormField(
                controller: _weightControllers[key],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Peso para $key'),
              );
            }),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveWeights,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF67AB67),
              ),
              child: const Text('Salvar Pesos'),
            ),
          ],
        ),
      ),
    );
  }
}
