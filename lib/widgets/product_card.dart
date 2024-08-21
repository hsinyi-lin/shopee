import 'package:flutter/material.dart';
import '../utils/db_helper.dart';

import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  child: Image.asset(
                    product['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['productName'],
                        style: const TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '\$${NumberFormat('#,###').format(product['price'])}',
                            style: TextStyle(
                                fontSize: 17, color: Colors.orange[600]),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '已售 ${product['soldCnt']}',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 2,
                    right: -1,
                    child: IconButton(
                      icon: const Icon(Icons.add_box_outlined),
                      color: Colors.orange, 
                      onPressed: () async {
                        DBHelper.instance.addToCart(product);
                        await Future.delayed(const Duration(seconds: 1));
                        List<Map<String, dynamic>> cartItems = await DBHelper.instance.getCartItems();
                        print(cartItems);
                      },
                    )),
                Positioned(
                  top: -196,
                  left: -3.5,
                  child: Image.asset(
                    'assets/images/sticker.png',
                    width: 50,
                    height: 50,
                  ),
                ),
                Positioned(
                  top: -56.5,
                  left: -0.5,
                  child: Image.asset(
                    'assets/images/free_shipping.png',
                    width: 90,
                    height: 90,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
