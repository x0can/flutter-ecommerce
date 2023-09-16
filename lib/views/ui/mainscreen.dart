// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/mainscreen_provider.dart';
import 'package:food_delivery/views/shared/bottom_nav.dart';
import 'package:food_delivery/views/shared/bottom_nav_widget.dart';
import 'package:food_delivery/views/ui/cartpage.dart';
import 'package:food_delivery/views/ui/homepage.dart';
import 'package:food_delivery/views/ui/profile.dart';
import 'package:food_delivery/views/ui/searchpage.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pageList = const [
    HomePage(),
    SearchPage(),
    HomePage(),
    CartPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
