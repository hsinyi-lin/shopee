import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/db_helper.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});
  
  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Map<String, dynamic>> itemList = [];


  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    List<Map<String, dynamic>> cartItems = await DBHelper.instance.getCartItems();
    setState(() {
      itemList = cartItems;

      for (int i = 0; i < itemList.length; i++) {
        quantityMap[i] = itemList[i]['quantity']; 
      }
    });
  }

  // 儲存checkbox狀態的Map
  Map<int, bool> checkedMap = {};

  // 儲存商品數量狀態的Map
  Map<int, int> quantityMap = {};

  bool switchValue = false;

  void handleSwitchValueChanged(bool newValue) {
    setState(() {
      switchValue = newValue; 
    });
  }

  double calculateTotalAmount() {
    double totalAmount = 0;
    for (int i = 0; i < itemList.length; i++) {
      if (checkedMap[i] == true) {
        final quantity = quantityMap[i];
        if (quantity != null) {
          totalAmount += itemList[i]['price'] * quantity;
        }
      }
    }
    return totalAmount;
  }

  bool selectAllValue = false;

  void handleSelectAll(bool newValue) {
    setState(() {
      selectAllValue = newValue;

      for (int i = 0; i < itemList.length; i++) {
        checkedMap[i] = newValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.orange),
        title: const Text(
          '購物車',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                '編輯',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chat_outlined, color: Colors.orange),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: const Color.fromARGB(255, 255, 255, 208),
            padding: const EdgeInsets.all(12),
            child: const Row(
              children: [
                Icon(Icons.shopping_cart, color: Colors.orange),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '點選下方，選擇適用優惠券及免運券，即可享受更多折扣和優惠！',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                    maxLines: null,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (!checkedMap.containsKey(index)) {
                    checkedMap[index] = false;
                  }
                  if (!quantityMap.containsKey(index)) {
                    quantityMap[index] = 1;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(2, 0, 10, 0),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.grey,
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    side: const BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                              child: Checkbox(
                                value: checkedMap[index] ?? false,
                                onChanged: (newValue) {
                                  setState(() {
                                    checkedMap[index] = newValue!;
                                  });
                                },
                                activeColor: Colors.orange,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Image.asset(
                              'assets/images/good.png', 
                              width: 50, 
                              height: 50, 
                            ),
                            const SizedBox(width: 8), 
                            Text(
                              itemList[index]['storeName'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey, 
                            ),
                            const Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '編輯',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 0.2,
                        color: Color.fromARGB(255, 198, 198, 198)
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.grey,
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    side: const BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                              child: Checkbox(
                                value: checkedMap[index] ?? false,
                                onChanged: (newValue) {
                                  setState(() {
                                    checkedMap[index] = newValue!;
                                  });
                                },
                                activeColor: Colors.orange, 
                              ),
                            ),
                            Image.asset(
                              itemList[index]['image'],
                              width: 80,
                              height: 80,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    itemList[index]['productName'],
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '\$${NumberFormat('#,##0').format(itemList[index]['price'])}',
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    constraints: const BoxConstraints(
                                        maxWidth: 100), 
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (quantityMap[index]! > 1) {
                                                quantityMap[index] = quantityMap[index]! - 1;
                                                DBHelper.instance.updateCartItemQuantity(itemList[index]['productName'], quantityMap[index]!);
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            child: const Icon(Icons.remove, size: 14, color: Colors.grey),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Container(
                                          width: 20,
                                          alignment: Alignment.center,
                                          child: Text(
                                            quantityMap[index].toString(),
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              quantityMap[index] = quantityMap[index]! + 1;
                                              DBHelper.instance.updateCartItemQuantity(itemList[index]['productName'], quantityMap[index]!);
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            child: const Icon(Icons.add, size: 14, color: Colors.orange),
                                          ),
                                        ),
                                      ],
                                    ),     
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 0.2,
                        color: Color.fromARGB(255, 198, 198, 198)
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/coupon.png',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '請輸入賣場優惠券代碼',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey, 
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Colors.grey, 
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 0.2,
                        color: Color.fromARGB(255, 198, 198, 198)
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        padding: const EdgeInsets.all(8),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/trunk.png',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '滿999，7-ELEVEN,蝦皮店到店,中華郵政，免運費',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/coupon.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '優惠券',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      const Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '選擇優惠券',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey, 
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0.2,
                  color: Color.fromARGB(255, 198, 198, 198),
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/coin.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '尚未選擇商品',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Switch(
                              value: switchValue,
                              onChanged: handleSwitchValueChanged,
                              activeColor: Colors.orange, 
                              inactiveThumbColor: Colors.grey,
                              activeTrackColor:
                                  Colors.orangeAccent,
                              inactiveTrackColor:
                                  Colors.grey[300], 
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0.2,
                  color: Color.fromARGB(255, 198, 198, 198),
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor: Colors.grey,
                          checkboxTheme: CheckboxThemeData(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        child: Checkbox(
                          value: selectAllValue,
                          onChanged: (newValue) {
                            handleSelectAll(newValue ?? false);
                          },
                          activeColor: Colors.orange,
                        ),
                      ),
                      const Text(
                        '全選',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        '總金額：', 
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '\$${(calculateTotalAmount() ?? 0).toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                          ),
                          child: const Center(
                            child: Text(
                              '去買單',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0.2,
                  color: Color.fromARGB(255, 198, 198, 198),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
