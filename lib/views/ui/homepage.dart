import 'package:ant_icons/ant_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/sneakers_model.dart';
import 'package:food_delivery/services/helper.dart';
import 'package:food_delivery/views/shared/appstyle.dart';
import 'package:food_delivery/views/shared/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;

  

  void getFemale() {
    _female = Helper().getMaleSneakers();
  }

  void getKids() {
    _kids = Helper().getMaleSneakers();
  }

  @override
  Widget build(BuildContext context) {
    _male = Helper().getMaleSneakers();

    return Scaffold(
        backgroundColor: const Color(0xFFE2e2e2),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/top_image.png'),
                      fit: BoxFit.fill)),
              child: Container(
                padding: EdgeInsets.only(left: 8, bottom: 15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Athletics shoes',
                      style: appStyleWithHeight(
                          42, Colors.white, FontWeight.bold, 1.5),
                    ),
                    Text(
                      'Collection',
                      style: appStyleWithHeight(
                          42, Colors.white, FontWeight.bold, 1.2),
                    ),
                    TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Colors.transparent,
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Colors.white,
                        labelStyle: appStyle(24, Colors.white, FontWeight.bold),
                        unselectedLabelColor: Colors.grey.withOpacity(0.3),
                        tabs: const [
                          Tab(
                            text: 'Mens Shoes',
                          ),
                          Tab(
                            text: 'Women Shoes',
                          ),
                          Tab(
                            text: 'Kids Shoes',
                          )
                        ]),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.265),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: TabBarView(controller: _tabController, children: [
                  Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.424,
                          child: FutureBuilder<List<Sneakers>>(
                            future: _male,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                print('error');
                                return Text("Error ${snapshot.error}");
                              } else {
                                final male = snapshot.data;
                                return ListView.builder(
                                    itemCount: male!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final shoe = snapshot.data![index];
                                      return  ProductCard(
                                          price: shoe.price,
                                          category: shoe.category,
                                          id: shoe.id,
                                          name:shoe.name,
                                          image:shoe.imageUrl[0]
                                              );
                                    });
                              }
                            },
                          )),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Latest shoes',
                                  style: appStyle(
                                      24, Colors.black, FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Show All',
                                      style: appStyle(
                                          22, Colors.black, FontWeight.bold),
                                    ),
                                    const Icon(
                                      AntIcons.caret_right,
                                      size: 20,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 0.8,
                                            spreadRadius: 1,
                                            offset: Offset(0, 1))
                                      ]),
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  width:
                                      MediaQuery.of(context).size.width * 0.28,
                                  child: CachedNetworkImage(
                                      imageUrl:
                                          'https://img.freepik.com/premium-photo/fashion-running-sneaker-shoes-isolated-white_47469-442.jpg'),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.405,
                        color: Colors.green,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.405,
                        color: Colors.red,
                      )
                    ],
                  )
                ]),
              ),
            )
          ]),
        ));
  }
}
