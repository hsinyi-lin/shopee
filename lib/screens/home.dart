import 'package:flutter/material.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/product_list.dart';
import 'shopping_cart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '零食',
                      hintStyle: const TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200], 
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.camera_alt_outlined),
                        onPressed: () {
                         
                        },
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, color: Colors.orange),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShoppingCartScreen()), // 跳转到购物车页面
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chat_outlined, color: Colors.orange),
                  onPressed: () {
                    
                  },
                ),
              ],
            ),
          ),
          // 商品列表區域
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5), 
              child: ProductList(),
            ),
          ),
          // 底部導覽列
          CustomBottomNavigationBar(
            currentIndex: 0,
            onTap: (int index) {
              _onBottomNavBarItemTapped(context, index);
            },
          ),
        ],
      ),
    );
  }

  void _onBottomNavBarItemTapped(BuildContext context, int index) {
    CustomBottomNavigationBar(currentIndex: index, onTap: (int index) {}).onItemTapped(index, context);
  }
}
