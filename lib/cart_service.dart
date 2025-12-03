import 'package:flutter/material.dart';

class CartService extends ChangeNotifier {
  List<Map<String, dynamic>> itens = [];

  void adicionarItem(Map<String, dynamic> livro) {
    // Procura se o livro já está no carrinho
    final index = itens.indexWhere((item) => item['titulo'] == livro['titulo']);

    if (index != -1) {
      // Se já existe, aumenta a quantidade
      itens[index]['quantidade']++;
    } else {
      // Se não existe, adiciona novo item
      itens.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'titulo': livro['titulo'],
        'autor': livro['autor'],
        'image_url': livro['image_url'],
        'preco': (livro['preco'] is double) ? livro['preco'] : double.parse(livro['preco'].toString()),
        'quantidade': 1,
      });
    }

    notifyListeners();
  }

  void aumentarQtd(String id) {
    final index = itens.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      itens[index]['quantidade']++;
      notifyListeners();
    }
  }

  void diminuirQtd(String id) {
    final index = itens.indexWhere((item) => item['id'] == id);
    
    if (index != -1) {
      if (itens[index]['quantidade'] > 1) {
        itens[index]['quantidade']--;
      } else {
        itens.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removerItem(String id) {
    itens.removeWhere((item) => item['id'] == id);
    notifyListeners();
  }

  void limparCarrinho() {
    itens.clear();
    notifyListeners();
  }

  double subtotal() {
    return itens.fold(
      0.0,
      (soma, item) => soma + (item['preco'] * item['quantidade']),
    );
  }

  double frete() {
    return itens.isEmpty ? 0.0 : 15.70; // Frete só é cobrado se tiver itens
  }

  double total() {
    return subtotal() + frete();
  }

  int get totalItens {
    return itens.fold(0, (soma, item) => soma + (item['quantidade'] as int));
  }
}