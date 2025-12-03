import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'cart_service.dart';
import 'cadastrar_livro_modal.dart';
import 'categoria_livros.dart';
import 'cart_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartService>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: const Text(
          "DreamBound",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0D44BA), Color(0xFF993186)],
            ),
          ),
        ),
        elevation: 0,

        // ➕ ADICIONADO SEM MEXER NO RESTO
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartPage()),
                  );
                },
              ),

              // BADGE DE QUANTIDADE
              if (cart.itens.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cart.itens.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      // FIM DO APPBAR ↑↑↑

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CategoriaLivros(titulo: "Fantasy", categoria: "fantasy"),
            const SizedBox(height: 24),
            const CategoriaLivros(titulo: "Comedy", categoria: "comedy"),
            const SizedBox(height: 24),
            const CategoriaLivros(titulo: "Horror", categoria: "horror"),
            const SizedBox(height: 32),
            const CategoriaLivros(titulo: "Romance", categoria: "romance"),
            const SizedBox(height: 32),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const CadastrarLivroModal(),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("Cadastrar Livro"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF993186),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
