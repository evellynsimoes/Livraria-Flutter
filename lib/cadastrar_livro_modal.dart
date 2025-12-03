import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class CadastrarLivroModal extends StatefulWidget {
  final String? id;
  final Map<String, dynamic>? dados;

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
      final dados = {
        'nome': nomeController.text,
        'autor': autorController.text,
        'imagem': imagemController.text,
        'preco': precoController.text,
        'categoria': categoriaSelecionada,
      };

      if (widget.id == null) {
        // POST - Cadastrar novo
        await FirebaseFirestore.instance.collection('livros').add(dados);
      } else {
        // PUT - Atualizar existente
        await FirebaseFirestore.instance
            .collection('livros')
            .doc(widget.id)
            .update(dados);
      }

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.id == null ? "Livro cadastrado!" : "Livro atualizado!",
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar: $e', style: GoogleFonts.poppins()),
          backgroundColor: const Color(0xFFDC2626),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF1F5F9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.id == null ? "Cadastrar Livro" : "Editar Livro",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(nomeController, "Nome do Livro"),
            const SizedBox(height: 16),
            _buildTextField(autorController, "Autor"),
            const SizedBox(height: 16),
            _buildTextField(imagemController, "Link da Imagem"),
            const SizedBox(height: 16),
            _buildTextField(precoController, "Preço"),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: categoriaSelecionada,
              decoration: InputDecoration(
                labelText: "Categoria",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'fantasy', child: Text('Fantasy')),
                DropdownMenuItem(value: 'comedy', child: Text('Comedy')),
                DropdownMenuItem(value: 'horror', child: Text('Horror')),
                DropdownMenuItem(value: 'romance', child: Text('Romance')),
              ],
              onChanged: (value) => setState(() => categoriaSelecionada = value!),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFF94A3B8)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Cancelar",
                      style: GoogleFonts.poppins(color: const Color(0xFF64748B)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: salvarLivro,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      widget.id == null ? "Salvar" : "Atualizar",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Color(0xFF1E293B)),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF10B981), width: 2),
        ),
      ),
    );
  }
}