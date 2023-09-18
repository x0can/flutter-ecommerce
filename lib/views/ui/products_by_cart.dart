import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/models/sneakers_model.dart';
import 'package:food_delivery/services/helper.dart';
import 'package:food_delivery/views/shared/appstyle.dart';
import 'package:food_delivery/views/shared/custom_spacers.dart';
import 'package:food_delivery/views/shared/latest_shoes.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({super.key});

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

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
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/top_image.png"),
                      fit: BoxFit.fill)),
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
                          onTap: () {},
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
                  LatestShoes(male: _kids),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.82,
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
                    )
                  ]),
                )
              ]),
            ));
  }
}
