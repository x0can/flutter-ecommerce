import 'package:ant_icons/ant_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery/controllers/product_provider.dart';
import 'package:food_delivery/models/sneakers_model.dart';
import 'package:food_delivery/services/helper.dart';
import 'package:food_delivery/views/shared/appstyle.dart';
import 'package:food_delivery/views/shared/checkout_btn.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});

  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  late Future<Sneakers> _sneaker;

  void getShoes() {
    if (widget.category == "Men's Running") {
      _sneaker = Helper().getMaleSneakersById(widget.id);
    } else if (widget.category == "Women's RUnning") {
      _sneaker = Helper().getfeMaleSneakersById(widget.id);
    } else {
      _sneaker = Helper().getKidsSneakersById(widget.id);
    }
  }

  @override
  void initState() {
    super.initState();
    getShoes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Sneakers>(
        future: _sneaker,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final sneaker = snapshot.data;
            return Scaffold(
                backgroundColor: const Color(0xFFE2e2e2),
                body: Consumer<ProductNotifier>(
                    builder: (context, productNotifier, child) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        leadingWidth: 0,
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    productNotifier.shoeSizes.clear();
                                  },
                                  child: const Icon(
                                    AntIcons.close,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: null,
                                  child: const Icon(
                                    AntIcons.ellipsis,
                                    color: Colors.black,
                                  ),
                                )
                              ]),
                        ),
                        pinned: true,
                        snap: false,
                        floating: true,
                        backgroundColor: Colors.transparent,
                        expandedHeight: MediaQuery.of(context).size.height,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sneaker!.imageUrl.length,
                                  controller: pageController,
                                  onPageChanged: (page) {
                                    productNotifier.activePage = page;
                                  },
                                  itemBuilder: (context, int index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.39,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.grey.shade300,
                                          child: CachedNetworkImage(
                                            imageUrl: sneaker.imageUrl[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          right: 20,
                                          child: const Icon(
                                            AntIcons.heart_outline,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          left: 0,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.32,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: List<Widget>.generate(
                                                  sneaker.imageUrl.length,
                                                  (index) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 4),
                                                        child: CircleAvatar(
                                                          radius: 5,
                                                          backgroundColor:
                                                              productNotifier
                                                                          .activepage !=
                                                                      index
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                      ))),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                            Positioned(
                                bottom: 62,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.645,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              sneaker.name,
                                              style: appStyle(40, Colors.black,
                                                  FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  sneaker.category,
                                                  style: appStyle(
                                                      20,
                                                      Colors.grey,
                                                      FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                RatingBar.builder(
                                                    initialRating: 4,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 22,
                                                    itemPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 1),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                          Icons.star,
                                                          size: 18,
                                                          color: Colors.black,
                                                        ),
                                                    onRatingUpdate: (rating) {})
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "\$${sneaker.price}",
                                                  style: appStyle(
                                                      18,
                                                      Colors.black,
                                                      FontWeight.bold),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Colors",
                                                      style: appStyle(
                                                          18,
                                                          Colors.black,
                                                          FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor:
                                                          Colors.black,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor:
                                                          Colors.red,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Select sizes",
                                                      style: appStyle(
                                                          20,
                                                          Colors.black,
                                                          FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      "View size guide",
                                                      style: appStyle(
                                                          20,
                                                          Colors.grey,
                                                          FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  child: ListView.builder(
                                                      itemCount: 3,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      padding: EdgeInsets.zero,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final sizes =
                                                            productNotifier
                                                                    .shoeSizes[
                                                                index];

                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          child: ChoiceChip(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            60)),
                                                            disabledColor:
                                                                Colors.white,
                                                            side: const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 1,
                                                                style:
                                                                    BorderStyle
                                                                        .solid),
                                                            selected: sizes[
                                                                'isSelected'],
                                                            onSelected:
                                                                (newState) {
                                                              if (productNotifier
                                                                  .sizes
                                                                  .contains(sizes[
                                                                      'size'])) {
                                                                productNotifier
                                                                    .sizes
                                                                    .remove(sizes[
                                                                        'size']);
                                                              } else {
                                                                productNotifier
                                                                    .sizes
                                                                    .add(sizes[
                                                                        'size']);
                                                              }
                                                              print(
                                                                  productNotifier
                                                                      .sizes);
                                                              productNotifier
                                                                  .toggleCheck(
                                                                      index);
                                                            },
                                                            label: Text(
                                                              sizes['size'],
                                                              style: appStyle(
                                                                  18,
                                                                  sizes['isSelected']
                                                                      ? const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          15,
                                                                          14,
                                                                          14)
                                                                      : const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          137,
                                                                          136,
                                                                          136),
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(
                                              indent: 10,
                                              endIndent: 10,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: Text(
                                                sneaker.title,
                                                style: appStyle(
                                                    26,
                                                    Colors.black,
                                                    FontWeight.w700),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              sneaker.description,
                                              textAlign: TextAlign.justify,
                                              maxLines: 4,
                                              style: appStyle(14, Colors.black,
                                                  FontWeight.normal),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 12),
                                                child: CheckoutButton(
                                                  label: "Add to Cart",
                                                  onTap: () async {
                                                    _createCart({
                                                      "id": sneaker.id,
                                                      "name": sneaker.name,
                                                      "category":
                                                          sneaker.category,
                                                      "sizes":
                                                          productNotifier.sizes,
                                                      "imageUrl":
                                                          sneaker.imageUrl[0],
                                                      "price": sneaker.price,
                                                      "qty": 1
                                                    });
                                                  },
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                ))
                          ]),
                        ),
                      )
                    ],
                  );
                }));
          }
        });
  }
}
