import 'package:flutter/material.dart';
import 'package:avaliacao_componentizacao_stateful_controller/models/Product.dart';

class ProductController {
  final Product product = const Product(
    name: 'Camiseta +DevsEcomm',
    price: 129.90,
    icon: Icons.checkroom,
    availableSizes: ['PP', 'P', 'M', 'G', 'GG'],
  );

  String selectedSize = 'M';
  int quantity = 0;
  bool isFavorite = true;

  void increaseQuantity() {
    quantity++;
  }

  void decreaseQuantity() {
    if (quantity > 0) {
      quantity--;
    }
  }

  void selectSize(String size) {
    selectedSize = size;
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }

  double multiplySubtotal(double price, int quantity) {
    return price * quantity;
  }
  //double subtotal = multiplySubtotal(product.price, quantity);

  void addToCart() {}
}
