import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastrarLivroModal extends StatefulWidget {
  final String? id;                     // SE NULL → Cadastrar
  final Map<String, dynamic>? dados;    // Dados do livro para edição

  const CadastrarLivroModal({super.key, this.id, this.dados});

  @override
  State<CadastrarLivroModal> createState() => _CadastrarLivroModalState();
}

class _CadastrarLivroModalState extends State<CadastrarLivroModal> {
  final nomeController = TextEditingController();
  final autorController = TextEditingController();
  final imagemController = TextEditingController();
  final precoController = TextEditingController();
  String categoriaSelecionada = 'fantasy';

  @override
  void initState() {
    super.initState();

    // Se estiver editando, preencher os campos
    if (widget.dados != null) {
      nomeController.text = widget.dados!['nome'];
      autorController.text = widget.dados!['autor'];
      imagemController.text = widget.dados!['imagem'];
      precoController.text = widget.dados!['preco'];
      categoriaSelecionada = widget.dados!['categoria'];
    }
  }

  Future<void> salvarLivro() async {
    try {
      if (widget.id == null) {
        // CADASTRAR
        await FirebaseFirestore.instance.collection('livros').add({
          'nome': nomeController.text,
          'autor': autorController.text,
          'imagem': imagemController.text,
          'preco': precoController.text,
          'categoria': categoriaSelecionada,
        });
      } else {
        // EDITAR
        await FirebaseFirestore.instance
            .collection('livros')
            .doc(widget.id)
            .update({
          'nome': nomeController.text,
          'autor': autorController.text,
          'imagem': imagemController.text,
          'preco': precoController.text,
          'categoria': categoriaSelecionada,
        });
      }

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.id == null ? "Cadastrar Livro" : "Editar Livro"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: "Nome do Livro"),
            ),
            TextField(
              controller: autorController,
              decoration: const InputDecoration(labelText: "Autor"),
            ),
            TextField(
              controller: imagemController,
              decoration: const InputDecoration(labelText: "Link da Imagem"),
            ),
            TextField(
              controller: precoController,
              decoration: const InputDecoration(labelText: "Preço"),
            ),
            DropdownButton<String>(
              value: categoriaSelecionada,
              items: const [
                DropdownMenuItem(value: 'fantasy', child: Text('Fantasy')),
                DropdownMenuItem(value: 'comedy', child: Text('Comedy')),
                DropdownMenuItem(value: 'horror', child: Text('Horror')),
                DropdownMenuItem(value: 'romance', child: Text('Romance')),
              ],
              onChanged: (value) =>
                  setState(() => categoriaSelecionada = value!),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
            onPressed: salvarLivro,
            child: Text(widget.id == null ? "Salvar" : "Atualizar")),
      ],
    );
  }
}
