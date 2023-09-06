import 'package:coffeeshop/repository/drinks/drinks_repository.dart';
import 'package:coffeeshop/widgets/items_widget.dart';
import 'package:flutter/material.dart';

import '../repository/drinks/models/item.dart';
import '../widgets/home_bottom_bar.dart';

class DrinksCatalogScreen extends StatefulWidget {
  @override
  State<DrinksCatalogScreen> createState() => _DrinksCatalogScreenState();
}

class _DrinksCatalogScreenState extends State<DrinksCatalogScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Item> _drinks = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    _initData();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  Future<void> _initData() async {
    final drinks = await DrinksRepository().getDrinks();
    setState(() {
      _drinks = drinks;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.sort_rounded,
                        color: Colors.white.withOpacity(0.5),
                        size: 35,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white.withOpacity(0.5),
                        size: 35,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'It`s a Great Day for Coffee!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 50, 54, 56),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Find your coffee',
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.5)),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.white.withOpacity(0.5),
                        ))),
              ),
              TabBar(
                  controller: _tabController,
                  labelColor: Color(0xFFE57734),
                  unselectedLabelColor: Colors.white.withOpacity(0.5),
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 3,
                        color: Color(0xFFE57734),
                      ),
                      insets: EdgeInsets.symmetric(horizontal: 16)),
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  labelPadding: EdgeInsets.symmetric(horizontal: 18),
                  tabs: [
                    Tab(text: "Hot Coffee"),
                    Tab(text: "Cold Coffee"),
                    Tab(text: "Tea"),
                    Tab(text: "Cacao"),
                  ]),
              SizedBox(
                height: 10,
              ),
              Center(
                child: [
                  ItemsWidget(_drinks),
                  ItemsWidget(_drinks),
                  ItemsWidget(_drinks),
                  ItemsWidget(_drinks),
                ][_tabController.index],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomBar(),
    );
  }
}
