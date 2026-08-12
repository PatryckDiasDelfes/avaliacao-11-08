import 'package:avaliacao_componentizacao_stateful_controller/widgets/add_to_beg_button.dart';
import 'package:avaliacao_componentizacao_stateful_controller/controllers/ProductController.dart';
import 'package:avaliacao_componentizacao_stateful_controller/widgets/price_summary.dart';
import 'package:avaliacao_componentizacao_stateful_controller/widgets/product_card.dart';
import 'package:avaliacao_componentizacao_stateful_controller/widgets/quantity_selector.dart';
import 'package:avaliacao_componentizacao_stateful_controller/widgets/size_selector.dart';
import 'package:avaliacao_componentizacao_stateful_controller/widgets/text_style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevsEcomm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F1F6),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ProductPage(),
    );
  }
}

//Pagina
class ProductPage extends StatefulWidget {
  ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductController controller = ProductController();

  @override
  Widget build(BuildContext context) {
    final double subtotal = controller.product.price * controller.quantity;
    return Scaffold(
      backgroundColor: const Color(0xFFF9F1F6),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F1F6),
        title: Text(
          controller.product.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE9DCE6)),
                ),

                //Aonde chamo meu productCard
                child: productCard(
                  product: controller.product,
                  isFavorite: controller.isFavorite,
                  onFavorite: () {
                    setState(() {
                      controller.toggleFavorite();
                    });
                  },
                ),
              ),

              const SizedBox(height: 24),

              //Aonde chamo os textos estilizados
              textStyle(label: 'Tamanho'),

              //Aonde chamo a caixa que me informa o tamanho da peça
              const SizedBox(height: 12),
              SizeSelector(
                product: controller.product,
                selectedSize: controller.selectedSize,
                onSizeSelected: (String value) {
                  setState(() {
                    controller.selectSize(value);
                  });
                },
              ),

              //Aonde chamo os textos estilizados
              const SizedBox(height: 28),
              textStyle(label: 'Quantidade'),

              //Aonde chamo a caixa de seleção de quantidade
              const SizedBox(height: 12),
              quantitySelector(
                quantity: controller.quantity,
                onIncrease: () {
                  setState(() {
                    controller.increaseQuantity();
                  });
                },
                onDecrease: () {
                  setState(() {
                    controller.decreaseQuantity();
                  });
                },
              ),

              //Caixa aonde faço as somas de quantidade*valorPeça
              const SizedBox(height: 28),
              PriceSummary(subtotal: subtotal),
            ],
          ),
        ),
      ),

      //Bottão de adcionar na sacola
      bottomNavigationBar: AddToBegButton(
        quantity: controller.quantity,
        onPressed: () {
          controller.addToCart();
        },
      ),
    );
  }
}
