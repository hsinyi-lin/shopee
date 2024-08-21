import 'package:flutter/material.dart';
import '../utils/db_helper.dart';

import 'product_card.dart';


class ProductList extends StatelessWidget {
  ProductList({super.key});

  final DBHelper dbHelper = DBHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.getAllProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> products = snapshot.data ?? [];
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(product: products[index]);
              },
            );
          }
        },
      ),
    );
  }
}
