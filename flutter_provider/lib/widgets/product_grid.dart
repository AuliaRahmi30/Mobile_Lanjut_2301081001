import 'package:flutter/material.dart';
import 'package:flutter_provider/providers/all_product.dart';
import 'package:flutter_provider/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mengambil data produk dari Provider
    final productData = Provider.of<Products>(context);
    final allProducts = productData.allProducts;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: allProducts.length,
      itemBuilder: (ctx, i) => ProductItem(
        allProducts[i].id!,          // Pastikan id tidak null
        allProducts[i].title!,       // Pastikan title tidak null
        allProducts[i].imageUrl!,    // Pastikan imageUrl tidak null
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
