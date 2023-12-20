import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../global_widgets/custom_drawer.dart';
import '../widgets/home_appbar.dart';
import '../widgets/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const HomeAppBar(),
      body: const HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
