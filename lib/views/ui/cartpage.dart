import 'package:ant_icons/ant_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_delivery/views/shared/appstyle.dart';
import 'package:food_delivery/views/shared/checkout_btn.dart';
import 'package:hive/hive.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final _cartBox = Hive.box('cart_box');

  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    _cartBox.put('cart_box', {
      "id": "0",
      "name": "Ultraboost Shoes",
      "category": "Men's Running",
      "imageUrl": [
        "https://media.istockphoto.com/id/953795296/photo/close-up-view-of-black-sport-running-and-fitness-shoe-sneakers-or-trainers-isolated-on-a-white.webp?b=1&s=170667a&w=0&k=20&c=WfvW62adXX3L28CuBN542rgpBWAixALZEkxhl_zleTc=",
        "https://media.istockphoto.com/id/953795296/photo/close-up-view-of-black-sport-running-and-fitness-shoe-sneakers-or-trainers-isolated-on-a-white.webp?b=1&s=170667a&w=0&k=20&c=WfvW62adXX3L28CuBN542rgpBWAixALZEkxhl_zleTc=",
        "https://media.istockphoto.com/id/953795296/photo/close-up-view-of-black-sport-running-and-fitness-shoe-sneakers-or-trainers-isolated-on-a-white.webp?b=1&s=170667a&w=0&k=20&c=WfvW62adXX3L28CuBN542rgpBWAixALZEkxhl_zleTc=",
        "https://media.istockphoto.com/id/953795296/photo/close-up-view-of-black-sport-running-and-fitness-shoe-sneakers-or-trainers-isolated-on-a-white.webp?b=1&s=170667a&w=0&k=20&c=WfvW62adXX3L28CuBN542rgpBWAixALZEkxhl_zleTc="
      ],
      "oldPrice": "1899.00",
      "sizes": [
        {"size": "6.0", "isSelected": false},
        {"size": "6.5", "isSelected": false},
        {"size": "7.0", "isSelected": false},
        {"size": "7.5", "isSelected": false},
        {"size": "8.0", "isSelected": false},
        {"size": "8.5", "isSelected": false},
        {"size": "9.0", "isSelected": false}
      ],
      "price": "79.0",
      "description": "Put some pep in your step with the new adidas",
      "title": "Adidas Running shoes with cooling ventilations",
      "qty": 1
    });
    final item = _cartBox.get('cart_box');
    var cartData = {
      "id": item['id'],
      "category": item['category'],
      "name": item['name'],
      "imageUrl": item['imageUrl'],
      "price": item['price'],
      "qty": item['qty'],
      "sizes": item['sizes']
    };

    cart = [cartData, cartData];

    return Scaffold(
      backgroundColor: const Color(0xFFE2e2e2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  AntIcons.close,
                  color: Colors.black,
                ),
              ),
              Text(
                "My Cart",
                style: appStyle(36, Colors.black, FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: ListView.builder(
                    itemCount: cart.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final data = cart[index];
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: doNothing,
                                    backgroundColor: const Color(0xFF000000),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade500,
                                          spreadRadius: 5,
                                          blurRadius: 0.3,
                                          offset: Offset(0, 1))
                                    ]),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(12),
                                            child: CachedNetworkImage(
                                              imageUrl: data['imageUrl'][0],
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 12, left: 20),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data['name'],
                                                    style: appStyle(
                                                        16,
                                                        Colors.black,
                                                        FontWeight.bold),
                                                  ), 
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    data['category'],
                                                    style: appStyle(
                                                        14,
                                                        Colors.grey,
                                                        FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        data['price'],
                                                        style: appStyle(
                                                            18,
                                                            Colors.black,
                                                            FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(16))),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {},
                                                    child: const Icon(
                                                      AntIcons.minus_square,
                                                      size: 20,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    data['qty'].toString(),
                                                    style: appStyle(
                                                        16,
                                                        Colors.black,
                                                        FontWeight.bold),
                                                  ),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: const Icon(
                                                      AntIcons.plus_square,
                                                      size: 20,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ]),
                              ),
                            )),
                      );
                    }),
              )
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CheckoutButton(label: "Proceed to checkout"),
          ),
        ]),
      ),
    );
  }

  void doNothing(BuildContext context) {}
}
