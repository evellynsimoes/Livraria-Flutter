import 'package:flutter/material.dart';

class CartService extends ChangeNotifier {
  List<Map<String, dynamic>> itens = [];

  void adicionarAoCarrinho(Map<String, dynamic> livro) {
    // Se o item já estiver no carrinho, aumenta a quantidade
    final index = itens.indexWhere((item) => item['id'] == livro['id']);

    if (index != -1) {
      itens[index]['quantidade']++;
    } else {
      itens.add({
        'id': livro['id'],
        'nome': livro['nome'],
        'autor': livro['autor'],
        'imagem': livro['imagem'],
        'preco': double.parse(livro['preco']),
        'quantidade': 1,
      });
    }

    notifyListeners();
  }

  void aumentarQtd(String id) {
    final index = itens.indexWhere((item) => item['id'] == id);
    itens[index]['quantidade']++;
    notifyListeners();
  }

  void diminuirQtd(String id) {
    final index = itens.indexWhere((item) => item['id'] == id);

    if (itens[index]['quantidade'] > 1) {
      itens[index]['quantidade']--;
    } else {
      itens.removeAt(index);
    }

    notifyListeners();
  }

  void removerItem(String id) {
    itens.removeWhere((item) => item['id'] == id);
    notifyListeners();
  }

  double subtotal() {
    return itens.fold(
      0.0,
      (soma, item) => soma + (item['preco'] * item['quantidade']),
    );
  }

  double frete() {
    return 15.70; // valor fixo igual ao do design
  }

  double total() {
    return subtotal() + frete();
  }
}
