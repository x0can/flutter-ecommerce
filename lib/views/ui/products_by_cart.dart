import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/models/sneakers_model.dart';
import 'package:food_delivery/services/helper.dart';
import 'package:food_delivery/views/shared/appstyle.dart';
import 'package:food_delivery/views/shared/category_btn.dart';
import 'package:food_delivery/views/shared/custom_spacers.dart';
import 'package:food_delivery/views/shared/latest_shoes.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({super.key, required this.tabIndex});
  final int tabIndex;
  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this, initialIndex: widget.tabIndex);

  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;

  void getMale() {
    _male = Helper().getMaleSneakers();
  }

  void getFemale() {
    _female = Helper().getFeMaleSneakers();
  }

  void getKids() {
    _kids = Helper().getKidsSneakers();
  }

  @override
  void initState() {
    super.initState();
    getMale();
    getFemale();
    getKids();
  }

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2e2e2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(color: Colors.black),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            AntIcons.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(
                            FontAwesomeIcons.slidersH,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.175,
                  left: 16,
                  right: 12),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: TabBarView(controller: _tabController, children: [
                  LatestShoes(male: _male),
                  LatestShoes(male: _female),
                  LatestShoes(
                    male: _kids,
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double _value = 100;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.84,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 5,
                  width: 40,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.black),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(children: [
                    const CustomSpacer(),
                    Text(
                      'Filter',
                      style: appStyle(40, Colors.black, FontWeight.bold),
                    ),
                    const CustomSpacer(),
                    Text(
                      'Gender',
                      style: appStyle(20, Colors.black, FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        CategoryBtn(buttonClr: Colors.black, label: 'Men'),
                        CategoryBtn(buttonClr: Colors.grey, label: 'Women'),
                        CategoryBtn(buttonClr: Colors.grey, label: 'Kids'),
                      ],
                    ),
                    CustomSpacer(),
                    Text(
                      'Category',
                      style: appStyle(20, Colors.black, FontWeight.bold),
                    ),
                    CustomSpacer(),
                    Row(
                      children: [
                        CategoryBtn(buttonClr: Colors.black, label: 'Shoes'),
                        CategoryBtn(buttonClr: Colors.grey, label: 'Apparels'),
                        CategoryBtn(
                            buttonClr: Colors.grey, label: 'Accessories'),
                      ],
                    ),
                    CustomSpacer(),
                    Text(
                      'price',
                      style: appStyle(20, Colors.black, FontWeight.bold),
                    ),
                    const CustomSpacer(),
                    Slider(
                        value: _value,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.black,
                        max: 500,
                        divisions: 50,
                        label: _value.toString(),
                        secondaryTrackValue: 200,
                        onChanged: (double value) {}),
                    CustomSpacer(),
                    Text(
                      'Brand',
                      style: appStyle(20, Colors.black, FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 80,
                      child: ListView.builder(
                        itemCount: brand.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Image.asset(brand[index]),
                              height: 60,
                              width: 80,
                            ),
                          );
                        },
                      ),
                    )
                  ]),
                )
              ]),
            ));
  }


}
